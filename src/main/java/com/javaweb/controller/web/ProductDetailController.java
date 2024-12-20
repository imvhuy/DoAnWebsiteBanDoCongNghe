package com.javaweb.controller.web;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.javaweb.dto.*;
import com.javaweb.entity.*;
import com.javaweb.service.*;

@Controller
@RequestMapping("/product-detail")
public class ProductDetailController {
    @Autowired
    IProductService productService;
    
    @Autowired
    private IStoreProductService storeProductService;
    
    @Autowired
    private IReviewService reviewService;
    @Autowired
    IFavoriteProductService favortieProductService;
    @Autowired
    IUserService userService;
    @Autowired
    ICartService cartService;
    @GetMapping("/{id}")
    public ModelAndView load(@PathVariable("id") Long id){
    	Optional<ProductEntity> opt = productService.findById(id);
        if (opt.isPresent()) {
            ProductEntity entity = opt.get();
            ProductDTO productDTO = new ProductDTO();
            BeanUtils.copyProperties(entity, productDTO);

            // Lấy tổng quantity từ bảng storeproduct
            Long totalQuantity = storeProductService.getTotalQuantityByProductId(id);
            productDTO.setTotalQuantity(totalQuantity != null ? totalQuantity : 0L);

            // Set category info
            if (entity.getCategoryEntity() != null) {
            	productDTO.setCategoryId(entity.getCategoryEntity().getId());
            	productDTO.setCategoryName(entity.getCategoryEntity().getName());
            }
         // Lấy danh sách ảnh từ gallery theo product_id
            List<GalleryEntity> galleryList = productService.getGalleryByProductId(id);
            
            // Chuyển đổi danh sách GalleryEntity thành GalleryDTO
            List<GalleryDTO> galleryDTOList = galleryList.stream()
                    .map(gallery -> new GalleryDTO(gallery.getImage(),gallery.getType() ))
                    .collect(Collectors.toList());

            // Set danh sách ảnh vào productDTO
            productDTO.setGalleries(galleryDTOList);
            //xu ly product configuration
            List<Map<String, String>> configList = convertToList(productDTO.getConfiguration());
            //lay tat ca reviews cua product
            List<ReviewDTO> reviews = reviewService.findReviewsByProductId(id);
            // lấy tổng số luongj reviews
            long totalReviews = reviewService.countTotalReviews();	
            //lấy tổng số lượng sản phẩm
            Long total = storeProductService.getTotalQuantityByProductId(id);
            //lấy số lượng sản phẩm hiện có
            Long totalAvailableQuantity = productService.countTotalAvailableQuantityOfProduct(id);
         // Lấy giá trị trung bình của rating
            Double averageRating = reviewService.calculateAverageRating(id);
            if (averageRating == null) {
                averageRating = 0.0; // Gán giá trị mặc định là 0
            }

            averageRating = Math.round(averageRating * 10.0) / 10.0;
         // Lấy số lượng review theo rating từ 1 đến 5
            List<Object[]> ratingCounts = reviewService.countReviewsByRating(id);
            Map<Integer, Long> ratingMap = new HashMap<>();

            // Tạo một map mặc định với giá trị 0 cho tất cả các rating từ 1 đến 5
            for (int i = 1; i <= 5; i++) {
                ratingMap.put(i, 0L);
            }

            // Cập nhật map với dữ liệu từ DB
            for (Object[] result : ratingCounts) {
                int rating = (Integer) result[0];
                long count = (Long) result[1];
                ratingMap.put(rating, count);
            }
         // Sắp xếp ratingMap theo thứ tự giảm dần
            List<Map.Entry<Integer, Long>> sortedList = new ArrayList<>(ratingMap.entrySet());
            sortedList.sort((entry1, entry2) -> entry2.getKey().compareTo(entry1.getKey())); // Sắp xếp giảm dần
            //Lấy danh sách các sản phẩm liên quan với product này
            List<ProductDetailDTO> relatedProducts = productService.findRelatedProductsByProduct(id);
            
            ModelAndView mav = new ModelAndView("/web/product-detail");
            mav.addObject("configList", configList);
            mav.addObject("product", productDTO); 
            mav.addObject("reviews", reviews);
            mav.addObject("total", total);
            mav.addObject("totalAvailableQuantity", totalAvailableQuantity);
            mav.addObject("totalReviews", totalReviews);
            mav.addObject("averageRating", averageRating);
            mav.addObject("ratingMap", sortedList);
            mav.addObject("relatedProducts", relatedProducts);
            
            return mav;
        }
        ModelAndView mav = new ModelAndView("/web/product-detail");
        return mav;
    }
    
    // ham tach xu ly chuoi cho thong tin cau hinh product configuration
    private List<Map<String, String>> convertToList(String configText) {
        List<Map<String, String>> configList = new ArrayList<>();
        if(configText != null)
        {
        	String[] rows = configText.split("\n");  // Tách chuỗi thành các dòng

            for (String row : rows) {
                // Tìm dấu ":" đầu tiên để tách phần key và phần value
                int colonIndex = row.indexOf(':');
                if (colonIndex != -1) {
                    String key = row.substring(0, colonIndex).trim();  // Lấy phần key
                    String value = row.substring(colonIndex + 1).trim();  // Lấy phần value (sau dấu ":")
                    
                    // Tạo Map cho mỗi dòng
                    Map<String, String> config = new HashMap<>();
                    config.put("key", key);
                    config.put("value", value);
                    configList.add(config);
                }
            }
        }
        
        return configList;
    }
    
    @PostMapping("/submit-reply")
    public String submitReply(@RequestParam("replyContent") String replyContent,
                              @RequestParam("parentId") Long parentId,@RequestParam("productId") Long productId) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//lay userId
    	UserEntity  currentUser = userService.findByUserNameEntity(username);
    	ReviewEntity reviewParent = reviewService.findReviewEntityById(parentId);
    	ProductEntity product = productService.getProductById(productId);
        //System.out.println("currentUser : " + currentUser);
        // Tạo đối tượng Review để lưu câu trả lời
        ReviewEntity reply = new ReviewEntity();
        reply.setContent(replyContent);
        reply.setParentReview(reviewParent);
        reply.setUser(currentUser);
        reply.setProduct(product);
        reply.setCreatedDate(Date.valueOf(LocalDate.now()));
        // Lưu câu trả lời vào cơ sở dữ liệu
        reviewService.saveReviewEntity(reply);

        // Sau khi lưu xong, chuyển hướng về trang review chính (hoặc có thể trả lại JSON nếu dùng AJAX)
        return "redirect:/product-detail/" +productId; // Chuyển hướng về trang reviews hoặc trang có liên quan
    }
    @PostMapping("/submit-review")
    public String submitReview(@RequestParam("reviewContent") String reviewContent,
                              @RequestParam("productId") Long productId, @RequestParam("rate") int rating) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//lay userId
    	UserEntity  currentUser = userService.findByUserNameEntity(username);
    	ProductEntity product = productService.getProductById(productId);

        // Tạo ối tượng Review để lưu câu trả lời
        ReviewEntity reply = new ReviewEntity();
        reply.setContent(reviewContent);
        reply.setParentReview(null);
        reply.setUser(currentUser);
        reply.setProduct(product);
        reply.setCreatedDate(Date.valueOf(LocalDate.now()));
        reply.setRating(rating);
        // Lưu câu trả lời vào cơ sở dữ liệu
        reviewService.saveReviewEntity(reply);

        // Sau khi lưu xong, chuyển hướng về trang review chính (hoặc có thể trả lại JSON nếu dùng AJAX)
        return "redirect:/product-detail/" +productId; // Chuyển hướng về trang reviews hoặc trang có liên quan
    }
    
    @PostMapping("/add-to-cart")
    public ResponseEntity<String> addToCart(@RequestBody Map<String, Long> request) {
    	
        Long productId = request.get("productId");
        Long quantity = request.get("quantity");
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
        System.out.println("username : "+ username );
    	// Nếu không có authentication (người dùng chưa đăng nhập)
    	System.out.println("authentication 555555555: " + authentication);
    	if (username == "anonymousUser") {
    		System.out.println("anonymousUser : "+ username );
            return ResponseEntity.status(401).body("You must be logged in to add to cart");
        }
    	//lay user
    	UserEntity  currentUser = userService.findByUserNameEntity(username);
        try {
            cartService.addToCart(productId,quantity,currentUser);
            return ResponseEntity.ok("Product added to cart successfully");
        } catch (Exception e) {
            return ResponseEntity.status(401).body("Failed to add product to cart");
        }
    }
    // API để thêm sản phẩm vào favortie product
    @PostMapping("/add-favorite-product")
    public ResponseEntity<?> addToWishlist(@RequestBody FavoriteProductDTO favortieProductDTO) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//
    	Long productId = favortieProductDTO.getProductId();
    	System.out.println("favortieProductDTO : " +favortieProductDTO);
    	System.out.println("favortieProductDTO1111 : " +favortieProductDTO.getProductId() );
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
