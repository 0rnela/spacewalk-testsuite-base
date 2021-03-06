# Copyright (c) 2010-2017 SUSE-LINUX
# Licensed under the terms of the MIT license.

require 'nokogiri'
require 'timeout'

def client_is_zypp?
  $client.run('test -x /usr/bin/zypper', false)
end

def client_refresh_metadata
  if client_is_zypp?
    $client.run('zypper --non-interactive ref -s', true, 500, 'root')
  else
    $client.run('yum clean all', true, 600, 'root')
    $client.run('yum makecache', true, 600, 'root')
  end
end

def client_raw_repodata_dir(channel)
  if client_is_zypp?
    "/var/cache/zypp/raw/spacewalk:#{channel}/repodata"
  else
    "/var/cache/yum/#{channel}"
  end
end

def sle11family(node)
  _out, code = node.run('pidof systemd', false)
  return true if code.nonzero?
end

def client_system_id_to_i
  out, _code = $client.run('grep "ID" /etc/sysconfig/rhn/systemid | tr -d -c 0-9')
  out.gsub(/\s+/, '')
end

def check_shutdown(host, time_out)
  cmd = "ping -c1 #{host}"
  Timeout.timeout(time_out) do
    loop do
      _out = `#{cmd}`
      if $CHILD_STATUS.exitstatus.nonzero?
        puts "machine: #{host} went down"
        break
      end
      sleep 1
    end
  end
rescue Timeout::Error
  raise "Machine didn't reboot!"
end

def check_restart(host, node, time_out)
  cmd = "ping -c1 #{host}"
  Timeout.timeout(time_out) do
    loop do
      _out = `#{cmd}`
      if $CHILD_STATUS.exitstatus.zero?
        puts "machine: #{host} network is up"
        break
      end
      sleep 1
    end
    loop do
      _out, code = node.run('ls', false, 10)
      if code.zero?
        puts "machine: #{host} ssh is up"
        break
      end
      sleep 1
    end
  end
rescue Timeout::Error
  raise "ERR: Machine didn't Went-up!"
end

# Extract the os_version dynamically decoding the value in '/etc/os-release'
# e.g.: VERSION="12-SP1"
def get_os_version(node)
  os_version_raw, _code = node.run('grep "VERSION=" /etc/os-release')
  os_version = os_version_raw.strip.split('=')[1].delete '"'
  _out, code = node.run('pidof systemd', false)
  os_version if code.zero?
  # os-release for sles11 is not coherent with 12, so we need to add a SP postfix
  os_version.gsub(/\./, '-SP')
end
