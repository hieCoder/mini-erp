package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.UserDetailResponse;
import org.springframework.stereotype.Component;

@Component
public class UserConverter {
    public UserDetailResponse convertEntityToDetailResponse(User user) {
        return UserDetailResponse.builder()
                .allowance(user.getAllowance())
                .atm(user.getAtm())
                .insurance(user.getId())
                .role(user.getRole())
                .avatar(user.getAvatar())
                .id(user.getId())
                .basicSalary(user.getBasicSalary())
                .contract(user.getContract())
                .dateOfBirth(user.getDateOfBirth())
                .department(user.getDepartment())
                .emergencyPhone(user.getEmergencyPhone())
                .email(user.getEmail())
                .phone(user.getPhone())
                .jobStartDate(user.getJobStartDate())
                .status(user.getStatus())
                .fullname(user.getFullname())
                .username(user.getUsername())
                .build();
    }

    public User toEntity(UserActiveRequest userActiveRequest) {
        return User.builder()
                .id(userActiveRequest.getId())
                .role(userActiveRequest.getRole())
                .email(userActiveRequest.getEmail())
                .status(userActiveRequest.getStatus())
                .build();
    }
}
