Feature: Home Work

  Background: Preconditions
    * url ApiUrl
    * def userNameConnecte = userName
    * def isValidTime = read('classpath:karateTestApi/helpers/TimerValidator.js')
    * print("Connected user:", userName)
    * def newRequestComment = read("classpath:karateTestApi/json/NewComment.json")
    * def dataGenerateur = Java.type('karateTestApi.helpers.DataGenerator')
    * set newRequestComment.comment.body = dataGenerateur.getRandomJsonObjectNewComment().body

  Scenario: Favorite articles
    Given path 'articles'
    And param limit = 1
    And param offset = 0
    When method get
    Then status 200
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
    * def initialCount = response.articles[0].favoritesCount
    * def slug = response.articles[0].slug
    * def fullPath = 'articles/' + slug + '/favorite'

    Given path fullPath
    And request {}
    When method post
    Then status 200
    And assert response.article.favoritesCount == initialCount + 1

    Given path 'articles'
    And param favorited = userName
    And param limit = 10
    And param offset = 0
    When method get
    Then status 200
    And match response.articles[0].slug == slug

  Scenario: Comment articles
    Given path 'articles'
    And param limit = 1
    And param offset = 0
    When method get
    Then status 200
    And match response.articles[0].slug != ""
    * def slug = response.articles[0].slug
    Given path 'articles', slug, 'comments'
    When method get
    Then status 200
    And match each response.comments ==
      """
      {
        "id": "#number",
        "createdAt": "#? isValidTime(_)",
        "updatedAt": "#? isValidTime(_)",
        "body": "#string",
        "author": {
          "username": "#string",
          "bio": "##string",
          "image": "#string",
          "following": "#boolean"
        }
      }
      """
    * def articlesCount = response.comments.length

    Given path 'articles', slug, 'comments'
    And request newRequestComment
    When method post
    Then status 200
    And match response.comment ==
      """
      {
        "id": "#number",
        "createdAt": "#? isValidTime(_)",
        "updatedAt": "#? isValidTime(_)",
        "body": "#string",
        "author": {
          "username": "#string",
          "bio": "##string",
          "image": "#string",
          "following": "#boolean"
        }
      }
      """
    * def id = response.comment.id

    Given path 'articles', slug, 'comments'
    When method get
    Then status 200
    * print("Old articlesCount:", articlesCount)
    * print("New response.comments.length:", response.comments.length)
    * print("Response.comments array:", response.comments)
    And assert response.comments.length == articlesCount + 1


    Given path 'articles', slug, 'comments', id
    When method delete
    Then status 200
    Given path 'articles', slug, 'comments'
    When method get
    Then status 200
    And assert response.comments.length == articlesCount
