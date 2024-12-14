package com.javaweb.controller.web;

import com.javaweb.dto.*;
import com.javaweb.dto.ResponseDTO;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.FavoriteProductEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.data.domain.PageRequest;

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
    @Autowired
    IProductService productService;
    @Autowired
    ICartService cartService;
    @Autowired
    IFavoriteProductService favortieProductService;
    

    @GetMapping(value = "home")
    public ModelAndView home() {
    	
    	//lấy date hiện tại
    	LocalDate localDate = LocalDate.now();
    	Date sqlDate = Date.valueOf(localDate);
    	List<ProductDetailDTO> products = productService.findLatestProductInThisMonth(sqlDate);
    	// lay top 20 san pham ban chay
    	 Pageable pageable = PageRequest.of(0, 10);
    	List<ProductDetailDTO> topSellingProducts = productService.findTopSellingProducts(pageable);
    	//lay top 20 san pham danh gia cao
	   	List<ProductDetailDTO> topTotalRatingProducts = productService.findTopTotalRatingProducts(pageable);

    	 ModelAndView mav = new ModelAndView("web/home");
    	 
    	 mav.addObject("products", products); // Truyền đối tượng products vào view
    	 mav.addObject("topSellingProducts", topSellingProducts);
    	 mav.addObject("topTotalRatingProducts", topTotalRatingProducts);

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
    @GetMapping(value = "/register")
    public ModelAndView registerPage() {
        ModelAndView mav = new ModelAndView("/web/register");
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
    
    
 // API để thêm sản phẩm vào favortie product
    @PostMapping("/add-favorite-product")
    public ResponseEntity<?> addToWishlist(@RequestBody FavoriteProductDTO favortieProductDTO) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//
    	Long productId = favortieProductDTO.getProductId();
    	Long userId = userService.findByUserName(username).getId();
    	FavoriteProductEntity fvProduct = favortieProductService.findFavoriteProductEntityByProductIdAndUserId(productId, userId);
    	boolean success = false;
    	if(fvProduct == null)
    	{
    		success = favortieProductService.addFavoriteProduct(productId,userId);
    	}
        
        // Tạo một Map để trả về phản hồi
        Map<String, Object> response = new HashMap<>();
        if (success) {
            response.put("message", "Product added to wishlist");
            response.put("success", true);
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "Failed to add to wishlist");
            response.put("success", false);
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @PostMapping("/remove-favorite-product")
    public ResponseEntity<?> removeFromWishlist(@RequestBody FavoriteProductDTO favortieProductDTO) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//
    	Long productId = favortieProductDTO.getProductId();
    	Long userId = userService.findByUserName(username).getId();
    	//
        boolean success = favortieProductService.removeFavoriteProduct(productId,userId);
        // Tạo một Map để trả về phản hồi
        Map<String, Object> response = new HashMap<>();
        if (success) {
            response.put("message", "Product removed from wishlist");
            response.put("success", true);
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "Failed to remove  from wishlist");
            response.put("success", false);
            return ResponseEntity.status(500).body(response);
        }
    }

}


