package karateTestApi.performance;

import com.intuit.karate.junit5.Karate;

public class KarateTestApiPerformance {
    @Karate.Test
    Karate performance() {
        return Karate.run("CreateArticle").relativeTo(getClass());
    }

    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }
}
