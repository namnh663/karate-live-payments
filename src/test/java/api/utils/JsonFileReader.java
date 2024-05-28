package api.utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class JsonFileReader {
    private static final Logger LOGGER = Logger.getLogger(JsonFileReader.class.getName());

    public static String readJsonFromFile(String filePath) {
        StringBuilder stringBuilder = new StringBuilder();

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "An error occurred while reading the JSON file", e);
            // You can choose to handle the exception differently here
            // For example, you might return a default value or throw a custom exception
        }

        return stringBuilder.toString();
    }
}
