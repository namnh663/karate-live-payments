Feature:

Background:
  * callonce read('classpath:api/phoenix/auth.feature')
  * url 'https://api-test-vaa.livegroup'
  * def JsonDxGenerator = Java.type('api.utils.JsonDxGenerator')
  * def payload = JsonDxGenerator.generateJsonDx();

@ignore
Scenario:
  Given path 'transaction'
  And header Authorization = 'Bearer ' + access_token
  And header Content-Type = 'application/json'
  And header terminal-id = tid
  And header serial-number = tid
  And header app-code = app
  And request payload
  When method post
  Then status 200

  * def response = response
  * print response
  * print payload