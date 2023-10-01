package com.shsoftvina.erpshsoftvina.model.request.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserUpdateProfileRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field fullname is not filled")
    private String fullname;

    @NotBlank(message = "Field address is not filled")
    private String address;

    @NotNull(message = "Field dateOfBirth is not filled")
    private Date dateOfBirth;

    @NotBlank(message = "Field phone is not filled")
    private String phone;

    private String emergencyPhone;
    private MultipartFile avatar;
}