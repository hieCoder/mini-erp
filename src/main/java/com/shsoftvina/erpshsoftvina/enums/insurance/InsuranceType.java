package com.shsoftvina.erpshsoftvina.enums.insurance;

public enum InsuranceType {

    BHYT("Bao hiem y te"), BHXH("Bao hiem xa hoi");

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
