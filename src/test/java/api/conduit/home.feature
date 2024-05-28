Feature: Tests for the home page

  Background: Define URL
    * callonce read('classpath:api/conduit/helpers/token.feature')
    * url conduitUrl
    * header Authorization = 'Bearer ' + token

  Scenario: Get all tags
    Given url 'https://conduit.productionready.io/api/tags'
    When method get
    Then status 200

  Scenario: Get all tags
    Given path 'tags'
    When method get
    Then status 200
    And match response.tags contains 'est'
    And match response.tags contains ['eos', 'est']
    And match response.tags !contains 'test'
    And match response.tags == '#array'
    And match each response.tags == '#string'

  Scenario: Get 10 articles from the page
    Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'
    When method get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 476
    And match response.articlesCount != 470
    And match response == { "articles": "#array", "articlesCount": 476 }
    And match response.articles[*].favoritesCount contains 1
    And match response..bio contains null
    And match each response..following == "#boolean"
    And match each response..favoritesCount == "#number"

  Scenario: Get 10 articles from the page
    Given path 'articles'
    And param limit = 10
    And param offset = 0
    When method get
    Then status 200

  Scenario: Get 10 articles from the page
    Given path 'articles'
    And params { limit: 10, offset: 0 }
    When method get
    Then status 200
