Feature: Login with user registered in website

  Background:
  Background:
    * def urlBase = 'https://api.demoblaze.com/'
    * def path = 'login'
    * text error500 =
    """
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
    <title>500 Internal Server Error</title>
    <h1>Internal Server Error</h1>
    <p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>
    """

  @ValidLogin
  Scenario: Login with a valid user
    Given url urlBase + path
    And request {"username": BryanAlexFreire123 , "password": "asfghgdssdg"}
    When method post
    Then status 200
    And match response !=  {"errorMessage": "User does not exist."}
    And match response !=  {"errorMessage": "Wrong password."}

  @WrongUser
  Scenario: Login with a wrong user
    Given url urlBase + path
    And request {"username": "BryanAlexFreire123%", "password": "asfghgdssdg"}
    When method post
    Then status 200
    And match $ == {"errorMessage": "User does not exist."}

  @WrongPassword
  Scenario: Login with a wrong password
    Given url urlBase + path
    And request {"username": "BryanAlexFreire123", "password": "asfghgdssdg1"}
    When method post
    Then status 200
    And match $ == {"errorMessage": "Wrong password."}

  @WithoutUser
  Scenario: Login without user and valid password
    Given url urlBase + path
    And request {"username": "", "password": "asfghgdssdg"}
    When method post
    Then status 500
    And match $ == error500

  @WithoutPassword
  Scenario: Login without password and valid user
    Given url urlBase + path
    And request {"username": "BryanAlexFreire123", "password": ""}
    When method post
    Then status 200
    And match $ == {"errorMessage": "Wrong password."}

  @EmptyFields
  Scenario: Login with empty fields
    Given url urlBase + path
    And request {"username": "", "password": ""}
    When method post
    Then status 500
    And match $ == error500