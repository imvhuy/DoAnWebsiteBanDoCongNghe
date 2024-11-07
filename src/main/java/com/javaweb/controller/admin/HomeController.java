package com.javaweb.controller.admin;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Controller(value = "AdminHomeController")
@RequestMapping(value = "/admin")
@EnableMethodSecurity
public class HomeController {

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping("/home")
    public String index() {
        return "admin/home";
    }
}
