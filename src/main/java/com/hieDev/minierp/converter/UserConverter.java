package com.hieDev.minierp.converter;

import com.hieDev.minierp.enums.user.*;
import com.hieDev.minierp.security.Principal;
import com.hieDev.minierp.constant.UserConstant;
import com.hieDev.minierp.entity.User;
import com.shsoftvina.erpshsoftvina.enums.user.*;
import com.hieDev.minierp.mapper.UserMapper;
import com.hieDev.minierp.model.request.user.UserActiveRequest;
import com.hieDev.minierp.model.request.user.UserRegisterRequest;
import com.hieDev.minierp.model.request.user.UserUpdateRequest;
import com.hieDev.minierp.model.response.contract.ContractResponse;
import com.hieDev.minierp.model.response.user.FullnameAndAvatarResponse;
import com.hieDev.minierp.model.response.user.IdAndFullnameUserResponse;
import com.hieDev.minierp.model.response.user.UserDetailResponse;
import com.hieDev.minierp.model.response.user.UserShowResponse;
import com.hieDev.minierp.utils.ApplicationUtils;
import com.hieDev.minierp.utils.DateUtils;
import com.hieDev.minierp.utils.EnumUtils;
import com.hieDev.minierp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
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
                .accountHolderName(user.getAccountHolderName())
                .accountNumber(user.getAccountNumber())
                .bankName(user.getBankName())
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
        String timesheetsCode = userUpdateRequest.getTimesheetsCode();
        if (timesheetsCode.isEmpty()) timesheetsCode = null;
        return User.builder()
                .id(userUpdateRequest.getId())
                .fullname(userUpdateRequest.getFullname())
                .address(userUpdateRequest.getAddress())
                .dateOfBirth(userUpdateRequest.getDateOfBirth())
                .phone(userUpdateRequest.getPhone())
                .emergencyPhone(userUpdateRequest.getEmergencyPhone())
                .avatar(newAvatarFileName)
                .resume(newResumeFileName)
                .timesheetsCode(timesheetsCode)
                .accountHolderName(userUpdateRequest.getAccountHolderName())
                .accountNumber(userUpdateRequest.getAccountNumber())
                .bankName(userUpdateRequest.getBankName())
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

    public User toEntity(OAuth2User oAuth2User) {

        String fullname = (String) oAuth2User.getAttributes().get("username");
        String email = (String) oAuth2User.getAttributes().get("email");

        return User.builder()
                .fullname(fullname)
                .status(StatusUserEnum.PENDING)
                .id(ApplicationUtils.generateId())
                .email(email)
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
