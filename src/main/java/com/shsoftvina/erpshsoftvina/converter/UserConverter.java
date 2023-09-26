package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.UserCreateRequestDTO;
import com.shsoftvina.erpshsoftvina.model.response.UserDetailResponseDTO;
import org.springframework.stereotype.Component;

@Component
public class UserConverter {
    public UserDetailResponseDTO convertEntityToDetailResponse(User user) {
        return UserDetailResponseDTO.builder()
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
                .build();
    }

    public User convertCreateRequestToEntity(UserCreateRequestDTO userCreateRequestDTO) {
        return User.builder()
                .id(userCreateRequestDTO.getId())
                .username(userCreateRequestDTO.getUsername())
                .email(userCreateRequestDTO.getEmail())
                .role(userCreateRequestDTO.getRole())
                .status(userCreateRequestDTO.getChoice())
                .build();
    }
}
