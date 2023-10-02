package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.RoleEnum;
import com.shsoftvina.erpshsoftvina.enums.user.StatusUserEnum;
import com.shsoftvina.erpshsoftvina.exception.UnauthorizedException;
import com.shsoftvina.erpshsoftvina.model.request.user.*;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
import com.shsoftvina.erpshsoftvina.model.response.users.UserAccountingResponse;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import com.shsoftvina.erpshsoftvina.utils.EnumUtils;
import com.shsoftvina.erpshsoftvina.utils.FileUtils;
import com.shsoftvina.erpshsoftvina.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class UserConverter {

    @Autowired
    ContractConverter contractConverter;

    public UserDetailResponse toUserDetailResponse(User user) {

        User userCurrent = Principal.getUserCurrent();
        if(user.getRole() == null)
            throw new UnauthorizedException(MessageErrorUtils.unknown("Role"));
        else{
            if(!user.getRole().equals(userCurrent.getRole()) && userCurrent.getRole().equals(RoleEnum.DEVELOPER)){
                throw new UnauthorizedException(MessageErrorUtils.unauthorized());
            }
        }

        List<ContractResponse> contracts = null;

        RoleEnum userCurrentRole = Principal.getUserCurrent().getRole();
        if(!userCurrentRole.equals(RoleEnum.DEVELOPER))
            contracts = contractConverter.toListResponse(user.getContracts());

        return UserDetailResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .dateOfBirth(DateUtils.formatDate(user.getDateOfBirth()))
                .phone(user.getPhone())
                .emergencyPhone(user.getEmergencyPhone())
                .avatar(FileUtils.getPathUpload(User.class, user.getAvatar()))
                .type(EnumUtils.instance(user.getType()))
                .department(EnumUtils.instance(user.getDepartment()))
                .atm(user.getAtm())
                .email(user.getEmail())
                .role(EnumUtils.instance(user.getRole()))
                .position(EnumUtils.instance(user.getPosition()))
                .address(user.getAddress())
                .timesheetsCode(user.getTimesheetsCode())
                .contracts(contracts)
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
                .avatar(avatar)
                .resume(resume)
                .timesheetsCode(userUpdateProfileRequest.getTimesheetsCode())
                .build();
    }
}
