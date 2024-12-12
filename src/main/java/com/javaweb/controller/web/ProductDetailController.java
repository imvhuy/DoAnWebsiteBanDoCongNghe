package com.javaweb.controller.web;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.dto.ReviewDTO;
import com.javaweb.entity.*;
import com.javaweb.repository.IReviewRepository;
import com.javaweb.repository.IStoreProductRepository;
import com.javaweb.service.IProductService;
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
    IUserService userService;
    @GetMapping("/{id}")
    public ModelAndView load(@PathVariable("id") Long id){
    	Optional<ProductEntity> opt = productService.findById(id);
        if (opt.isPresent()) {
            ProductEntity entity = opt.get();
            ProductDetailDTO productDetailDTO = new ProductDetailDTO();
            BeanUtils.copyProperties(entity, productDetailDTO);

            // Lấy tổng quantity từ bảng storeproduct
            Long totalQuantity = storeProductService.getTotalQuantityByProductId(id);
            productDetailDTO.setTotalQuantity(totalQuantity != null ? totalQuantity : 0L);

            // Set category info
            if (entity.getCategoryEntity() != null) {
                productDetailDTO.setCategoryId(entity.getCategoryEntity().getId());
                productDetailDTO.setCategoryName(entity.getCategoryEntity().getName());
            }

            // Lấy danh sách ảnh từ gallery theo product_id
            List<GalleryEntity> galleryList = productService.getGalleryByProductId(id);
            
            // Map ảnh theo type
            for (GalleryEntity gallery : galleryList) {
                String type = gallery.getType();
                String imageUrl = gallery.getImage(); // URL ảnh từ database
                
                // Set URL ảnh vào các trường tương ứng của productDetailDTO
                switch (type.toLowerCase()) {
                    case "right":
                        productDetailDTO.setRightImage(imageUrl);
                        break;
                    case "left":
                        productDetailDTO.setLeftImage(imageUrl);
                        break;
                    case "behind":
                        productDetailDTO.setBehindImage(imageUrl);
                        break;
                    case "front":
                        productDetailDTO.setFrontImage(imageUrl);
                        break;
                }
            }
            //xu ly product configuration
            List<Map<String, String>> configList = convertToList(productDetailDTO.getConfiguration());
            //lay tat ca reviews cua product
            List<ReviewDTO> reviews = reviewService.findReviewsByProductId(id);
            // lấy tổng số luongj reviews
            long totalReviews = reviewService.countTotalReviews();	
         // Lấy giá trị trung bình của rating
            Double averageRating = reviewService.calculateAverageRating(id);
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
            ModelAndView mav = new ModelAndView("/web/product-detail");
            mav.addObject("configList", configList);
            mav.addObject("product", productDetailDTO); 
            mav.addObject("reviews", reviews);
            mav.addObject("totalReviews", totalReviews);
            mav.addObject("averageRating", averageRating);
            mav.addObject("ratingMap", sortedList);
            
            return mav;
        }
        ModelAndView mav = new ModelAndView("/web/product-detail");
        return mav;
    }
    
    // ham tach xu ly chuoi cho thong tin cau hinh product configuration
    private List<Map<String, String>> convertToList(String configText) {
        List<Map<String, String>> configList = new ArrayList<>();
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
        return configList;
    }
    
    @PostMapping("/submit-reply")
    public String submitReply(@RequestParam("replyContent") String replyContent,
                              @RequestParam("parentId") Long parentId,@RequestParam("productId") Long productId) {
    	System.out.println("currentUser 11111111111111111111111111111: ");
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();  
    	//lay userId
        System.out.println("username1111111111111111 :" + username);
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
        System.out.println("currentUser 22222222222222222222222: ");
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
}
