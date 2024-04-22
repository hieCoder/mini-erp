package com.shsoftvina.erpshsoftvina.enums.tag;

public enum TypeTagEnum {

    DEFAULT_TAG("default tag"), TAG_ADDED("tag added");

    private String value;

    TypeTagEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
