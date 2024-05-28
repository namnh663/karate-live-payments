Feature: Sign up new user

  Background: Define URL
    * url conduitUrl

  Scenario: New user sign up
    * def userData = {"email": "KarateUser12@test.com", "username": "KarateUser42"}
    Given path 'users'
    And request
    """
    {
    "user": {
        "email": "#(userData.email)",
        "password": "123Karate123",
        "username": "#(userData.username)"
    }
    }
    """
    When method post
    Then status 201

  Scenario Outline: Validate sign up error messages
    Given path 'users'
    And request
    """
    {
    "user": {
        "email": "<email>",
        "password": "<password>",
        "username": "<username>"
        }
    }
    """
    When method post
    Then status 422
    And match response == <error>

    Examples:
      | email                 | password     | username     | error |
      | KarateUser11@test.com | 123Karate123 | KarateUser41 | {"errors":{"email":["has already been taken"]}} |
      | KarateUser11@test.com | 123Karate123 | KarateUser40 | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}} |
      | KarateUser23          | 123Karate123 | KarateUser44 | {"errors":{"username":["has already been taken"]}} |