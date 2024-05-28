Feature:

  Background:
    * url 'https://api-test-vaa.livegroup'
    * def tid = envData.test.tid
    * def app = envData.test.app_code

  @ignore
  Scenario:
    Given path 'auth'
    And header Authorization = 'basic API_KEY'
    And header terminal-id = tid
    And header serial-number = tid
    And header app-code = app
    When method post
    Then status 201

    * def access_token = response.accessToken
    * print access_token