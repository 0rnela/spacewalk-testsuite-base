# Copyright (c) 2010-2014 Novell, Inc.
# Licensed under the terms of the MIT license.

Feature: Test action chaining

  Scenario: I add a package installation to an action chain
    Given I am on the Systems overview page of this client
     When I follow "Software" in the content area
      And I follow "Install New Packages" in the content area
      And I check "hoag-dummy-1.1-2.1" in the list
      And I click on "Install Selected Packages"
      And I check radio button "schedule-by-action-chain"
      And I click on "Confirm"
      And I should see a "Action has been successfully added to the Action Chain" text


  Scenario: I add a remote command to the action chain
    Given I am on the Systems overview page of this client
     When I follow "Remote Command"
      And I enter as remote command this script in
        """
        #!/bin/bash
        touch /root/12345
        """
      And I check radio button "schedule-by-action-chain"
      And I click on "Schedule"
      And I should see a "Action has been successfully added to the Action Chain" text

  Scenario: I add a patch installation to the action chain
    Given I am on the Systems overview page of this client
     When I follow "Software" in the content area
      And I follow "Patches" in the content area
      And I check "andromeda-dummy-6789" in the list
      And I click on "Apply Patches"
      And I check radio button "schedule-by-action-chain"
      And I click on "Confirm"
      And I should see a "Action has been successfully added to the Action Chain" text

  Scenario: I add a remove package to the action chain
    Given I am on the Systems overview page of this client
     When I follow "Software" in the content area
      And I follow "List / Remove" in the content area
      And I check "adaptec-firmware-1.35-2.15.4" in the list
      And I click on "Remove Packages"
      And I check radio button "schedule-by-action-chain"
      And I click on "Confirm"
      And I should see a "Action has been successfully added to the Action Chain" text

  Scenario: I add a verify package to the action chain
    Given I am on the Systems overview page of this client
     When I follow "Software" in the content area
      And I follow "Verify" in the content area
      And I check "andromeda-dummy-1.0-4.3" in the list
      And I click on "Verify Selected Packages"
      And I check radio button "schedule-by-action-chain"
      And I click on "Confirm"
      And I should see a "Action has been successfully added to the Action Chain" text

  Scenario: I add a config file deployment to the action chain
    Given I am on the Systems overview page of this client
     When I follow "Configuration" in the tabs
      And I follow "Configuration Channels" in the left menu
      And I follow "New Test Channel"
      And I follow "Deploy Files" in the content area
      And I click on "Deploy All Files" 
      And I check this client
      And I click on "Confirm & Deploy to Selected Systems"
      And I check radio button "schedule-by-action-chain"
      And I click on "Deploy Files to Selected Systems"
      And I should see a "3 actions are being added to Action Chain new action chain" text

  Scenario: I add a reboot action to the action chain
    Given I am on the Systems overview page of this client
     When I follow "Schedule System Reboot" in the content area
      And I check radio button "schedule-by-action-chain"
      And I click on "Reboot system"
      And I should see a "Action has been successfully added to the Action Chain" text

  Scenario: I verify the action chain list
    Given I am on the Systems overview page of this client
     When I follow "Schedule"
      And I follow "Action Chains"
      And I follow "new action chain"
      And I should see a "1. Install or update hoag-dummy on 1 system" text
      And I should see a "2. Run a remote command on 1 system" text
      And I should see a "3. Apply patch(es) andromeda-dummy-6789 on 1 system" text
      And I should see a "4. Remove adaptec-firmware from 1 system" text
      And I should see a "5. Verify andromeda-dummy on 1 system" text
      And I should see a text like "6. Deploy.*/etc/mgr-test-file.cnf.*to 1 system"
      And I should see a "7. Reboot 1 system" text

  Scenario: check that different user cannot see the action chain
     Given I am authorized as "admin" with password "admin"
     When  I follow "Schedule"
       And I follow "Action Chains"
      Then I should not see a "new action chain" link

  Scenario: I delete the action chain
     Given I am authorized as "testing" with password "testing"
      Then I follow "Schedule"
       And I follow "Action Chains"
       And I follow "new action chain"
       And I follow "delete action chain" in the content area
       And I click on "Delete"

