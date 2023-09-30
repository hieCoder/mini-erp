package com.shsoftvina.erpshsoftvina.api;


import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.UserDetailResponse;

import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;

import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/v1/users")
public class UserApi {
    @Autowired
    UserService userService;

    @PostMapping("/update")
    public ResponseEntity<?> updateInfo(UserUpdateRequest user) {
        return ResponseEntity.ok(userService.updateUser(user));
    }
    //   API get all User
    @GetMapping
    ResponseEntity<?> getAllUser(
            @RequestParam(name = "sort", required = false, defaultValue = "asc") String sort,
            @RequestParam(name = "search", required = false, defaultValue = "") String search,
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize) {

        List<UserDetailResponse> listUser = userService.getAllUser(search, sort, (page - 1) * pageSize, pageSize);


        return new ResponseEntity<>(listUser, HttpStatus.OK);
    }


    @GetMapping("/{id}")
    public ResponseEntity<?> findUserDetail(@PathVariable("id") String id) {
        UserDetailResponse userDetailResponse = userService.findUserDetail(id);
        return new ResponseEntity<>(userDetailResponse, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> disableUser(@PathVariable("id") String id) {
        userService.disableUser(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/register/approval")
    public ResponseEntity<Boolean> activeUserRegisterRequest(@Valid @RequestBody UserActiveRequest user) {
        return ResponseEntity.ok(userService.activeUserRegisterRequest(user));
    }

    @PostMapping("/create")
    public ResponseEntity<?> createUser (UserCreateRequest user){
        return ResponseEntity.ok(userService.createUser(user));
    }
}
