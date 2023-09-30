package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    User findByEmailAndStatus(@Param("email") String email, @Param("status") String status);
    User findUserCheckRegister(@Param("email") String email);
    int registerUser(User user);
    int updateUser(User user);
    int createUser(User user);
//  Declare using sql query to get information about all users
    List<User> getAllUser(@Param("searchTerm") String id,
                          @Param("sortDirection") String sortDirection,
                          @Param("start") int start,
                          @Param("pageSize") int pageSize);

    User findUserDetail(@Param("id") String id);

    void changeStatusUser(@Param("id") String id,@Param("status") String status);

    void activeUserRegisterRequest(User user);

    void deleteUser(String id);
}