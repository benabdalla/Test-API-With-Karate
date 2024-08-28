Feature: Add likes

  Background:
    Given url ApiUrl

  Scenario: Add likes
    Given path 'articles/' + slug + '/favorite'
    And request {}
    When method post
    Then status 200
    * def addlikeCount = response.article.favoritesCount
