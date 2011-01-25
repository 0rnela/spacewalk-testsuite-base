Feature: Clone a Channel
  In Order to validate the channel cloning feature
  As a testing user
  I want to clone a channel with errata, without errata and with selected erratas

  Scenario: Clone a Channel without errata
    Given I am on the manage software channels page
    When I follow "clone channel"
     And I select "SLES11-SP1-Updates x86_64 Channel" from "clone_from"
     And I choose "original" from "clone_type"
     And I click on "Create Channel"
     And I should see a "Software Channel: New Channel" text
     And I should see a "Original channel with no updates" text
     And I click on "Create Channel"
    Then I should see a "Clone of SLES11-SP1-Updates x86_64 Channel" text
 
  Scenario: Check, that this channel has no erratas
    Given I am on the manage software channels page
      And I follow "Clone of SLES11-SP1-Updates x86_64 Channel"
     When I follow "Patches" in class "content-nav"
      And I follow "List/Remove Patches"
     Then I should see a "There are no patches associated with this channel." text

  Scenario: Clone a Channel with errata
    Given I am on the manage software channels page
    When I follow "clone channel"
     And I select "SLES11-SP1-Updates x86_64 Channel" from "clone_from"
     And I choose "current" from "clone_type"
     And I click on "Create Channel"
     And I should see a "Software Channel: New Channel" text
     And I should see a "Current state of the channel" text
     And I click on "Create Channel"
    Then I should see a "Clone 2 of SLES11-SP1-Updates x86_64 Channel" text

  Scenario: Check, that this channel has erratas
    Given I am on the manage software channels page
      And I follow "Clone 2 of SLES11-SP1-Updates x86_64 Channel"
     When I follow "Patches" in class "content-nav"
      And I follow "List/Remove Patches"
     Then I should see a "CLssp1-kernel-3280-channel-x86_64" link
      And I should see a "CLssp1-suseRegister-2953-channel-x86_64" link
      And I should see a "CLssp1-aaa_base-sysvinit-2610-channel-x86_64" link

  Scenario: Clone a Channel with selected errata
    Given I am on the manage software channels page
    When I follow "clone channel"
     And I select "SLES11-SP1-Updates x86_64 Channel" from "clone_from"
     And I choose "select_errata" from "clone_type"
     And I click on "Create Channel"
     And I should see a "Software Channel: New Channel" text
     And I should see a "Select errata" text
     And I click on "Create Channel"
     And I should see a "Software Channel: Clone 3 of SLES11-SP1-Updates x86_64 Channel" text
     And I choose "Merge w/CLssp1-aaa_base-sysvinit-2610-channel-x86_64" for "slessp1-aaa_base-sysvinit-2610-channel-x86_64"
     And I choose "Clone as CLssp1-suseRegister-2953-channel-x86_64-1" for "slessp1-suseRegister-2953-channel-x86_64"
     And I choose "Do Nothing" for "slessp1-kernel-3280-channel-x86_64"
     And I click on "Clone Patches"
     And I click on "Update Patches"
     And I follow "List/Remove Patches"
    Then I should see a "CLssp1-suseRegister-2953-channel-x86_64-1" link
     And I should see a "CLssp1-aaa_base-sysvinit-2610-channel-x86_64" link

  Scenario: check new errata exists
    Given I am on the errata page
     When I follow "All" in the left menu
     Then I should see a "CLssp1-kernel-3280-channel-x86_64" link
      And I should see a "CLssp1-suseRegister-2953-channel-x86_64" link
      And I should see a "CLssp1-suseRegister-2953-channel-x86_64-1" link
      And I should see a "CLssp1-aaa_base-sysvinit-2610-channel-x86_64" link

  Scenario: check CLssp1-suseRegister-2953-channel-x86_64 errata
    Given I am on the "CLssp1-suseRegister-2953-channel-x86_64" errata Details page
     Then I should see a "CLssp1-suseRegister-2953-channel-x86_64 - Bug Fix Advisory" text
      And I should see a "maint-coord@suse.de" text
      And I should see a "bug number 546142" link
      And I should see a "restart_suggested" text

  Scenario: check CLssp1-suseRegister-2953-channel-x86_64-1 errata
    Given I am on the "CLssp1-suseRegister-2953-channel-x86_64-1" errata Details page
     Then I should see a "CLssp1-suseRegister-2953-channel-x86_64-1 - Bug Fix Advisory" text
      And I should see a "maint-coord@suse.de" text
      And I should see a "bug number 546142" link
      And I should see a "restart_suggested" text
