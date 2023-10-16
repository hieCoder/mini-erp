
package com.shsoftvina.erpshsoftvina.utils;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;


public class DateUtils {
    public static Date getDefaultStartDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    public static String formatDateTime(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            return sdf.format(date);
        }
        return null;
    }

    public static String formatTime(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
            return sdf.format(date);
        }
        return null;
    }

    public static String formatDate(Date date) {
        if(date != null){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.format(date);
        }
        return null;
    }

    public static String formatTime(Time time) {
        if(time != null){
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
            return sdf.format(time);
        }
        return null;
    }

    public static String formatLocalDateTime(LocalDateTime time) {

        // Define a DateTimeFormatter for the desired format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        // Format the LocalDateTime to a string
        return time.format(formatter);
    }

    public static String formatMonthYear(LocalDateTime time) {

        // Define a DateTimeFormatter for the desired format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");

        // Format the LocalDateTime to a string
        return time.format(formatter);
    }


    public static String timeWork(Time startDate, Time endDate) {

        if(startDate == null || endDate == null) return null;

        LocalTime localStartTime = startDate.toLocalTime();
        LocalTime localEndTime = endDate.toLocalTime();

        Duration duration = Duration.between(localStartTime, localEndTime);

        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();
        long seconds = duration.toSecondsPart();

        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
    }
}
