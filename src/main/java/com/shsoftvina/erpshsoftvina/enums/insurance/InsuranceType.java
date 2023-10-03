package com.shsoftvina.erpshsoftvina.enums.insurance;

public enum InsuranceType {

    HEALTH_INSURANCE("Health insurance"), SOCIAL_INSURANCE("Social insurance");

    private String value;

    InsuranceType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
