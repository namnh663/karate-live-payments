Feature:

  Background:
    * callonce read('classpath:api/liveportal/pay/get-token-vt.feature')
    * url envData.test.merchant_portal_url

  @ignore
  Scenario:
    * def payload =
    """
    {
        "amount": 10,
        "cardHolderName": "Brian",
        "cyberSourceToken": "TOKEN",
        "description": "",
        "surcharge": 0,
        "userName": "lp_brian_203815"
    }
    """

    Given path 'merchant', 'process-payment-virtual-terminal'
    And header Origin = 'https://test.portal.livegroup'
    And header Authorization = 'Bearer ' + access_token
    And request payload
    When method post
    Then status 200