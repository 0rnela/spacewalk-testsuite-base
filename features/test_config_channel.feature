# Copyright (c) 2010-2011 Novell, Inc.
# Licensed under the terms of the MIT license.

Feature: Create a configuration channel
  In Configuration
  As the admin user
  I want to create a configuration channel

  Scenario: Successfully create configuration channel
    Given I am testing configuration
    When I follow "Create a New Configuration Channel"
     And I enter "New Test Channel" as "cofName"
     And I enter "newtestchannel" as "cofLabel"
     And I enter "This is a test channel" as "cofDescription"
     And I click on "Create Config Channel"
    Then I should see a "Test Channel" text
     And I should see a "Add Files" link
     And I should see a "Systems" link
     And I should see a "Edit Properties" link
     And I should see a "Configuration Actions" text
     And I should see a "Add/Create Files" text
     And I should see a "Create new configuration file or directory" link
     And I should see a "Upload configuration files" link
     And I should see a "Import a file from another channel or system" link
     And I should see a "delete channel" link

  Scenario: Add a config file to newtestchannel
    Given I am testing configuration
    When I follow "Configuration Channels" in the left menu
     And I follow "New Test Channel"
     And I follow "Create new configuration file or directory"
     And I enter "/etc/mgr-test-file.cnf" as "cffPath"
     And I enter "MGR_PROXY='yes'" as "contents"
     And I click on "Create Configuration File"
    Then I should see a "Revision 1 of /etc/mgr-test-file.cnf from channel New Test Channel" text
     And I should see a "Update Configuration File" button

  Scenario: Subscribe system to channel
   Given I am on the Systems overview page of this client
    When I follow "Configuration" in class "content-nav"
     And I follow "Manage Configuration Channels" in class "contentnav-row2"
     And I follow "Subscribe to Channels" in class "content-nav"
     And I check "New Test Channel" in the list
     And I click on "Continue"
     And I click on "Update Channel Rankings"
    Then I should see a "Channel Subscriptions successfully changed for" text

  Scenario: Check Centrally Managed Files
    Given I am testing configuration
    When I follow "Configuration Files" in the left menu
    Then I should see a table line with "/etc/mgr-test-file.cnf", "New Test Channel", "1 system"

  Scenario: Check Centrally Managed Files of this client
   Given I am on the Systems overview page of this client
    When I follow "Configuration" in class "content-nav"
     And I follow "View/Modify Files" in class "contentnav-row2"
     And I follow "Centrally-Managed Files" in class "content-nav"
    Then I should see a table line with "/etc/mgr-test-file.cnf", "New Test Channel", "Revision 1"

  Scenario: Deploy Centrally Managed Files
   Given I am testing configuration
     And I follow "Configuration Channels" in the left menu
     And I follow "New Test Channel"
     And I follow "Deploy all configuration files to all subscribed systems"
    Then I should see a "/etc/mgr-test-file.cnf" link
     And I should see this client as a link
    When I click on "Deploy Files to Selected Systems"
    Then I should see a "1 revision-deploy successfully scheduled." text
     And I should see a "0 revision-deploys overridden." text

  Scenario: Check File deployment
    Given I am root
     When I run rhn_check on this client
     Then On this client the File "/etc/mgr-test-file.cnf" should exists
      And On this client the File "/etc/mgr-test-file.cnf" should have the content "MGR_PROXY='yes'"

  Scenario: Change local file and compare
    Given I am root
     When I change the local file "/etc/mgr-test-file.cnf" to "MGR_PROXY='no'"
    Given I am on the Systems overview page of this client
    When I follow "Configuration" in class "content-nav"
     And I follow "Compare Files" in class "contentnav-row2"
     And I check "/etc/mgr-test-file.cnf" text in the list
     And I click on "Compare Files"
     And I click on "Schedule Compare"
    Then I should see a "1 files scheduled for comparison." text
    When I run rhn_check on this client
     And I wait for "2" seconds
     And I follow "Events" in class "content-nav"
     And I follow "History" in class "contentnav-row2"
    Then I should see a "Show differences between profiled config files and deployed config files scheduled by admin" link
    When I follow "Show differences between profiled config files and deployed config files"
    Then I should see a "Differences exist" link

  Scenario: Import the changed file
   Given I am on the Systems overview page of this client
    When I follow "Configuration" in class "content-nav"
     And I follow "Add Files" in class "contentnav-row2"
     And I follow "Import Files" in class "content-nav"
     And I check "/etc/mgr-test-file.cnf" text in the list
     And I click on "Import Configuration Files"
     And I click on "Confirm"
    Then I should see a "1 files scheduled for upload." text
    When I run rhn_check on this client
     And I wait for "2" seconds
     And I follow "Configuration" in class "content-nav"
     And I follow "View/Modify Files" in class "contentnav-row2"
     And I follow "Local Sandbox" in class "content-nav"
    Then I should see a table line with "/etc/mgr-test-file.cnf", "Revision 1"

  Scenario: Import the changed file
   Given I am on the Systems overview page of this client
    When I follow "Configuration" in class "content-nav"
     And I follow "Add Files" in class "contentnav-row2"
     And I follow "Import Files" in class "content-nav"
     And I enter "/etc/sysconfig/boot" as "contents"
     And I click on "Import Configuration Files"
     And I click on "Confirm"
    Then I should see a "1 files scheduled for upload." text
    When I run rhn_check on this client
     And I wait for "2" seconds
     And I follow "Configuration" in class "content-nav"
     And I follow "View/Modify Files" in class "contentnav-row2"
     And I follow "Local Sandbox" in class "content-nav"
    Then I should see a table line with "/etc/sysconfig/boot", "Revision 1"

  Scenario: Copy Sandbox file to Centrally-Managed
    Given I am on the Systems overview page of this client
     When I follow "Configuration" in class "content-nav"
      And I follow "View/Modify Files" in class "contentnav-row2"
      And I follow "Local Sandbox" in class "content-nav"
      And I check "/etc/mgr-test-file.cnf" text in the list
      And I click on "Copy Latest to Central Channel"
      And I check "New Test Channel" in the list
      And I click on "Copy To Central Channels"
     Then I should see a "1 file copied into 1 central configuration channel" text
      And I should see a table line with "/etc/mgr-test-file.cnf", "Revision 2"


