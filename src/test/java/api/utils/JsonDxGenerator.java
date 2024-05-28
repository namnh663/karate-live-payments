package api.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.TimeZone;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;

public class JsonDxGenerator {
    public static JSONArray generateJsonDx() {
        JSONArray jsonArray = new JSONArray();

        for (int i = 0; i < 1; i++) {
            JSONObject jsonObject = new JSONObject();
            Random random = new Random();
            int tipAmount = random.nextInt(100);
            int surchargeAmount = random.nextInt(100);
            int fareAmount = random.nextInt(100);

            // Generate random values for fields
            jsonObject.put("pan", generateRandomNumbers(16));
            jsonObject.put("rrn", generateRandomNumbers(3));
            jsonObject.put("actionCode", generateRandomActionCode());
            jsonObject.put("approvalStatus", true);
            jsonObject.put("cardExpiry", "3003");
            jsonObject.put("cardScheme", 1);
            jsonObject.put("cardType", 2);
            jsonObject.put("originalUuid", JSONObject.NULL);
            jsonObject.put("batchId", "12345678-1234-4444-a123-" + generateRandomNumbers(12));
            jsonObject.put("batchNumber", "0703202401");
            jsonObject.put("currencyCode", 36);
            jsonObject.put("effectivePaymentMean", 4);
            jsonObject.put("isOnlineTransaction", false);
            jsonObject.put("paymentAppVersion", "1.0.16");
            jsonObject.put("userId", generateRandomString(3));
            jsonObject.put("businessId", "retaildx");
            jsonObject.put("stan", generateRandomNumbers(1));
            jsonObject.put("terminalId", "47007194");
            jsonObject.put("aid", "");
            jsonObject.put("transactionType", generateRandomTransactionType());
            jsonObject.put("transactionUuid", UUID.randomUUID().toString());
            jsonObject.put("transactionLocalDateTime", generateRandomDateTime());
            jsonObject.put("startShiftTime", "2023-03-07 12:33:51+07:00");
            jsonObject.put("transactionState", "COMPLETED");
            jsonObject.put("transactionStatus", "TXN_STATUS_TXN_APPROVED");
            jsonObject.put("transactionTotalAmount", tipAmount + surchargeAmount + fareAmount);
            jsonObject.put("fareAmount", fareAmount);
            jsonObject.put("tollAmount", 0);
            jsonObject.put("otherAmount", 0);
            jsonObject.put("tipAmount", tipAmount);
            jsonObject.put("levyAmount", 0);
            jsonObject.put("serviceChargeAmount", 0);
            jsonObject.put("gstServiceCharge", 0);
            jsonObject.put("surchargeAmount", surchargeAmount);
            jsonObject.put("surchargeRate", 0);
            jsonObject.put("gstSurcharge", 0);
            jsonObject.put("transactionId", generateRandomNumbers(12));
            jsonObject.put("vaaAppVersion", "1.0");
            jsonObject.put("vaaConfigurationVersion", "220808888888");
            jsonObject.put("pickUp", "Work");
            jsonObject.put("dropOff", "Home");
            jsonObject.put("motoType", 0);
            jsonObject.put("isFallbackTransaction", false);
            jsonObject.put("cashback", 0);
            jsonObject.put("cashout", 0);
            jsonObject.put("receiptHeaderText", generateRandomString(1));
            jsonObject.put("receiptFooterText", generateRandomString(1));
            jsonObject.put("tvr", generateRandomString(1));
            jsonObject.put("approvalCode", generateRandomNumbers(6));
            jsonObject.put("invoiceId", generateRandomNumbers(2));
            jsonObject.put("receiptNumber", generateRandomNumbers(2));
            jsonObject.put("merchantId", "00002547038938");

            jsonArray.put(jsonObject);
        }

        return jsonArray;
    }

    // Method to generate a random action code
    public static String generateRandomActionCode() {
        Random random = new Random();
        String[] actionCodes = { "00", "01", "02", "03", "04", "05", "06", "07", "08", "09" };
        return actionCodes[random.nextInt(actionCodes.length)];
    }

    // Method to generate a random string of given length
    public static String generateRandomString(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
    }

    // Method to generate a random numbers of given length
    public static String generateRandomNumbers(int length) {
        String characters = "0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
    }

    // Method to generate a random transaction type
    public static String generateRandomTransactionType() {
        Random random = new Random();
        String[] transactionTypes = { "Sale" };
        return transactionTypes[random.nextInt(transactionTypes.length)];
    }

    // Method to generate a random date-time string
    public static String generateRandomDateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ssXXX");
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
        return sdf.format(new Date());
    }
}
