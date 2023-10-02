package com.shsoftvina.erpshsoftvina.api;


import com.shsoftvina.erpshsoftvina.model.request.user.UserActiveRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateProfileRequest;
import com.shsoftvina.erpshsoftvina.model.request.user.UserUpdateRequest;
import com.shsoftvina.erpshsoftvina.model.response.users.ShowUserRespone;
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

    @GetMapping
    public ResponseEntity<?> getAllUser(
            @RequestParam(name = "sort", required = false, defaultValue = "asc") String sort,
            @RequestParam(name = "search", required = false, defaultValue = "") String search,
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "pageSize", required = false, defaultValue = "10") int pageSize,
            @RequestParam(name = "status", required = false, defaultValue = "ACTIVE") String status) {

        List<ShowUserRespone> listUser = userService.getAllUser(search,
                sort, (page - 1) * pageSize, pageSize, status);

        return new ResponseEntity<>(listUser, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findUserDetail(@PathVariable("id") String id) {
        return new ResponseEntity<>(userService.findUserDetail(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable("id") String id) {
        userService.deleteUser(id);
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

    @PostMapping("/update/profile")
    public ResponseEntity<?> updateUserBasicProfile (@Valid UserUpdateProfileRequest user){
        return ResponseEntity.ok(userService.updateUserBasicProfile(user));
    }
}