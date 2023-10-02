
package com.shsoftvina.erpshsoftvina.model.response.users;

import lombok.Data;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
public class UserDetailResponse extends BasicUserDetailResponse{
    private String[] contract;
    private String[] basicSalary;
    private String[] allowance;
    private String[] insurance;
}
