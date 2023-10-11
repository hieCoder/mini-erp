package com.shsoftvina.erpshsoftvina.enums.oc_and_tl;

public enum OCAndTLCategoryEnum {

    THE_SINGLE_MOST_IMPORTANT_THING("The single most important thing"),
    LECTURE("Lecture"),
    DAILY_EVALUATION("Daily evaluation"),
    WORK("Work"),
    READING("Reading"),
    SIX_TWELVE_PM("1Q 6~12pm"),
    TWELVE_SIX_PM("2Q 12~6pm"),
    SIX_TWELVE_AM("3Q 6~12am");

    private String value;

    OCAndTLCategoryEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
