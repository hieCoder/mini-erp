package com.shsoftvina.erpshsoftvina.model.response.accounting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RemainBalanceEachMonth {
    private String yearMonth;
    private String remain;
}
