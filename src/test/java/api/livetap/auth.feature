Feature:

  Background:
    * url 'https://mpos-uat.fasspay.com:29198'

  @ignore
  Scenario:
    * def basicAuth =
    """
    function(creds) {
      var temp = creds.username + ':' + creds.password;
      var Base64 = Java.type('java.util.Base64');
      var encoded = Base64.getEncoder().encodeToString(temp.toString().getBytes());
      return 'Basic ' + encoded;
    }
    """
    
    Given path 'oauth', 'token'
    And header Authorization = basicAuth({ username: '2124df86-eda2-4640-abd3-5d13c61fb78c', password: '3ec56b7f-6350-436c-8274-0082a3376c4e' })
    And form field grant_type = 'client_credentials'
    When method post
    Then status 200

    * def access_token = response.access_token
    * print access_token