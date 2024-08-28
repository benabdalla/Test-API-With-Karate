Feature:  Sign  Up new user

  Background: define Url
    Given url ApiUrl
    * def dataGenerateur = Java.type('karateTestApi.helpers.DataGenerator')
    * def dateUserName = dataGenerateur.getRandomUserName()
    * def dataEmail = dataGenerateur.getRandomEmail()

  #  @debug
  Scenario:  Sign up  new user
    Given def userData = {"email": "karate78971@test.com","username": "test1458"}
    Given path 'users'
    And request
      """
      {
        "user": {
          "email": "#(dataEmail)",
          "password": "karate1235",
          "username": "#(dateUserName)"
        }
      }
      """
    When method post
    Then status 201
    And match response.user ==
      """
      {
        "id": "#number",
        "email": "#(dataEmail)",
        "username": "#(dateUserName)",
        "bio": null,
        "image": "#string",
        "token": "#string"
      }
      """

#  @debug
  Scenario Outline:  Sign up with  error  message
    Given def userData = {"email": "karate78971@test.com","username": "test1458"}
    Given path 'users'
    And request
      """
      {
        "user": {
          "email": <email>,
          "password": "karate1235",
          "username": <userName>
        }
      }
      """
    When method post
    Then status 422
    And match response == <errorMessage>
    Examples:
      | email             | userName          | errorMessage                                       |
      | "#(dataEmail)"    | "testKarate"      | {"errors":{"username":["has already been taken"]}} |
      | "test@karate.com" | "#(dateUserName)" | {"errors":{"email":["has already been taken"]}}    |




