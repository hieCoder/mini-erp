package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.response.UserResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/users")
public class UserApi {

    @Autowired
    UserService userService;

    //   API get all User
    @GetMapping
    ResponseEntity<?> getAllUser(
            @RequestParam(name = "sort", required = false, defaultValue = "asc") String sort,
            @RequestParam(name = "search", required = false, defaultValue = "") String search,
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {

        List<UserResponse> listUser = userService.getAllUser(search, sort, (page - 1) * pageSize, pageSize);


        return new ResponseEntity<>(listUser, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    ResponseEntity<?> getUserById(@PathVariable(name = "id") String id) {

        UserResponse user = userService.getUserById(id);

        return new ResponseEntity<>(user, HttpStatus.OK);
    }


}
