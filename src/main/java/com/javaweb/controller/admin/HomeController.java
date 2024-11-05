package com.javaweb.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller(value = "AdminHomeController")
@RequestMapping(value = "/admin")
public class HomeController {
    @GetMapping("/home")
    public String index() {
        return "admin/home";
    }
}
