package com.javaweb.controller.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.javaweb.service.IProductService;

@Controller
@RequestMapping("/product-detail")
public class ProductDetailController {
    @Autowired
    IProductService productService;
    @GetMapping()
    public ModelAndView buidingList(){
        ModelAndView mav = new ModelAndView("/web/product-detail");
        return mav;
    }
}
