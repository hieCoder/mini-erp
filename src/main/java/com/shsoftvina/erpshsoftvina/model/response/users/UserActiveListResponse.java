
package com.shsoftvina.erpshsoftvina.model.response.users;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
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
    private RoleEnum role;
    private String status;
}
