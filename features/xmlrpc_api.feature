# Copyright (c) 2015 SUSE LLC
# Licensed under the terms of the MIT license.

Feature: Test XML-RPC "api" namespace.

  Scenario: Public API test
    Given I am logged in via XML-RPC/api as user "admin" and password "admin"
    When I call getVersion, I should get "16" as result
    When I call systemVersion, I should get "2.4" as result
    When I call getApiNamespaces, I should get 46 namespaces
    When I call getApiNamespaceCallList, I should get 660 available api calls
    When I call getApiCallList, I should get 46 available groups
