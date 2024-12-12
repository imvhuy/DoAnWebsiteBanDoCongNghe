package com.javaweb.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.javaweb.dto.*;
import com.javaweb.service.ICartService;
import com.javaweb.service.IProductService;

@Controller
@RequestMapping("/user/cart")
public class CartController {
	@Autowired
	ICartService	cartService;
	@Autowired
	IProductService	productService;
	@GetMapping("/{userId}")
    public ModelAndView load(@PathVariable("userId") Long id){
    	List<CartProductDTO> cartProducts = cartService.findCartItemsByUser(id);
    	
    	// Lặp qua từng sản phẩm trong giỏ hàng để tính số lượng hiện có
        for (CartProductDTO result : cartProducts) {
            Long productId = result.getId(); // Lấy ID sản phẩm
            //System.out.println("Product ID: " + productId);
            
            // Tính tổng số lượng có sẵn của sản phẩm
            Long total = productService.countTotalAvailableQuantityOfProduct(productId);
            
            // Lưu số lượng có sẵn vào CartProductDTO
            result.setAvailableQuantity(total);  // Giả sử CartProductDTO có setAvailableQuantity
        }
         
    	
        ModelAndView mav = new ModelAndView("/user/cart");
        mav.addObject("cartProducts", cartProducts);
        return mav;
    }
}
