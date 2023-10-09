
package com.shsoftvina.erpshsoftvina.model.response.contract;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ContractResponse {
    private String id;
    private String basicSalary;
    private String allowance;
    private String contract;
    private String createdDate;
    private EnumDto insuranceType;
    private String insuranceMoney;
}
