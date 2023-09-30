package com.shsoftvina.erpshsoftvina.converter.user;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.BasicUserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
                .workingday(user.getWorkingDay().split(","))
                .contract(user.getContract().split(","))
                .basicSalary(user.getBasicSalary().split(","))
                .allowance(user.getAllowance().split(","))
                .insurance(user.getInsurance().split(","))
                .atm(user.getAtm())
                .email(user.getEmail())
                .role(user.getRole())
                .status(user.getStatus())
                .address(user.getAddress())
                .build();
    }

    public BasicUserDetailResponse toProfileResponse(User user) {
        return BasicUserDetailResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .dateOfBirth(user.getDateOfBirth())
                .phone(user.getPhone())
                .emergencyPhone(user.getEmergencyPhone())
                .avatar(user.getAvatar())
                .type(user.getType())
                .department(user.getDepartment())
                .workingday(user.getWorkingDay().split(","))
                .email(user.getEmail())
                .password(user.getPassword())
                .role(user.getRole())
                .status(user.getStatus())
                .position(user.getPosition())
                .resume(user.getResume())
                .build();
    }

    public ShowUserRespone toShowUserRespone(User user) {
        return ShowUserRespone.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .department(user.getDepartment())
                .email(user.getEmail())
                .position(user.getPosition())
                .build();
    }

    public List<ShowUserRespone> toListShowUserRespone(List<User> listUser) {
        return listUser.stream().map(this::toShowUserRespone).collect(Collectors.toList());
    }

    public User toEntity(UserActiveRequest userActiveRequest) {
        return User.builder()
                .id(userActiveRequest.getId())
                .role(userActiveRequest.getRole())
                .email(userActiveRequest.getEmail())
                .status(userActiveRequest.getStatus())
                .build();
    }

//    public User userUpdateRequestToEntity(UserUpdateRequest userUpdateRequest) {
//        return User.builder()
//                .allowance(userUpdateRequest.getAllowance())
//                .atm(userUpdateRequest.getAtm())
//                .insurance(userUpdateRequest.getInsurance())
//                .role(userUpdateRequest.getRole())
//                .avatar(null)
//                .id(userUpdateRequest.getId())
//                .basicSalary(userUpdateRequest.getBasicSalary())
//                .contract(null)
//                .dateOfBirth(userUpdateRequest.getDateOfBirth())
//                .department(userUpdateRequest.getDepartment())
//                .emergencyPhone(userUpdateRequest.getEmergencyPhone())
//                .email(userUpdateRequest.getEmail())
//                .phone(userUpdateRequest.getPhone())
//                .jobStartDate(userUpdateRequest.getJobStartDate())
//                .role(userUpdateRequest.getRole())
//                .status(userUpdateRequest.getStatus())
//                .fullname(userUpdateRequest.getFullname())
//                .build();
//    }

//    public User userCreateRequestToEntity(UserCreateRequest userUpdateRequest) {
//        return User.builder()
//                .allowance(userUpdateRequest.getAllowance())
//                .atm(userUpdateRequest.getAtm())
//                .insurance(userUpdateRequest.getInsurance())
//                .role(userUpdateRequest.getRole())
//                .avatar(null)
//                .id(UUID.randomUUID().toString())
//                .basicSalary(userUpdateRequest.getBasicSalary())
//                .contract(null)
//                .dateOfBirth(userUpdateRequest.getDateOfBirth())
//                .department(userUpdateRequest.getDepartment())
//                .emergencyPhone(userUpdateRequest.getEmergencyPhone())
//                .email(userUpdateRequest.getEmail())
//                .phone(userUpdateRequest.getPhone())
//                .jobStartDate(userUpdateRequest.getJobStartDate())
//                .role(userUpdateRequest.getRole())
//                .status(userUpdateRequest.getStatus())
//                .fullname(userUpdateRequest.getFullname())
//                .password(new BCryptPasswordEncoder().encode(userUpdateRequest.getPassword()))
//                .build();
//    }

    public User userRegisterRequestToEntity(UserRegisterRequest userRegisterRequest) {
        return User.builder()
                .status(StatusUserEnum.PENDING)
                .id(UUID.randomUUID().toString())
                .email(userRegisterRequest.getEmail())
                .password(new BCryptPasswordEncoder().encode(userRegisterRequest.getPassword()))
                .build();
    }

    public UserAccountingResponse toAccountResponse(User user) {
        return UserAccountingResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .build();
    }
}
