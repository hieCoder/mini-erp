
package com.shsoftvina.erpshsoftvina.model.response.contract;

import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.model.response.commenttask.CommentTaskResponse;
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
    private String allowance;
    private String contract;
    private String createdDate;
    private EnumDto insuranceType;
    private String insuranceMoney;
    private List<ContractResponse> historyContract;
}
