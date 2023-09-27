package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.User;
import com.shsoftvina.erpshsoftvina.model.response.UserResponse;
import liquibase.pro.packaged.P;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    User findByEmailAndStatus(@Param("email") String email, @Param("status") String status);

//  Declare using sql query to get information about all users
    List<User> getAllUser(@Param("searchTerm") String id,
                          @Param("sortDirection") String sortDirection,
                          @Param("start") int start,
                          @Param("pageSize") int pageSize);
    User getUserById(String id); // Get User By ID
}