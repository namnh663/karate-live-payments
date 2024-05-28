package api.liveportal;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.tesults.junit5.TesultsListener;

class LiveportalTest {

    @Test
    void ExecuteAll(TestInfo testInfo) throws IOException {
        Results results = Runner.path("classpath:api/liveportal")
                .parallel(2);
        TesultsListener.file(testInfo, "target/karate.log");
        TesultsListener.file(testInfo, "target/karate-reports/karate-summary-json.txt");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}