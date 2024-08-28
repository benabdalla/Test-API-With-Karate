package karateTestApi.helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {


    public static String getRandomEmail() {
        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
    }
    public static String getRandomUserName() {
        Faker faker = new Faker();
        return faker.name().username();
    }

    public static JSONObject getRandomJsonObject() {
        Faker faker = new Faker();
     String  title =faker.gameOfThrones().character();
        String description=faker.gameOfThrones().city();
                String   body= faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
                json.put("title",title);
                json.put("description",description);
                json.put("body",body);
                System.err.println("JsonObject :" +json);
        return json;
    }

    public static JSONObject getRandomJsonObjectNewComment() {
        Faker faker = new Faker();
                String   body= faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
                json.put("body",body);
                System.err.println("JsonObject :" +json);
        return json;
    }
}
