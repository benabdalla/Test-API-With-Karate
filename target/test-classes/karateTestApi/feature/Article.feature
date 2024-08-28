
Feature: article

  Background: define url
    * def newRequestArticle = read("classpath:karateTestApi/json/NewArticleRequest.json")
    * def dataGenerateur = Java.type('karateTestApi.helpers.DataGenerator')
    * set newRequestArticle.article.title = dataGenerateur.getRandomJsonObject().title
    * set newRequestArticle.article.description = dataGenerateur.getRandomJsonObject().description
    * set newRequestArticle.article.body = dataGenerateur.getRandomJsonObject().body
    Given url ApiUrl
  #    Given path 'users/login'
  #    And request {"user": {"email": "mootezbenabdallah96@gmail.com","password": "karate123"}}
  #    When method post
  #    Then status 200
  #    * def tokenresponse = callonce read("classpath:karateTestApi/helpers/CreateToken.feature")
  #    * def token = tokenresponse.Authtoken
  #    * print('Token:', token)


  Scenario: Create new article
    #    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request newRequestArticle
    When method post
    Then status 201
    * print('Response:', response.article.slug)
    And match response.article.title == newRequestArticle.article.title


  Scenario: Create and delete  article
    #    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request newRequestArticle
    When method post
    Then status 201
    * def articleId = response.article.slug

    Given params {limit : 10, offset : 0}
    #    Given header Authorization = 'Token ' + token
    Given path 'articles'
    When method get
    Then status 200
    * print('Title of articles:', response.articles[0].title)
    And match response.articles[0].title == newRequestArticle.article.title

    #    Given header Authorization = 'Token ' + token
    Given path 'articles' , articleId
    When method Delete
    Then status 204

    Given params {limit : 10, offset : 0}
    #    Given header Authorization = 'Token ' + token
    Given path 'articles'
    When method get
    Then status 200
    * print('Title of articles:', response.articles[0].title)
    And match response.articles[0].title != newRequestArticle.article.title
