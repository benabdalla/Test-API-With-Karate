Feature: Tests  for  the  home page

  Background:  Define url
    Given url ApiUrl


  Scenario: Get all tags
    Given path 'tags'
    When method get
    Then status 200
    And match response.tags contains ['GitHub','Coding']
    And match response.tags !contains ['GitHub1','Coding1']
    And match response.tags contains any ['fish','dog']
    And match response.tags == '#array'
    And match each response.tags == '#string'

  #  @debug
  Scenario: Get 10 articles from the page
    * def isValidTime = read('classpath:karateTestApi/helpers/TimerValidator.js')
    Given params {limit : 10, offset : 0}
    Given path 'articles'
    When method get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10
    And match response.articlesCount == 10
    Then match response == { "articles" : '#array', "articlesCount": 10 }
    Then match response.articles[0].createdAt contains '2024'
    Then match response.articles[*].favoritesCount contains 115
    Then match each response..favoritesCount  == '#number'
    Then match each response..bio  == '##string'
    And match each response.articles ==
      """
      {
        "slug": "#string",
        "title": "#string",
        "description": "#string",
        "body": "#string",
        "tagList": "#array",
        "createdAt": "#? isValidTime(_)",
        "updatedAt": "#? isValidTime(_)",
        "favorited": "#boolean",
        "favoritesCount": "#number",
        "author": {
          "username": "#string",
          "bio": "##string",
          "image": "#string",
          "following": "#boolean"
        }
      }

      """
#  @debug
  Scenario: conditional logic
    Given path 'articles'
    And param limit = 1
    And param offset = 0
    When method get
    Then status 200
    * def initialCount = response.articles[0].favoritesCount
    * def article = response.articles[0]
    #    * if ( initialCount ==0 ) karate.call("classpath:karateTestApi/helpers/AddLike.feature", article)
    * def result = initialCount == 0 ?  karate.call("classpath:karateTestApi/helpers/AddLike.feature", article).addlikeCount : initialCount

    Given path 'articles'
    And param limit = 1
    And param offset = 0
    When method get
    Then status 200
    And match response.articles[0].favoritesCount == result

#  @debug
  Scenario: retry  Call
    * configure retry = { count :10, interval :5000}
    Given path 'articles'
    And param limit = 1
    And param offset = 0
    And retry until response.articles[0].favoritesCount == 1
    When method get
    Then status 200


  Scenario: sleep Call
    * configure sleep = function(pause){ java.lang.Thread.sleep(pause)}
    Given path 'articles'
    And param limit = 1
    And param offset = 0
    And retry until response.articles[0].favoritesCount == 1
    When method get
    * eval sleep(5000)
    Then status 200