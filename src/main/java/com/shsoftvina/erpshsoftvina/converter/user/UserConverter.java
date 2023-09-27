package com.shsoftvina.erpshsoftvina.converter.user;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.UserResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class UserConverter {

    public UserResponse toResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .dateOfBirth(user.getDepartment())
                .phone(user.getPhone())
                .emergencyPhone(user.getEmergencyPhone())
                .avatar(user.getAvatar())
                .type(user.getType())
                .department(user.getDepartment())
                .jobStartDate(user.getJobStartDate())
                .contract(user.getContract())
                .basicSalary(user.getBasicSalary())
                .allowance(user.getAllowance())
                .insurance(user.getInsurance())
                .atm(user.getAtm())
                .username(user.getUsername())
                .email(user.getEmail())
                .role(user.getRole())
                .status(user.getStatus())
                .build();
    }

    public List<UserResponse> toListResponse(List<User> listUser) {
        return listUser.stream().map(user -> UserResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .department(user.getDepartment())
                .type(user.getType())
                .status(user.getStatus())
                .build()).collect(Collectors.toList());
    }

}
