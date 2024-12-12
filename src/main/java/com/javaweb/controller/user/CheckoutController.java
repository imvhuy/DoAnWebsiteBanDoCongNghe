package com.javaweb.controller.user;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.javaweb.dto.CartProductDTO;
import com.javaweb.dto.GalleryDTO;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.service.*;

@Controller
@RequestMapping("/user/checkout")
public class CheckoutController {
	 @Autowired
	    private IGeocodingService geocodingService;
	    @Autowired
	    IUserService userService;
		@Autowired
		IProductService	productService;
		@Autowired
		ICartService	cartService;
	 @GetMapping("/{userId}")
	 public ModelAndView load() {
	    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	        String username = authentication.getName();  
	    	//lay userId
	    	Long userId = userService.findByUserName(username).getId();
	    	System.out.println("userID : " + userId);
	    	List<CartProductDTO> cartProducts = cartService.findCartItemsByUser(userId);
	    	
	    	// Lặp qua từng sản phẩm trong giỏ hàng để tính số lượng hiện có
	        for (CartProductDTO result : cartProducts) {
	            Long productId = result.getId(); // Lấy ID sản phẩm
	            //System.out.println("Product ID: " + productId);
	            
	            // Tính tổng số lượng có sẵn của sản phẩm
	            Long total = productService.countTotalAvailableQuantityOfProduct(productId);
	            
	            // Lưu số lượng có sẵn vào CartProductDTO
	            result.setAvailableQuantity(total);  // Giả sử CartProductDTO có setAvailableQuantity
	            
	         // Lấy danh sách ảnh từ gallery theo product_id
	            List<GalleryEntity> galleryList = productService.getGalleryByProductId(result.getId());
	            for (GalleryEntity gallery : galleryList) {
	            	if(gallery.getType() == "front") {
	            		result.setImage(gallery.getImage());
	            	}
	            }
	            
	        }
	         
	        ModelAndView mav = new ModelAndView("/user/checkout");
	        mav.addObject("cartProducts", cartProducts);
	        return mav;
	    }
}
