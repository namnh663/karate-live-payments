Feature:

  Background:
    * callonce read('classpath:api/liveportal/auth/authorize.feature')
    * url envData.test.merchant_portal_url

  Scenario:
    Given path 'merchant', 'virtual-terminal-token'
    And header Origin = 'https://test.portal.livegroup'
    And header Authorization = 'Bearer ' + access_token
    When method post
    Then status 200