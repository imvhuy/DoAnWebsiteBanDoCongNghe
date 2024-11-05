package com.javaweb.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping(value = "/admin/categories")
public class CategoryController {
    @GetMapping("")
    public String index() {
        return "admin/category/category-list";
    }
}