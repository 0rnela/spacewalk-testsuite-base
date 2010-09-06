Given /^I am on the Systems page$/ do
  Given "I am authorized"
  within(:xpath, "//div[@id=\"mainNavWrap\"]") do
    find_link("Systems").click
  end
end

Given /cobblerd is running/ do
  ct = CobblerTest.new()
  if ! ct.is_running
      raise "cobblerd is not running"
  end
end

Then /create distro "([^"]*)" as user "([^"]*)" with password "([^"]*)"/ do |arg1,arg2,arg3|
  ct = CobblerTest.new("g35.suse.de")
  ct.login(arg2,arg3)
  if ct.distro_exists( arg1 )
      raise "distro " + arg1 + " already exists"
  end
  ct.distro_create( arg1, "/install/SLES11-SP1-x86_64/DVD1/boot/x86_64/loader/linux", "/install/SLES11-SP1-x86_64/DVD1/boot/x86_64/loader/initrd")
end

Given /distro "([^"]*)" exists/ do |arg1|
  ct = CobblerTest.new("g35.suse.de")
  if ! ct.distro_exists( arg1 )
      raise "distro " + arg1 + " does not exist"
  end
end

Then /create profile "([^"]*)" as user "([^"]*)" with password "([^"]*)"/ do |arg1,arg2,arg3|
  ct = CobblerTest.new("g35.suse.de")
  ct.login(arg2,arg3)
  if ct.profile_exists( arg1 )
      raise "profile " + arg1 + " already exists"
  end
  ct.profile_create( "testprofile", "testdistro", "/install/empty.xml" )
end

Given /profile "([^"]*)" exists/ do |arg1|
  ct = CobblerTest.new("g35.suse.de")
  if ! ct.profile_exists( arg1 )
      raise "profile " + arg1 + " does not exist"
  end
end
