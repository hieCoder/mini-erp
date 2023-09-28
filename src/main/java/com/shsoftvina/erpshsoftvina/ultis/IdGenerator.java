package com.shsoftvina.erpshsoftvina.ultis;

import java.util.UUID;

public class IdGenerator {
    public static String newId() {
        UUID uuid = UUID.randomUUID();
        String id = uuid.toString();
        return id;
    }
}
