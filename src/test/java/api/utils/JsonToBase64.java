package api.utils;

import java.util.Base64;

public class JsonToBase64 {

    public static String encodeJsonToBase64(String jsonString) {
        // Encode the JSON string to base64
        byte[] bytes = Base64.getEncoder().encode(jsonString.getBytes());
        return new String(bytes);
    }
}
