Feature: Articles

  Background: Define URL
    * callonce read('classpath:api/conduit/helpers/token.feature')
    * url conduitUrl
    * header Authorization = 'Bearer ' + token

  Scenario: Create and delete article
    Given path 'articles'
    And request {"article": {"tagList": [], "title": "Article 11", "description": "Abc", "body": "body"}}
    When method post
    Then status 201
    And match response.article.title == 'Article 11'
    * def articleId = response.article.slug

    Given header Authorization = 'Bearer ' + token
    And path 'articles', articleId
    When method delete
    Then status 204

    Given path 'articles'
    And params { limit: 10, offset: 0 }
    When method get
    Then status 200
    And match response.articles[0].title != 'Article 11'