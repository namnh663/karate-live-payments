package api.utils;

import java.util.Random;

public class CompanyDataGenerator {
    public static String randomMid() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
        Random random = new Random();
        int length = random.nextInt(30) + 1;
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++) {
            result.append(characters.charAt(random.nextInt(characters.length())));
        }

        return result.toString();
    }

    public static String randomLivePaymentMid() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
        Random random = new Random();
        int length = random.nextInt(30) + 1;
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++) {
            result.append(characters.charAt(random.nextInt(characters.length())));
        }

        return result.toString();
    }

    public static String randomPostcode() {
        Random random = new Random();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < 4; i++) {
            result.append(random.nextInt(10)); // Generates random digit (0-9)
        }

        return result.toString();
    }
}
