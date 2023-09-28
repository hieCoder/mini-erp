package com.shsoftvina.erpshsoftvina.converter.user;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.UUID;
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

    public User userCreateRequestToEntity(UserCreateRequest userUpdateRequest) {
        return User.builder()
                .username(userUpdateRequest.getUsername())
                .allowance(userUpdateRequest.getAllowance())
                .atm(userUpdateRequest.getAtm())
                .insurance(userUpdateRequest.getInsurance())
                .role(userUpdateRequest.getRole())
                .avatar(null)
                .id(UUID.randomUUID().toString())
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
                .password(new BCryptPasswordEncoder().encode(userUpdateRequest.getPassword()))
                .build();
    }

    public User userRegisterRequestToEntity(UserRegisterRequest userRegisterRequest) {
        return User.builder()
                .username(userRegisterRequest.getUsername())
                .status(StatusUserEnum.PENDING)
                .id(UUID.randomUUID().toString())
                .email(userRegisterRequest.getEmail())
                .password(new BCryptPasswordEncoder().encode(userRegisterRequest.getPassword()))
                .build();
    }
}
