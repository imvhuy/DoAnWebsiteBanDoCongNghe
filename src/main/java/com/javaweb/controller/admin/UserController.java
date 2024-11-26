package com.javaweb.controller.admin;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.UserModel;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.UserServiceImpl;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping(value = "/admin/users")
public class UserController {

    @Autowired
    IUserService userService = new UserServiceImpl();

    @PostMapping("/add")
    public ResponseEntity<?> add(UserModel user) {
        UserModel userModel = new UserModel();
        userModel = userService.insert(user);
        return ResponseEntity.ok(userModel);
    }
}
