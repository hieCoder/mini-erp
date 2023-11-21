package com.shsoftvina.erpshsoftvina.model.request.contract;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateContractRequest {

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    @NotBlank(message = "Field basicSalary is not filled")
    private String basicSalary;

    @NotBlank(message = "Field allowanceInsurances is not filled")
    private String allowanceInsurances;

    private String parentId;
    private MultipartFile file;
}