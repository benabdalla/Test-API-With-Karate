@debug
Feature: article

  Background: define url
    * def newRequestArticle = read("classpath:karateTestApi/json/NewArticleRequest.json")
    * def dataGenerateur = Java.type('karateTestApi.helpers.DataGenerator')
    * set newRequestArticle.article.title = __gatling.Title
    * set newRequestArticle.article.description = __gatling.Description
  
    * set newRequestArticle.article.body = dataGenerateur.getRandomJsonObject().body
    * def sleep = function(ms){ java.lang.Thread.sleep(ms)}
    * def pause = karate.get('__gatling.pause',sleep)

    Given url ApiUrl


  Scenario: Create and delete  article
    Given path 'articles'
    And request newRequestArticle
    When method post
    Then status 201
    * def articleId = response.article.slug
   * pause(5000)
    Given path 'articles' , articleId
    When method Delete
    Then status 204

