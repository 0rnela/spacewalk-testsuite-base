#@wip
Feature: Adding channels
  In Order distribute software to the clients
  As an authorized user
  I want to add channels

  Background:
    Given I am testing channels

  Scenario: Adding a base channel
     And I follow "Channels"
     And I follow "Manage Software Channels" in "sidenav"
     And I follow "create new channel"
    When I enter "Test Base Channel" as "Channel Name"
     And I enter "test_base_channel" as "Channel Label"
     And I select "None" from "Parent Channel"
     And I select "x86_64" from "Parent Channel Architecture"
     And I enter "Base channel for testing" as "Channel Summary"
     And I enter "No more desdcription for base channel." as "Channel Description"
     And I click on "Create Channel"
#    Then I should see a "Channel Test Base Channel created." text in "site-info"
    Then I should see a "Channel Test Base Channel created." text

#2nd entry
# "The channel name 'Test Base Channel' is already in use, please enter a different name"