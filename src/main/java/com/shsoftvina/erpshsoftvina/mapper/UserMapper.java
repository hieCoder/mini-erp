package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {

    User findByEmailAndStatus(@Param("email") String email, @Param("status") String status);

    User findUserDetail(@Param("id") String id);

    void changeStatusUser(@Param("id") String id,@Param("status") String status);

    void activeUserRegisterRequest(User user);

    void declineUserRegisterRequest(String id);
}