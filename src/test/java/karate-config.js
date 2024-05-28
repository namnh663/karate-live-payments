function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'test';
  }

  var config = {
    env: env,
    conduitUrl: 'https://conduit.productionready.io/api',
    envData: karate.read('classpath:api/data/env.json'),
    userData: karate.read('classpath:api/data/user.json')
  }

  if (env == 'test') {
    config.conduitUserEmail = 'kar1@test.com'
    config.conduitUserPassword = 'Karate123'
  } else if (env == 'e2e') {
    // customize
  }

  return config;
}