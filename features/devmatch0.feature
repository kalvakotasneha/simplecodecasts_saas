Feature: DevMatch0

  Scenario: User should be able to access Dev Match URL
    Given DevMatch website URL is provided
    When  User accesses DevMatch website
    Then  DevMatch website should be loaded

  Scenario: User should be able to "Sign up with basic"
    Given Basic Button is available in Home Page
    When  User clicks Basic Button
    And  User enters email information
    Then User can enter password
    And User can confirm password
    And User should successfully signup

  Scenario: User should be able to log in dev match with valid email and password
    Given User should able to access DevMatch login page
    When  User enters email and password to login
    Then  User succesfully logs in


  Scenario: Basic User should able to visit profile
    Given Basic User is logged in with valid email
    When Basic User clicks create profile
    And Basic User fills out create profile form
    And Basic User clicks View profile
    Then Basic user can view his profile
    And User signs out

    Scenario: User should be able to "Signup with pro"
      Given Pro Button is available in home page
      When User clicks Pro Button
      And  Pro user enter email information
      Then Pro User can enter password
      And Pro User can confirm password
      And User enters Credit Card Number
      And User enters Security Code on Card (CVC)
      And User Card Expiration
      And User should click Sign up

  Scenario: Pro User should able to visit profile
    Given Pro User is logged in with valid email
    When Pro User clicks create profile
    And Pro User fills out create profile form
    And Pro User clicks View profile
    Then Pro user can view his profile

  Scenario: User should able to visit the community
       Given logged with valid email
       When user clicks visit the community button
       Then User can visit community with different profiles









