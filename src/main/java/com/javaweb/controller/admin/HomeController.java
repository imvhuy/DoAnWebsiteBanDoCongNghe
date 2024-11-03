package com.javaweb.controller.admin;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController(value = "AdminHomeController")
@RequestMapping(value = "/admin")
public class HomeController {
    @GetMapping("/home")
    public String index() {
        return "admin/home";
    }
}
