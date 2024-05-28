Feature: Authentication on Live Debit Test Environment
    This feature verifies the authentication process on the Live Debit Test Environment using Auth0.

  Background:
    * url envData.test.live_debit_url
    * def client_id = envData.test.client_id
    * def username = userData.namnguyen.username
    * def password = userData.namnguyen.password
    * def realm = envData.test.realm
    * def credential_type = envData.test.credential_type

  @ignore
  Scenario: Authenticate a User and Obtain Login Ticket ID
    * def payload =
    """
    {
        "client_id": "#(client_id)",
        "username": "#(username)",
        "password": "#(password)",
        "realm": "#(realm)",
        "credential_type": "#(credential_type)"
    }
    """

    Given path 'co', 'authenticate'
    And header Content-Type = 'application/json'
    And header Origin = envData.test.origin
    And request payload
    When method post
    Then status 200

    * def login_ticket = response.login_ticket
    * print login_ticket