package karateTestApi.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import karateTestApi.helpers.DataGenerator

import scala.concurrent.duration._
import scala.language.postfixOps

class PerfTest extends Simulation {
  CreateToken.createTokens();
  DataGenerator.getRandomJsonObject();
  val feederToken = Iterator.continually {
    Map("token" -> CreateToken.getNextToken)
  }

  val protocol = karateProtocol()

//  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
//  protocol.runner.karateEnv("perf")
//val csvFile = csv("karateTestApi/performance/data/article.csv").circular
  val createArticle = scenario("create").feed(feederToken).exec(karateFeature("classpath:karateTestApi/performance/CreateArticle.feature"))

  setUp(
    createArticle.inject(
        nothingFor(4), // 1
    atOnceUsers(3), // 2
//rampUsers(1).during(5), // 3
 // constantUsersPerSec(1).during(3 seconds)// 4
  //  constantUsersPerSec(1).during(15).randomized, // 5
   // rampUsersPerSec(1).to(1).during(10), // 6
  //  rampUsersPerSec(1).to(20).during(10).randomized, // 7
   // stressPeakUsers(1).during(20) // 8
    
    ).protocols(protocol)
 //   delete.inject(rampUsers(5) during (5 seconds)).protocols(protocol)
  )

}
