package com.shsoftvina.erpshsoftvina.model.request.user;


import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserActiveRequest {
    private String id;
    private String email;
    private RoleEnum role;
    private StatusUserEnum status;
}
