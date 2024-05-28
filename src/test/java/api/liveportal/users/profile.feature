Feature: Testing Merchant User Profile API

  Background:
    * callonce read('classpath:api/liveportal/auth/authorize.feature')
    * url envData.test.merchant_portal_url
    * path 'merchant', 'user-profile'
    * header Origin = 'https://test.portal.livegroup.com.au'
    * def profile = read('classpath:api/data/profile.json')

  Scenario: Verify successful user profile retrieval
    # Set the authorization header using the access token obtained during authentication
    Given header Authorization = 'Bearer ' + access_token
    # Send POST request
    When method post
    # Expect a successful response with status code 200
    Then status 200
    # Verify various fields in the response match the expected values from the profile data
    And match response.data == profile.namnguyen
    # Ensure there's no error in the response
    And match response.error == false
    # Check data type
    And match response.data.FirstName == '#string'
    And match response.data.LastName == '#string'
    And match response.data.Mobile == '#string'
    And match response.data.Email == '#string'
    And match response.data.ABN == '#string'
    And match response.data.PrimaryMemberAddressKey == '#number'
    And match response.data.PrimaryStreetNumber == '#string'
    And match response.data.PrimaryAddress == '#string'
    And match response.data.PrimaryCity == '#string'
    And match response.data.PrimaryPostcode == '#string'
    And match response.data.State == '#string'
    # Verify the success message in the response
    And match response.message == 'Success'

  Scenario: Verify handling of missing Authorization header
    # Send POST request
    When method post
    # Expect a 401 Unauthorized status code
    Then status 401
    # Verify that the response code matches 'credentials_required'
    And match response.code == 'credentials_required'
    # Verify that the response message indicates the absence of an authorization token
    And match response.message == 'No authorization token was found'

  Scenario: Verify handling of invalid API key
    # Set an invalid Authorization header
    Given header Authorization = 'Bearer ' + 'INVALIDKEY'
    # Send POST request
    When method post
    # Expect a 401 Unauthorized status code
    Then status 401
    # Verify that the response code matches 'invalid_token'
    And match response.code == 'invalid_token'
    # Verify that the response message indicates a malformed JWT
    And match response.message == 'jwt malformed'

  Scenario: Verify handling of invalid endpoint
    # Set the invalid endpoint
    Given path 'invalidpath'
    # Set the authorization header using the access token obtained during authentication
    And header Authorization = 'Bearer ' + access_token
    # Send POST request
    When method post
    # Expect a 404 Not Found status code
    Then status 404

  Scenario: Verify invalid Origin header
    # Set the authorization header using the access token obtained during authentication
    Given header Authorization = 'Bearer ' + access_token
    # Set an invalid Origin header
    And header Origin = 'https://invalid.origin.com'
    # Send POST request
    When method post
    # Expect a 500 Internal Server Error status code - Not allowed by CORS
    Then status 500