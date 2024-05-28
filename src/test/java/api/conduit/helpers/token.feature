Feature: Token

Scenario: Create Token
  Given url conduitUrl
  And path 'users/login'
  And request {"user": {"email": "#(conduitUserEmail)", "password": "#(conduitUserPassword)"}}
  When method post
  Then status 200
  * def token = response.user.token