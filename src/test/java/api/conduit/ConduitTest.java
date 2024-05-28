package api.conduit;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class ConduitTest {
    @Test
    void testParallel() {
        Results results = Runner.path("classpath:api/conduit/signup.feature")
                .parallel(2);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
