
package com.shsoftvina.erpshsoftvina.model.response.contract;

import com.shsoftvina.erpshsoftvina.model.response.insurance.InsuranceResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ContractResponse {
    private String id;
    private String basicSalary;
    private String allowance;
    private InsuranceResponse insurance;
    private String contract;
    private String createdDate;
}
