package com.javaweb.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.javaweb.dto.*;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.*;
import com.javaweb.service.impl.CartItemServiceImpl;

@Controller
@RequestMapping("/user/cart")
public class CartController {
	@Autowired
	ICartService	cartService;
	@Autowired
	ICartItemService	cartItemService;
	@Autowired
	IProductService	productService;
	@Autowired
	IUserService	userService;
	
	@GetMapping("")
    public ModelAndView load(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		  String username = authentication.getName();  
		  UserEntity user = userService.findByUserNameEntity(username);
		  
    	List<CartProductDTO> cartProducts = cartService.findCartItemsByUser(user.getId());
    	
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
	
	 @PostMapping("/updateQuantity")
	    public ResponseEntity<String> updateQuantity(@RequestBody CartUpdateRequestDTO request) {
	        try {
	            cartService.updateQuantity(Long.parseLong(request.getCartItemId().toString()), Long.parseLong(request.getQuantity().toString()));
	            return ResponseEntity.ok("Quantity updated successfully");
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update quantity");
	        }
	    }
	 @PostMapping("/removeCartItem")
	    public ResponseEntity<String> removeCartItem(@RequestBody Map<String, Long> request) {
		 //cartItemId
	        try {
	            cartItemService.deleteById(request.get("cartItemId"));
	            return ResponseEntity.ok("Remove this item successfully");
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to remove this item");
	        }
	    }
}
