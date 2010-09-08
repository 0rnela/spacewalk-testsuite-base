# features/create_activationkey.feature
Feature: Create an activation key
  In Order register a system to the spacewalk server
  As the testing user
  I want to create an activation key

  Scenario: fail to create an activation key
    Given I am on the Systems page
      And I follow "Activation Keys" in the left menu
      And I follow "create new key"
    When I enter "SUSE Test Key" as "description"
     And I enter "SUSE-DEV" as "key"
     And I check "monitoring_entitled"
     And I check "provisioning_entitled"
     And I check "virtualization_host"
     And I check "virtualization_host_platform"
     And I click on "Create Activation Key"
   Then I should see a "A system can have either the Virtualization or Virtualization Platform entitlement but not both." text

  Scenario: create an activation key
    Given I am on the Systems page
      And I follow "Activation Keys" in "sidenav"
      And I follow "create new key" 
    When I enter "SUSE Test Key" as "description"
     And I enter "SUSE-DEV" as "key"
     And I check "monitoring_entitled"
     And I check "provisioning_entitled"
     And I check "virtualization_host"
     And I click on "Create Activation Key"
   Then I should see a "Activation key SUSE Test Key has been created" text
    And I should see a "Details" link
    And I should see a "Child Channels" link
    And I should see a "Packages" link
    And I should see a "Configuration" link
    And I should see a "Groups" link
    And I should see a "Activated Systems" link
   
  Scenario: Change limit of the activation key
    Given I am on the Systems page
      And I follow "Activation Keys" in "sidenav"
      And I follow "SUSE Test Key"
    When I enter "20" as "usageLimit"
     And I click on "Update Activation Key"
    Then I should see a "Activation key SUSE Test Key has been modified." text
     And I should see "20" in field "usageLimit"
    
