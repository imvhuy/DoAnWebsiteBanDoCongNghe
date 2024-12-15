package com.javaweb.controller.user;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.javaweb.dto.*;
import com.javaweb.entity.*;
import com.javaweb.service.*;

@Controller
@RequestMapping("/user/cart/checkout")
public class CheckoutController {
	 @Autowired
	    private IGeocodingService geocodingService;
	    @Autowired
	    IUserService userService;
		@Autowired
		IProductService	productService;
		@Autowired
		ICartService	cartService;
		@Autowired
		IAddressService	addressService;
		@Autowired
		IOrderService	orderService;
		@Autowired
		IPromotionService	promotionService;
		@Autowired
		ICarrierService	carrierService;
		//mới làm checkout cho trường hợp cart thôi
	 @GetMapping("")
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
	         //Lấy danh sách địa chỉ của user
	        List<AddressEntity> addresses = addressService.getAddressesByUserId(userId);
	        //lấy danh sách tất cả voucher cho user
	        List<VoucherEntity> vouchers = promotionService.findByQuantityGreaterThan(0);
	        //Lấy danh sách carriers
	        List<CarrierEntity> carrieres = carrierService.findAll();
	        //
	        ModelAndView mav = new ModelAndView("/user/checkout");
	        mav.addObject("cartProducts", cartProducts);
	        mav.addObject("addresses", addresses);
	        mav.addObject("vouchers", vouchers);
	        mav.addObject("carrieres", carrieres);
	        return mav;
	    }
	 //đặt hàng khi user đang ở trong cart
	 @PostMapping("/placeOrder")
	 public void placeOrder(@RequestParam Long address,@RequestParam("carrier-select") Long carrierId,
			 @RequestParam("payment") String paymentMethod,@RequestParam("coupon-select") Long voucherId) {
		 System.out.println("carrierId : " + carrierId);
		 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		  String username = authentication.getName();  
		  UserEntity user = userService.findByUserNameEntity(username);
		  //check xem chọn phương thức thanh toán nào
		  if ("cash".equals(paymentMethod)) {
			  //Boolean bo = orderService.createOrderForStore(user,address);
				 orderService.createOrders(user.getId(),carrierId,address,paymentMethod,voucherId);
				 //System.out.println("placeOrrder : " + bo);
		    }
		
	 }
	 
}
