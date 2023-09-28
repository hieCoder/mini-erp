package com.shsoftvina.erpshsoftvina.converter.user;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class UserConverter {

    public UserDetailResponse toResponse(User user) {
        return UserDetailResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .dateOfBirth(user.getDateOfBirth())
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

    public List<UserDetailResponse> toListResponse(List<User> listUser) {
        return listUser.stream().map(user -> UserDetailResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .department(user.getDepartment())
                .type(user.getType())
                .status(user.getStatus())
                .build()).collect(Collectors.toList());
    }

    public User toEntity(UserActiveRequest userActiveRequest) {
        return User.builder()
                .id(userActiveRequest.getId())
                .role(userActiveRequest.getRole())
                .email(userActiveRequest.getEmail())
                .status(userActiveRequest.getStatus())
                .build();
    }

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
