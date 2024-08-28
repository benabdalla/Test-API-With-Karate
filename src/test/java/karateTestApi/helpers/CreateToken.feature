Feature:  Create  token

  Scenario: create token

    Given url ApiUrl
    Given path 'users/login'
    And request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
    When method post
    Then status 200
    * def Authtoken = response.user.token
    * def Username = response.user.username
