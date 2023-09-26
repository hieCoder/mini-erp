package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.UserCreateRequestDTO;
import com.shsoftvina.erpshsoftvina.model.response.UserDetailResponseDTO;
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
        UserDetailResponseDTO userDetailResponse = userService.findUserDetail(id);
        return new ResponseEntity<>(userDetailResponse, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> disableUser(@PathVariable("id") String id) {
        userService.disableUser(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/approval")
    public ResponseEntity<?> approveUserRegisterRequest(@RequestBody() UserCreateRequestDTO user) {
        userService.approveUserRegisterRequest(user);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
