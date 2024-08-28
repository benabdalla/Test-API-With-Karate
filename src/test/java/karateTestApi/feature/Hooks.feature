
Feature:
  Background: precondition
#    * def result = callonce read('classpath:karateTestApi/helpers/Dummy.feature')
#    * def userName = result.userName


    # After all scenarios have run
    * configure afterScenario = function(){ karate.call('classpath:karateTestApi/helpers/Dummy.feature') }

#  Scenario: first scenario
#    * print 'it is  first  scenario '
#    * print userName
#
#  Scenario: second scenario
#    * print 'it is  second  scenario '
#    * print userName
