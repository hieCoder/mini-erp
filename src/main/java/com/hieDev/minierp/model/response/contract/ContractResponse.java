
package com.hieDev.minierp.model.response.contract;

import com.hieDev.minierp.model.response.allowance_insurance.AllowanceInsuranceResponse;
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
    private List<AllowanceInsuranceResponse> allowanceInsurances;
}
