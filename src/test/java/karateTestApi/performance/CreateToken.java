package karateTestApi.performance;

import com.intuit.karate.Runner;
import scala.Array;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class CreateToken {
    private static ArrayList<String> tokens = new ArrayList<>();
    public static final AtomicInteger counter = new AtomicInteger();
    public static String getNextToken(){
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }
    private static String[] emails={
            "tokenN1@test.com",
            "tokenN2@test.com",
            "tokenN3@test.com"
    };

    public  static  void createTokens(){
        for(String email : emails){
            Map<String,Object> account = new HashMap<>();
            account.put("email",email);
            account.put("password","test123456789");
            Map<String,Object> result = Runner.runFeature("classpath:karateTestApi/helpers/CreateToken.feature",account,true);
tokens.add(result.get("Authtoken").toString());
System.err.println("liste token :"+tokens);
        }
    }


}
