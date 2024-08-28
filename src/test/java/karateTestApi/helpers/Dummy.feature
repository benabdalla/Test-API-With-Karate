Feature:

  Scenario: Dummy
    * def dataGenerateur = Java.type('karateTestApi.helpers.DataGenerator')
    * def userName = dataGenerateur.getRandomUserName()
    * print("test =====================================> " , userName)
