package api.utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONArray;
import org.json.JSONObject;

public class SlackReporter {
    static String SLACK_PATH = "src/test/java/api/data/slack.json";
    static String TXT_PATH = "target/karate-reports/karate-summary-json.txt";

    /**
     * Sends a message using a webhook URL to a specified channel.
     * @param webhookUrl the URL of the webhook to send the message to
     */
    public static void sendMessage(String webhookUrl) {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(webhookUrl);
            // Set the content type header
            httpPost.setHeader("Content-Type", "application/json");

            // Read data from the .txt file
            String txtContent = new String(Files.readAllBytes(Paths.get(TXT_PATH)));
            JSONObject txtJson = new JSONObject(txtContent);
            // Read data from the .json file
            String jsonContent = new String(Files.readAllBytes(Paths.get(SLACK_PATH)));
            JSONObject json = new JSONObject(jsonContent);
            // Update JSON fields
            JSONArray fields = json.getJSONArray("blocks")
                    .getJSONObject(1)
                    .getJSONArray("fields");

            fields.getJSONObject(0).put("text", "*Features Passed:* " + txtJson.getInt("featuresPassed"));
            fields.getJSONObject(1).put("text", "*Features Failed:* " + txtJson.getInt("featuresFailed"));
            fields.getJSONObject(2).put("text", "*Scenarios Passed:* " + txtJson.getInt("scenariosPassed"));
            fields.getJSONObject(3).put("text", "*Scenarios Failed:* " + txtJson.getInt("scenariosfailed"));
            // Write updated JSON back to .json file
            Files.write(Paths.get(SLACK_PATH), json.toString(4).getBytes());

            // Create JSON payload
            String jsonPayload = JsonFileReader.readJsonFromFile(SLACK_PATH);
            // Set the JSON payload as the entity of the HTTP POST request
            HttpEntity entity = new StringEntity(jsonPayload, ContentType.APPLICATION_JSON);
            httpPost.setEntity(entity);
            // Execute the request and get the response
            HttpResponse response = httpClient.execute(httpPost);
            // Print the response status code
            System.out.println("Response status code: " + response.getStatusLine().getStatusCode());
        } catch (IOException e) {
            System.err.println("Error reading or writing JSON file: " + e.getMessage());
        }
    }
}
