package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.*;
import com.shsoftvina.erpshsoftvina.model.dto.EnumDto;
import com.shsoftvina.erpshsoftvina.model.request.user.*;
import com.shsoftvina.erpshsoftvina.model.response.users.BasicUserDetailResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.StringUtils;
import liquibase.pro.packaged.D;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class UserConverter {

    public UserDetailResponse toUserDetailResponse(User user) {
        return UserDetailResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .dateOfBirth(DateUtils.formatDate(user.getDateOfBirth()))
                .phone(user.getPhone())
                .emergencyPhone(user.getEmergencyPhone())
                .avatar(FileUtils.getPathUpload(User.class, user.getAvatar()))
                .type(EnumUtils.instance(user.getType()))
                .department(EnumUtils.instance(user.getDepartment()))
                .workingday(StringUtils.split(user.getWorkingDay(), ","))
                .contract(StringUtils.splitPathFile(User.class, user.getContract(), ","))
                .basicSalary(StringUtils.split(user.getBasicSalary(), ","))
                .allowance(StringUtils.split(user.getAllowance(), ","))
                .insurance(StringUtils.split(user.getInsurance(), ","))
                .atm(user.getAtm())
                .email(user.getEmail())
                .role(EnumUtils.instance(user.getRole()))
                .position(EnumUtils.instance(user.getPosition()))
                .address(user.getAddress())
                .timesheetsCode(user.getTimesheetsCode())
                .build();
    }

    public BasicUserDetailResponse toBasicUserDetailResponse(User user) {
        return BasicUserDetailResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .dateOfBirth(DateUtils.formatDate(user.getDateOfBirth()))
                .phone(user.getPhone())
                .emergencyPhone(user.getEmergencyPhone())
                .avatar(user.getAvatar())
                .type(EnumUtils.instance(user.getType()))
                .department(EnumUtils.instance(user.getDepartment()))
                .workingday(StringUtils.split(user.getWorkingDay(), ","))
                .email(user.getEmail())
                .role(EnumUtils.instance(user.getRole()))
                .position(EnumUtils.instance(user.getPosition()))
                .resume(user.getResume())
                .timesheetsCode(user.getTimesheetsCode())
                .build();
    }

    public ShowUserRespone toShowUserRespone(User user) {
        return ShowUserRespone.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .department(EnumUtils.instance(user.getDepartment()))
                .email(user.getEmail())
                .position(EnumUtils.instance(user.getPosition()))
                .build();
    }

    public List<ShowUserRespone> toListShowUserRespone(List<User> listUser) {
        return listUser.stream().map(this::toShowUserRespone).collect(Collectors.toList());
    }

    public User toEntity(UserActiveRequest userActiveRequest) {
        return User.builder()
                .id(userActiveRequest.getId())
                .role(RoleEnum.valueOf(userActiveRequest.getRole()))
                .email(userActiveRequest.getEmail())
                .status(StatusUserEnum.valueOf(userActiveRequest.getStatus()))
                .isFirstUpdateProfile(UserConstant.DEFAULT_FIRST_UPDATE_PROFILE)
                .build();
    }

    public User userUpdateRequestToEntity(UserUpdateRequest userUpdateRequest, String avatar, String resume, String contract) {
//        TypeUserEnum type = userUpdateRequest.getType()!=null?TypeUserEnum.valueOf(userUpdateRequest.getType()):null;
//        DepartmentEnum department = userUpdateRequest.getDepartment()!=null?DepartmentEnum.valueOf(userUpdateRequest.getDepartment()):null;
//        PositionEnum position = userUpdateRequest.getPosition()!=null?PositionEnum.valueOf(userUpdateRequest.getPosition()):null;
//        RoleEnum role = userUpdateRequest.getRole()!=null?RoleEnum.valueOf(userUpdateRequest.getRole()):null;
//        StatusUserEnum statusUserEnum = userUpdateRequest.getStatus()!=null?StatusUserEnum.valueOf(userUpdateRequest.getStatus()):null;
//        return User.builder()
//                .fullname(userUpdateRequest.getFullname())
//                .address(userUpdateRequest.getAddress())
//                .dateOfBirth(userUpdateRequest.getDateOfBirth())
//                .phone(userUpdateRequest.getPhone())
//                .emergencyPhone(userUpdateRequest.getEmergencyPhone())
//                .avatar(avatar)
//                .type(type)
//                .department(department)
//                .workingDay(DateUtils.formatDate(userUpdateRequest.getWorkingDay()))
//                .contract(contract)
//                .basicSalary(userUpdateRequest.getBasicSalary())
//                .allowance(userUpdateRequest.getAllowance())
//                .insurance(userUpdateRequest.getInsurance())
//                .atm(userUpdateRequest.getAtm())
//                .email(userUpdateRequest.getEmail())
//                .password(userUpdateRequest.getPassword())
//                .role(role)
//                .status(statusUserEnum)
//                .position(position)
//                .resume(resume)
//                .isFirstUpdateProfile(true)
//                .timesheetsCode(userUpdateRequest.getTimesheetsCode())
//                .build();
        return  null;
    }

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

    public User userCreateAdminRequestToEntity(UserCreateAdminRequest userCreateAdminRequest) {
        return User.builder()
                .id(UUID.randomUUID().toString())
                .email(userCreateAdminRequest.getEmail())
                .password(new BCryptPasswordEncoder().encode(userCreateAdminRequest.getPassword()))
                .role(RoleEnum.valueOf(userCreateAdminRequest.getRole()))
                .status(StatusUserEnum.ACTIVE)
                .isFirstUpdateProfile(false)
                .build();
    }

    public User toEntity(UserRegisterRequest userRegisterRequest) {
        return User.builder()
                .fullname(userRegisterRequest.getFullname())
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

    public User toEntity(UserUpdateProfileRequest userUpdateProfileRequest, String avatar, String resume) {
        return User.builder()
                .id(userUpdateProfileRequest.getId())
                .fullname(userUpdateProfileRequest.getFullname())
                .address(userUpdateProfileRequest.getAddress())
                .phone(userUpdateProfileRequest.getPhone())
                .emergencyPhone(userUpdateProfileRequest.getEmergencyPhone())
                .dateOfBirth(userUpdateProfileRequest.getDateOfBirth())
                .resume(resume)
                .avatar(avatar)
                .build();
    }
}
