package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.ultis.FileUtils;
import org.springframework.stereotype.Component;

@Component
public class UserConverter {
    public UserDetailResponse ToUserDetailResponse(User user) {
        return UserDetailResponse.builder()
                .username(user.getUsername())
                .allowance(user.getAllowance())
                .atm(user.getAtm())
                .insurance(user.getInsurance())
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
                .role(user.getRole())
                .status(user.getStatus())
                .fullname(user.getFullname())
                .build();
    }

    public User userUpdateRequestToEntity(UserUpdateRequest userUpdateRequest) {
        return User.builder()
                .username(userUpdateRequest.getUsername())
                .allowance(userUpdateRequest.getAllowance())
                .atm(userUpdateRequest.getAtm())
                .insurance(userUpdateRequest.getInsurance())
                .role(userUpdateRequest.getRole())
                .avatar(null)
                .id(userUpdateRequest.getId())
                .basicSalary(userUpdateRequest.getBasicSalary())
                .contract(null)
                .dateOfBirth(userUpdateRequest.getDateOfBirth())
                .department(userUpdateRequest.getDepartment())
                .emergencyPhone(userUpdateRequest.getEmergencyPhone())
                .email(userUpdateRequest.getEmail())
                .phone(userUpdateRequest.getPhone())
                .jobStartDate(userUpdateRequest.getJobStartDate())
                .role(userUpdateRequest.getRole())
                .status(userUpdateRequest.getStatus())
                .fullname(userUpdateRequest.getFullname())
                .build();
    }
}
