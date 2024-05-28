Feature: Merchant Transaction History Details

  Background:
    * callonce read('classpath:api/liveportal/auth/authorize.feature')
    * url envData.test.merchant_portal_url
    * header Authorization = 'Bearer ' + access_token

  Scenario: Retrieving Transaction History Details for Merchant ID 61911309 - Sale Approved
    * def payload =
    """
    {
        "SR": "A",
        "ID": "61911309"
    }
    """
    # Define API endpoint path
    Given path 'merchant', 'transaction-history-detail'
    # Set header
    And header Origin = 'https://test.portal.livegroup'
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for a successful response
    Then status 200
    # Verify response data
    And match response.data.SRCID == '61911309'
    And match response.data.TransactionType == 'Sale'
    And match response.data.TransactionStatus == 'Approved'

  Scenario: Retrieving Transaction History Details for Merchant ID 62013612 - Refund Approved
    * def payload =
    """
    {
        "SR": "A",
        "ID": "62013612"
    }
    """
    # Define API endpoint path
    Given path 'merchant', 'transaction-history-detail'
    # Set headers with access token and origin
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200
    And match response.data.SRC == 'A'
    And match response.data.SRCID == '62013612'
    And match response.data.TransactionType == 'Refund'
    And match response.data.TransactionStatus == 'Approved'

  Scenario: Retrieving Transaction History Details for Merchant ID 61911310 - Void
    * def payload =
    """
    {
        "SR": "VA",
        "ID": "61911310"
    }
    """

    Given path 'merchant', 'transaction-history-detail'
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200
    And match response.data.SRC == 'VA'
    And match response.data.SRCID == '61911310'

    * def response = response
    * def DocketNumber = response.data.DocketNumber
    * def D_TypeAndStatusKey = response.data.D_TypeAndStatusKey
    * def D_TransactionDateKey = response.data.D_TransactionDateKey

    * def payload =
    """
    {
        "DocketNumber": "#(DocketNumber)",
        "D_TypeAndStatusKey": "#(D_TypeAndStatusKey)",
        "D_TransactionDateKey": "#(D_TransactionDateKey)"
    }
    """

    Given header Authorization = 'Bearer ' + access_token
    And path 'merchant', 'transaction-history-payment-detail'
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200

  Scenario: Retrieving Transaction History Details for Merchant ID 1585 - Reverse Approved
    * def payload =
    """
    {
        "SR": "R",
        "ID": "1585"
    }
    """

    Given path 'merchant', 'transaction-history-detail'
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200
    And match response.data.SRC == 'R'
    And match response.data.SRCID == '1585'
    And match response.data.TransactionType == 'Reverse'
    And match response.data.TransactionStatus == 'Approved'

  Scenario: Retrieving Transaction History Details for Merchant ID 61911327 - Chargeback Approved
    * def payload =
    """
    {
        "SR": "C",
        "ID": "61911327"
    }
    """

    Given path 'merchant', 'transaction-history-detail'
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200
    And match response.data.SRC == 'C'
    And match response.data.SRCID == '61911327'
    And match response.data.TransactionType == 'Chargeback'
    And match response.data.TransactionStatus == 'Approved'

  Scenario: Retrieving Transaction History Details for Merchant ID 6512 - Reverse Chargeback Approved
    * def payload =
    """
    {
        "SR": "RC",
        "ID": "6512"
    }
    """

    Given path 'merchant', 'transaction-history-detail'
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200
    And match response.data.SRC == 'RC'
    And match response.data.SRCID == '6512'
    And match response.data.TransactionType == 'Reverse Chargeback'
    And match response.data.TransactionStatus == 'Approved'
  
  Scenario: Retrieving Transaction History Details for Merchant ID 58198467 - Refund Declined
    * def payload =
    """
    {
        "SR": "D",
        "ID": "58198467"
    }
    """

    Given path 'merchant', 'transaction-history-detail'
    And header Origin = 'https://test.portal.livegroup'
    And request payload
    When method post
    Then status 200
    And match response.data.SRC == 'D'
    And match response.data.SRCID == '58198467'

  Scenario: Check the server's ability to handle errors when handling requests that do not send payload
    Given path 'merchant', 'transaction-history-detail'
    And header Origin = 'https://test.portal.livegroup'
    When method post
    Then status 500
    And match response.error == true
    And match response.message == 'Error When Process'
