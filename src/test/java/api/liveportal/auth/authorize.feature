Feature: Authorization for Live Debit Test
    This feature tests the authorization for Live Debit, ensuring that the system can successfully generate an access token in response to a valid authorization request.

  Background:
    * callonce read('classpath:api/liveportal/auth/authen.feature')
    * url envData.test.live_debit_url

  @ignore
  Scenario: Authorization with Valid Parameters
    Given path 'authorize'
    And param client_id = 'QeSUjI4NRAGEEuOjFR5TErOWronge4m5'
    And param redirect_uri = 'https://test.portal.livegroup.com.au/callback'
    And param audience = 'https://live-debit-test.au.auth0.com/api/v2/'
    And param response_type = 'token id_token'
    And param scope = 'openid profile email user_metadata'
    And param nonce = 'BBlMHLHxPTyLCKH~VPdXJvESiCTCIwLi'
    And param state = '2lKxw4g2ypR1dw4aRiCBhpQrmmIQy.VK'
    And param realm = 'LiveDebit'
    And param login_ticket = login_ticket
    And param response_mode = 'web_message'
    And param auth0Client = 'KEY'
    When method get
    Then status 200

    * def getAccessToken =
    """
    function(htmlContent) {
      // Parse the HTML content to extract the access_token
      var match = htmlContent.match(/"access_token":"([^"]*)"/);
      if (match && match.length > 1) {
          return match[1];
      } else {
          return null;
      }
    }
    """
    * def htmlContent = response
    * def access_token = getAccessToken(htmlContent)
    * print access_token