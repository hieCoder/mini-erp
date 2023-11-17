
package com.shsoftvina.erpshsoftvina.model.response.contract;

import com.shsoftvina.erpshsoftvina.model.response.allowance.AllowanceResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ContractResponse {
    private String id;
    private String basicSalary;
    private String files;
    private String createdDate;
    private String insurance;
    private List<ContractResponse> historyContract;
    private List<AllowanceResponse> allowances;
}
