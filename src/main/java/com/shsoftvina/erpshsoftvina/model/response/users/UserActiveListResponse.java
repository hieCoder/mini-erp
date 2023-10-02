
package com.shsoftvina.erpshsoftvina.model.response.users;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserActiveListResponse {
    private String id;
    private String username;
    private String email;
    private String role;
    private String status;
}
