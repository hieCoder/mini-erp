package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.request.user.UserRegisterRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    User findByEmailAndStatus(@Param("email") String email, @Param("status") String status);
    User findByEmail(@Param("email") String email);
    int registerUser(User user);
    int updateUser(User user);
    int createUser(User user);
    List<User> getAllUser(@Param("searchTerm") String id,
                          @Param("sortDirection") String sortDirection,
                          @Param("start") int start,
                          @Param("pageSize") int pageSize);
    User findById(@Param("id") String id);
    void changeStatusUser(@Param("id") String id,@Param("status") String status);
    void activeUserRegister(User user);
    void deleteUser(String id);

}