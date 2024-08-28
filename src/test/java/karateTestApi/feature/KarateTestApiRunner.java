package karateTestApi.feature;

import com.intuit.karate.junit5.Karate;

public class KarateTestApiRunner {
    @Karate.Test
    Karate testHomePage() {
        return Karate.run("Article").relativeTo(getClass());
    }

    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }
}
