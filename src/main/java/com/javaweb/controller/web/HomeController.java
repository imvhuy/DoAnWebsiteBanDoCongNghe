package com.javaweb.controller.web;

import com.javaweb.dto.ResponseDTO;
import com.javaweb.dto.UserDTO;
import com.javaweb.service.IUserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {
    @Autowired
    IUserService userService;

    @GetMapping(value = "home")
    public ModelAndView home() {
        ModelAndView mav = new ModelAndView("web/home");
        return mav;
    }

    @GetMapping(value="/product")
    public ModelAndView buidingList(){
        ModelAndView mav = new ModelAndView("/web/product");
        return mav;
    }

    @GetMapping(value="/news")
    public ModelAndView news(){
        ModelAndView mav = new ModelAndView("/web/news");
        return mav;
    }

    @GetMapping(value="/contact")
    public ModelAndView contact(){
        ModelAndView mav = new ModelAndView("/web/contact");
        return mav;
    }

    @GetMapping(value = "/login")
    public ModelAndView loginPage() {
        ModelAndView mav = new ModelAndView("/web/login");
        return mav;
    }

    @GetMapping(value = "/access-denied")
    public ModelAndView accessDenied() {
        return new ModelAndView("redirect:/home?accessDenied");
    }

    @GetMapping(value = "/logout")
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return new ModelAndView("redirect:/home");
    }

}


