package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.oc_and_tl.OCAndTLCategoryEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OCAndTL {
    private String id;
    private OCAndTLCategoryEnum category;
    private String target;
    private boolean performance;
    private User user;
    private Date day;
}