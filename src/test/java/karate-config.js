function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
 ApiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'mootezbenabdallah96@gmail.com'
    config.userPassword = 'karate123'
  } else if (env == 'e2e') {

  }

    // Corrected the method name from callSlingle to callSingle
    var accessToken = karate.callSingle('classpath:karateTestApi/helpers/CreateToken.feature', config).Authtoken;
  config.userName = karate.callSingle('classpath:karateTestApi/helpers/CreateToken.feature', config).Username;
    karate.configure('headers', { Authorization: 'Token ' + accessToken });


  return config;
}