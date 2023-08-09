Feature: Signup an user in website

  Background:
    * def urlBase = 'https://api.demoblaze.com/'
    * def path = 'signup'
    * text error500 =
    """
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
    <title>500 Internal Server Error</title>
    <h1>Internal Server Error</h1>
    <p>The server encountered an internal error and was unable to complete your request. Either the server is overloaded or there is an error in the application.</p>
    """

  Scenario: Signup a new user
    Given url urlBase + path
    And request {"username": "BryanAlex123Freire%123as", "password": "asfghgdssdg"}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Signup a new user before created
    Given url urlBase + path
    And request {"username": "BryanAlexFreire123", "password": "asfghgdssdg"}
    When method post
    Then status 200
    And match $ == {"errorMessage": "This user already exist."}

  Scenario: Signup a new user without password
    Given url urlBase + path
    And request {"username": "BryanAlexFreire147sasd", "password": ""}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Signup a new user without username
    Given url urlBase + path
    And request {"username": "", "password": "asfghgdssdg"}
    When method post
    Then status 500
    And match $ == error500

  Scenario: Signup a new user without params
    Given url urlBase + path
    And request {"username": "", "password": ""}
    When method post
    Then status 500
    And match $ == error500

  Scenario: Valid a new user with 50 characters in username
    Given url urlBase + path
    And request {"username": "qwastyuiop23df89jklñzxcvbnmqwertyuoipasdfghjklñ123", "password": "sayfgb2387"}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Valid a new user with 50 characters in password
    Given url urlBase + path
    And request {"username": "as122354ag", "password": "qwertyu12pasdfghjklñasdvbnmqwertyuoipasdfghjklñzxc"}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Valid a new user with 100 characters in username
    Given url urlBase + path
    And request {"username": "qwertyuioasddfgh12lñzxcvbnmqwertyuoipasdfghjklñzxcqwertyuiopasdfghjklñzxcvbnmqwertyuoipasdfghjklñz123", "password": "sayfgb2387"}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Valid a new user with 100 characters in password
    Given url urlBase + path
    And request {"username": "asfg2354%&$1/", "password": "q12rtyuiopasdfghjklñzxasdfmqwertyuoipasdfghjklñzxc&%$124a"}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}

  Scenario: Signup a new user with special characteres
    Given url urlBase + path
    And request {"username": "asfasdg2354%&$1", "password": "asd556wertyuiopasdfghjklñzxcvbnmqwertyuoipasdfghjklñzxc&%$124a"}
    When method post
    Then status 200
    And match response != {"errorMessage": "This user already exist."}