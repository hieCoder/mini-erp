package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.response.user.UserDetailResponse;
import com.shsoftvina.erpshsoftvina.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/users")
public class UserApi {
    @Autowired
    UserService userService;

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
    public ResponseEntity<Boolean> activeUserRegisterRequest(@RequestBody UserActiveRequest user) {
        return ResponseEntity.ok(userService.activeUserRegisterRequest(user));
    }
}
