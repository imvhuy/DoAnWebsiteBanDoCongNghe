package com.javaweb.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vendor")
public class DiscountController {

    @GetMapping("/manage-discount")
    public String index() {
        return "vendor/manage-discount";
    }
}
