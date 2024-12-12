package com.javaweb.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.service.IFavoriteProductService;
import com.javaweb.service.IProductService;
import com.javaweb.service.IUserService;

@Controller
@RequestMapping("/favorite-products")
public class FavoriteProductController {
    @Autowired
    IUserService userService;
    @Autowired
    IProductService productService;
    
    @Autowired
    IFavoriteProductService favortieProductService;
    @GetMapping()
    public ModelAndView list() {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//lay userId
    	Long userId = userService.findByUserName(username).getId();
    	// lay danh sach favorite products
    	List<ProductDetailDTO> products = favortieProductService.findFavoriteProductsByUser(userId);
    	
        ModelAndView modelAndView = new ModelAndView("/user/favorite-products");
        modelAndView.addObject("products", products);
        return modelAndView;
    }
}
