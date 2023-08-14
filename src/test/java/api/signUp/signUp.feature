Feature: Signup an user in website

  Background:
    #data for testing api
    * def urlBase = 'https://api.demoblaze.com/'
    * def path = 'signup'
    #Params for be used in scenaries
    * def newUser = '2ryanAlexFreire123'
    * def newPassword = 'asfghgdssdg'

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