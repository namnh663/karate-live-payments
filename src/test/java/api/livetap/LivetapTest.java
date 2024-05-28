package api.livetap;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class LivetapTest {
    @Test
    void testParallel() throws IOException {
        Results results = Runner.path("classpath:api/livetap")
                .parallel(2);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
