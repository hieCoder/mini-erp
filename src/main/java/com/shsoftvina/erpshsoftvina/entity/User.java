package com.shsoftvina.erpshsoftvina.entity;

import com.shsoftvina.erpshsoftvina.enums.user.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements UserDetails {

    private String id;
    private String fullname;
    private String address;
    private Date dateOfBirth;
    private String phone;
    private String emergencyPhone;
    private String avatar;
    private TypeUserEnum type;
    private DepartmentEnum department;
    private String workingDay;
    private String contract;
    private String basicSalary;
    private String allowance;
    private String insurance;
    private String atm;
    private String email; // user_id
    private String password;
    private RoleEnum role;
    private StatusUserEnum status;
    private PositionEnum position;
    private String resume;
    private boolean isFirstUpdateProfile;
    private String timesheetsCode;

    // Override the getAuthorities method to provide user roles as granted authorities.
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        // Create a granted authority based on the user's role.
        authorities.add(new SimpleGrantedAuthority("ROLE_" + role));
        return authorities;
    }

    @Override
    public String getUsername() {
        return email;
    }

    // Override isAccountNonExpired method to indicate that the user account never expires.
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // Override isAccountNonLocked method to indicate that the user account is never locked.
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // Override isCredentialsNonExpired method to indicate that user credentials never expire.
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // Override isEnabled method to indicate that the user is always enabled.
    @Override
    public boolean isEnabled() {
        return true;
    }
}