package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.constant.UserConstant;
import com.shsoftvina.erpshsoftvina.entity.User;

import com.shsoftvina.erpshsoftvina.enums.user.*;
import com.shsoftvina.erpshsoftvina.exception.UnauthorizedException;
import com.shsoftvina.erpshsoftvina.mapper.UserMapper;
import com.shsoftvina.erpshsoftvina.model.request.user.*;
import com.shsoftvina.erpshsoftvina.model.response.contract.ContractResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.FullnameAndAvatarResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserShowResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.IdAndFullnameUserResponse;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.security.Principal;
import com.shsoftvina.erpshsoftvina.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class UserConverter {

    @Autowired
    private ContractConverter contractConverter;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserMapper userMapper;

    public UserDetailResponse toUserDetailResponse(User user) {

        List<ContractResponse> contracts = null;

        RoleEnum userCurrentRole = Principal.getUserCurrent().getRole();
        if (!userCurrentRole.equals(RoleEnum.DEVELOPER))
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
                .resume(user.getResume())
                .role(EnumUtils.instance(user.getRole()))
                .position(EnumUtils.instance(user.getPosition()))
                .address(user.getAddress())
                .timesheetsCode(user.getTimesheetsCode())
                .contracts(contracts)
                .createdDate(DateUtils.formatDateTime(user.getCreatedDate()))
                .gender(EnumUtils.instance(user.getGender()))
                .build();
    }

    public UserShowResponse toShowUserRespone(User user) {
        return UserShowResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .department(EnumUtils.instance(user.getDepartment()))
                .email(user.getEmail())
                .position(EnumUtils.instance(user.getPosition()))
                .createdDate(DateUtils.formatDateTime(user.getCreatedDate()))
                .build();
    }

    public List<UserShowResponse> toListShowUserResponse(List<User> listUser) {
        return listUser.stream().map(this::toShowUserRespone).collect(Collectors.toList());
    }

    public User toEntity(UserActiveRequest userActiveRequest) {
        return User.builder()
                .id(userActiveRequest.getId())
                .role(RoleEnum.valueOf(userActiveRequest.getRole()))
                .email(userActiveRequest.getEmail())
                .status(StatusUserEnum.valueOf(userActiveRequest.getStatus()))
                .avatar(UserConstant.AVATAR_DEFAULT)
                .build();
    }

    public User toUpdateDetail(UserUpdateRequest userUpdateRequest, String newAvatarFileName, String newResumeFileName) {

        User userDb = userMapper.findById(userUpdateRequest.getId());

        User user = toUpdateBasic(userUpdateRequest, newAvatarFileName, newResumeFileName);
        user.setType(EnumUtils.getEnumFromValue(TypeUserEnum.class, userUpdateRequest.getType()));
        user.setDepartment(EnumUtils.getEnumFromValue(DepartmentEnum.class, userUpdateRequest.getDepartment()));
        user.setEmail(userUpdateRequest.getEmail());
        user.setPassword(userUpdateRequest.getPassword() != null? passwordEncoder.encode(userUpdateRequest.getPassword()): userDb.getPassword());
        user.setRole(EnumUtils.getEnumFromValue(RoleEnum.class, userUpdateRequest.getRole()));
        user.setPosition(EnumUtils.getEnumFromValue(PositionEnum.class, userUpdateRequest.getPosition()));
        return user;
    }

    public User toUpdateBasic(UserUpdateRequest userUpdateRequest, String newAvatarFileName, String newResumeFileName) {
        return User.builder()
                .id(userUpdateRequest.getId())
                .fullname(userUpdateRequest.getFullname())
                .address(userUpdateRequest.getAddress())
                .dateOfBirth(userUpdateRequest.getDateOfBirth())
                .phone(userUpdateRequest.getPhone())
                .emergencyPhone(userUpdateRequest.getEmergencyPhone())
                .avatar(newAvatarFileName)
                .resume(newResumeFileName)
                .timesheetsCode(userUpdateRequest.getTimesheetsCode())
                .atm(userUpdateRequest.getAtm())
                .gender(EnumUtils.getEnumFromValue(GenderEnum.class, userUpdateRequest.getGender()))
                .build();
    }

    public User toEntity(UserRegisterRequest userRegisterRequest) {
        return User.builder()
                .fullname(userRegisterRequest.getFullname())
                .status(StatusUserEnum.PENDING)
                .id(ApplicationUtils.generateId())
                .email(userRegisterRequest.getEmail())
                .password(new BCryptPasswordEncoder().encode(userRegisterRequest.getPassword()))
                .createdDate(new Date())
                .build();
    }

    public IdAndFullnameUserResponse toIdAndFullnameUserResponse(User user) {
        if(user == null) return null;
        return IdAndFullnameUserResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .build();
    }

    public FullnameAndAvatarResponse toFullnameAndAvatarResponse(User user) {
        if(user == null) return null;
        return FullnameAndAvatarResponse.builder()
                .id(user.getId())
                .fullname(user.getFullname())
                .avatar(FileUtils.getPathUpload(User.class, user.getAvatar()))
                .build();
    }
}
