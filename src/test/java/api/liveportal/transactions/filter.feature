Feature: Testing Filter Transaction History API

  Background:
    * callonce read('classpath:api/liveportal/auth/authorize.feature')
    * url envData.test.merchant_portal_url
    * path 'merchant', 'transaction-history'
    * header Origin = 'https://test.portal.livegroup'

  Scenario: Verify transactions from 2023 to 2024 with default top 10
    # Define a JSON string containing parameters for the transactions query
    * def jsonString = '{"fromDate":"2023-11-29 17:19:50","toDate":"2024-02-29 23:59:50","topNRows":30,"searchText":"","transactionStatus":[],"transactionType":[],"payMethod":[]}'
    # Importp a Java class named JsonToBase64 which is used to encode JSON to Base64
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    # Encode the JSON string defined earlier into Base64 format using the encodeJsonToBase64 method from the JsonToBase64 class
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    # Define the payload for the request
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set Authorization header
    Given header Authorization = 'Bearer ' + access_token
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for a successful response
    Then status 200

  Scenario: Verify transactions from 2023 to 2024 have been approved
    * def jsonString = '{"fromDate":"2023-04-19 00:00:00","toDate":"2024-04-19 23:59:59","topNRows":30,"searchText":"","transactionStatus":["Approved"],"transactionType":[],"payMethod":[]}'
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set Authorization header
    Given header Authorization = 'Bearer ' + access_token
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for a successful response
    Then status 200

  Scenario: Verify master card sales transactions from 2023 to 2024 have been declined
    * def jsonString = '{"fromDate":"2023-11-29 17:19:50","toDate":"2024-02-29 23:59:50","topNRows":30,"searchText":"","transactionStatus":["Declined"],"transactionType":["Sale"],"payMethod":["MasterCard"]}'
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set Authorization header
    Given header Authorization = 'Bearer ' + access_token
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for a successful response
    Then status 200

  Scenario: Verify request with invalid or corrupted base64 encoded data
    * def jsonString = 'abc'
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set Authorization header
    Given header Authorization = 'Bearer ' + access_token
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for a successful response
    Then status 500

  Scenario: Verify request with an empty request body
    # Set Authorization header
    Given header Authorization = 'Bearer ' + access_token
    # Send POST request
    When method post
    # Check for a successful response with created status
    Then status 201
    # Check for expected error message in the response
    And match response.message == 'Incorrect Parameter!'

  Scenario: Verify handling of invalid API key
    * def jsonString = '{"fromDate":"2023-11-29 17:19:50","toDate":"2024-02-29 23:59:50","topNRows":30,"searchText":"","transactionStatus":["Declined"],"transactionType":["Sale"],"payMethod":["MasterCard"]}'
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set Authorization header with invalid key
    Given header Authorization = 'Bearer ' + 'INVALIDKEY'
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for expected unauthorized status
    Then status 401
    # Check for expected error code
    And match response.code == 'invalid_token'
    # Check for expected error message
    And match response.message == 'jwt malformed'

  Scenario: Verify handling of missing Authorization header
    * def jsonString = '{"fromDate":"2023-11-29 17:19:50","toDate":"2024-02-29 23:59:50","topNRows":30,"searchText":"","transactionStatus":["Declined"],"transactionType":["Sale"],"payMethod":["MasterCard"]}'
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set request payload
    Given request payload
    # Send POST request
    When method post
    # Check for expected unauthorized status
    Then status 401
    # Check for expected error code
    And match response.code == 'credentials_required'
    # Check for expected error message
    And match response.message == 'No authorization token was found'

  Scenario: Verify invalid Origin header
    * def jsonString = '{"fromDate":"2023-11-29 17:19:50","toDate":"2024-02-29 23:59:50","topNRows":30,"searchText":"","transactionStatus":["Declined"],"transactionType":["Sale"],"payMethod":["MasterCard"]}'
    * def JsonToBase64 = Java.type('api.utils.JsonToBase64')
    * def data = JsonToBase64.encodeJsonToBase64(jsonString);
    * def payload =
      """
      {
        "data": "#(data)"
      }
      """

    # Set invalid Origin header
    Given header Origin = 'https://invalid.origin.com'
    # Set request payload
    And request payload
    # Send POST request
    When method post
    # Check for expected server error status
    Then status 500