Feature: Signup an user in website

  Background:
    #data for testing api
    * def urlBase = 'https://api.demoblaze.com/'
    * def path = 'signup'
    #Params for be used in scenaries
    * def newUser = '1ryanAlexFreire123'
    * def newPassword = 'asfghgdssdg'
    #message for be compared with error 500
    * text error500 =
    """
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
    <title>500 Internal Server Error</title>
    <h1>Internal Server Error</h1>
    <p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>
    """

  Scenario: Signup a new user
    Given url urlBase + path
    And request {"username": '#(newUser)', "password": #(newPassword)}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Signup a new user before created
    Given url urlBase + path
    And request {"username": "newUser", "password": "newPassword"}
    When method post
    Then status 200
    And match $ == {"errorMessage": "This user already exist."}