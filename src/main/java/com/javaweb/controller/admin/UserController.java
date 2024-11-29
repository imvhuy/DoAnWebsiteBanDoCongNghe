package com.javaweb.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.javaweb.dto.UserDTO;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.UserServiceImpl;


@RestController
@RequestMapping(value = "/admin/users")
public class UserController {

<<<<<<< HEAD
    @Autowired
    IUserService userService = new UserServiceImpl();

    @PostMapping("/add")
    public ResponseEntity<?> add(UserDTO user) {
        UserDTO userModel = new UserDTO();
        userModel = userService.insert(user);
        return ResponseEntity.ok(userModel);
    }
=======
>>>>>>> f963f1395014420e7925704a1c241444eeaffc18
}
