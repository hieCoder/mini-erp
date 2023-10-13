package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface UserMapper {

    User findByEmailAndStatus(@Param("email") String email, @Param("status") String status);
    User findByEmail(@Param("email") String email);
    int registerUser(User user);
    int updateUserProfile(User user);
    int updateUserDetail(User user);
    List<User> getAllUser(@Param("searchTerm") String searchTerm,
                          @Param("sortDirection") String sortDirection,
                          @Param("status") String status,
                          RowBounds rowBounds);
    User findById(@Param("id") String id);
    int changeStatusUser(@Param("id") String id,@Param("status") String status);
    void activeUserRegister(User user);
    int deleteUser(String id);
    List<String> getAllFullname();
    long getTotalUser(@Param("status") String status, @Param("searchTerm") String searchTerm, @Param("sortDirection") String sortDirection);
}