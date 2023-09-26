package com.shsoftvina.erpshsoftvina.ultis;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LocalDateTimeFormater {
    public static String formatTime(LocalDateTime time) {

        // Define a DateTimeFormatter for the desired format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        // Format the LocalDateTime to a string
        return time.format(formatter);
    }
}
