package com.javaweb.controller.shipper;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/shipper")
public class ShipperController {

    @GetMapping(value = "home")
    public ModelAndView home() {
        ModelAndView mav = new ModelAndView("shipper/home");
        return mav;
    }
}
