# Copyright (c) 2015 SUSE LLC
# Licensed under the terms of the MIT license.

Feature: Test the remote commands via salt
  In Order to test the remote commands via salt
  As an authorized user
  I want to verify that the remote commands function

  Background:
    Given I am authorized as "testing" with password "testing"

  Scenario: Run a remote command
    Given I follow "Salt"
    And I follow "Remote Commands"
    And I should see a "Remote Commands" text
    And I click on preview
    Then I should see my hostname
    And I click on run
    Then I wait for "3" seconds
    And I expand the results
    And I verify the results

  Scenario: Run a remote command from the systems overview page
    Given I follow "Systems"
    Then I follow this client link
    When I follow "Remote Command" in the content area
    And I enter as remote command this script in
      """
      #!/bin/bash
      touch /root/12345
      """
    And I click on "Schedule"
    Then I should see a "Remote Command has been scheduled successfully" text
    Then "/root/12345" exists on the filesystem
    And I follow "Events" in the content area
    And I follow "History" in the content area
    Then I follow "Run an arbitrary script scheduled by testing" in the content area
    And I should see a "Script executed successfully." text
    And I should see a "Return Code: 0" text
