package com.shsoftvina.erpshsoftvina.model.request.contract;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateContractRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field basicSalary is not filled")
    private String basicSalary;

    @NotBlank(message = "Field allowance is not filled")
    private String allowance;

    @NotBlank(message = "Field insuranceType is not filled")
    private String insuranceType;

    @NotBlank(message = "Field insuranceMoney is not filled")
    private String insuranceMoney;

    @NotNull(message = "Field contract is not filled")
    private MultipartFile contract;
}