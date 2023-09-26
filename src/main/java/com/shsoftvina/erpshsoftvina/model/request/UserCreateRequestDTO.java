package com.shsoftvina.erpshsoftvina.model.request;


import com.shsoftvina.erpshsoftvina.enums.RoleEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserCreateRequestDTO {
    private String id;
    private String username;
    private String email;
    private RoleEnum role;
    private String choice;
}
