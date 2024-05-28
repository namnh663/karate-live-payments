Feature:

  Background:
    * callonce read('classpath:api/livetap/auth.feature')
    * url 'https://mpos-uat.fasspay.com:29198'
    * header Authorization = 'Bearer ' + access_token

  Scenario: Submitting all mandatory fields with valid data
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def livePaymentsMid = CompanyDataGenerator.randomLivePaymentMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "#(livePaymentsMid)",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessNumber": "",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "businessContactNo": "",
          "authoriserSalutation": "",
          "authoriserName": "",
          "authoriserContactNo": "",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Request is successful. '

  Scenario: Submitting all optional fields without mandatory (businessRegistrationAddress, postcode, city, region)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def livePaymentsMid = CompanyDataGenerator.randomLivePaymentMid();
    * def businessContactNo = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "#(livePaymentsMid)",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessNumber": "",
          "businessContactNo": "",
          "authoriserSalutation": "",
          "authoriserName": "",
          "authoriserContactNo": "",
          "authoriserEmail": "",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'No value is entered for Business Registration Address. No value is entered for Postcode. No value is entered for City. No value is entered for Region. '

  Scenario: Submitting with invalid businessContactNo
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def livePaymentsMid = CompanyDataGenerator.randomLivePaymentMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "#(livePaymentsMid)",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessNumber": "",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "businessContactNo": "",
          "authoriserSalutation": "",
          "authoriserName": "",
          "authoriserContactNo": "+613215",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Authoriser Contact Number is less than 9 characters. '

  Scenario: Empty mandatory field (region)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def dba = CompanyDataGenerator.randomMid();
    * def postcode = CompanyDataGenerator.randomPostcode();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "#(postcode)",
          "city": "Kuala Lumpur",
          "region": "",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "#(dba)",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'No value is entered for Region. '

  Scenario: Submitting without mandatory (businessName, businessShortName)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'No value is entered for Business Name. No value is entered for Business Short Name. '

  Scenario: Testing boundary values for numeric fields
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def businessName = CompanyDataGenerator.randomMid();
    * def businessShortName = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "#(businessName)",
          "businessShortName": "#(businessShortName)",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "maxAmountPerTransaction": 999999999,
          "maxAmountPerDay": 999999999,
          "maxAmountPerMonth": 999999999,
          "merchantDescriptor": "",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Request is successful. '

  Scenario: Providing multiple merchant details
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def midRetail = CompanyDataGenerator.randomMid();
    * def midOnline = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(midRetail)",
              "dba": "Retail",
              "cardScheme": "visa"
            },
            {
              "mid": "#(midOnline)",
              "dba": "Online",
              "cardScheme": "mastercard"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Request is successful. '

  Scenario: MID has been used
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "z",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'MID[z] This MID has been used. '

  Scenario: Providing an empty card scheme
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "z",
              "dba": "Retail",
              "cardScheme": ""
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'MID[z] No value is entered for Card Scheme. This MID has been used. '

  Scenario: Missing a mandatory field (merchantDetails)
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor"
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Service is currently unavailable. Please try again later. '

  Scenario: Providing invalid length for a field (postcode)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "87541",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Postcode exceeded 4 characters. '

  Scenario: Providing invalid data for authoriserSalutation
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "authoriserSalutation": "123",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Authoriser Salutation format is invalid. '

  Scenario: Providing input where the maximum length for businessName is exceeded
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Example Business with a very long name that exceeds the maximum allowed length of fifty characters",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Business Name exceeded 50 characters. '

  Scenario: Providing input where the maximum length for businessShortName is exceeded
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business",
          "businessShortName": "Business 1111111111 1111111111 1111111111",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Business Short Name exceeded 25 characters. '

  Scenario: Providing invalid data format for a field (postcode)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "ABCDE",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Postcode exceeded 4 characters. Postcode format is invalid: character content other than digit: 0-9 is not allowed. '

  Scenario: Providing invalid data for a field (apiServiceName)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Service is currently unavailable. Please try again later. '

  Scenario: Submitting without mandatory (apiServiceName)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Service is currently unavailable. Please try again later. '

  Scenario: Providing an invalid email format
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "authoriserEmail": "invalid_email",
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Authoriser Email format is invalid. '

  Scenario: Missing a numeric field (maxAmountPerTransaction = null)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "maxAmountPerTransaction": null,
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'Request is successful. '
    And match response.companyDetails.maxAmountPerTransaction == 0

  Scenario: Providing an invalid format for MID
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessNumber": "12345678901234567890123456789012345678900000000000000000000000000000000000",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "maxAmountPerTransaction": null,
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "mid!@#",
              "dba": "Retail",
              "cardScheme": "amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 200
    And match response.message == 'MID[mid!@#] MID format is invalid. '

  Scenario: Providing invalid length for a field (maxAmount)
    * def CompanyDataGenerator = Java.type('api.utils.CompanyDataGenerator')
    * def mid = CompanyDataGenerator.randomMid();
    * def payload =
      """
      {
        "apiServiceName": "CREATE_COMPANY",
        "companyDetails": {
          "livePaymentsMid": "livePaymentsMid",
          "businessName": "Business Z",
          "businessShortName": "Business Z",
          "businessRegistrationAddress": "Address",
          "postcode": "8754",
          "city": "Kuala Lumpur",
          "region": "Kuala Lumpur",
          "maxAmountPerTransaction": 9999999999,
          "maxAmountPerDay": 9999999999,
          "maxAmountPerMonth": 9999999999,
          "merchantDescriptor": "descriptor",
          "merchantDetails": [
            {
              "mid": "#(mid)",
              "dba": "Retail",
              "cardScheme": "visa|mastercard|amex"
            }
          ]
        }
      }
      """
    
    Given path 'api', 'processRequest'
    And request payload
    When method post
    Then status 500
    And match response.error == 'Internal Server Error'