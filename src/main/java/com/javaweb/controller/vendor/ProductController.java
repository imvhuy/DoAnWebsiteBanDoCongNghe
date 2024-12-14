package com.javaweb.controller.vendor;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.StoreEntity;
import com.javaweb.entity.StoreProductEntity;
import com.javaweb.service.ICategoryService;
import com.javaweb.service.IProductService;
import com.javaweb.service.IStoreProductService;
import com.javaweb.service.IStoreService;
import jakarta.mail.Store;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller("ProductOfVendor")
@RequestMapping("/vendor")
public class ProductController {
    @Autowired
    private IStoreProductService storeProductService;
    @Autowired
    private IStoreService storeService;
    @Autowired
    private IProductService productService;
    @Autowired
    private ICategoryService categoryService;


    // Hiển thị danh sách sản phẩm của cửa hàng
    @GetMapping("/manage-product")
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(value = "productName", required = false) String productName,
                       @RequestParam(value = "categoryId", required = false) String categoryId,
                       ModelMap model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Đảm bảo page bắt đầu từ 1
        page = Math.max(page, 1); // Đảm bảo page không nhỏ hơn 1
        if (authentication.getPrincipal().equals("anonymousUser")) { return "redirect:/login"; }
        UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
        String owner = userDetails.getUsername();
        StoreEntity currentStore = storeService.findByOwner(owner);
        Pageable pageable = PageRequest.of(page - 1, 5); // PageRequest bắt đầu từ 0
        Page<StoreProductEntity> storePage;

        // Lọc sản phẩm theo tên và danh mục
        if (productName != null && !productName.trim().isEmpty() && categoryId != null && !categoryId.trim().isEmpty()) {
            // Tìm kiếm theo tên sản phẩm và danh mục
            storePage = storeProductService.findByStoreIdAndProductNameAndCategoryId(
                    currentStore.getId(), productName, Long.parseLong(categoryId), pageable);
        } else if (productName != null && !productName.trim().isEmpty()) {
            // Tìm kiếm chỉ theo tên sản phẩm
            storePage = storeProductService.findByStoreIdAndProductName(currentStore.getId(), productName, pageable);
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            storePage = storeProductService.findByStoreIdAndCategoryId(currentStore.getId(), Long.parseLong(categoryId), pageable);
        } else {
            // Nếu không có bộ lọc, lấy tất cả sản phẩm của cửa hàng
            storePage = storeProductService.findByStoreId(currentStore.getId(), pageable);
        }
        List<CategoryEntity> categories = categoryService.findAll();
        List<ProductEntity> productEntity = productService.findAll();
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("categories", categories);
        model.addAttribute("products", productEntity);
        // Thêm các thông tin phân trang và dữ liệu vào model
        model.addAttribute("storePage", storePage);
        model.addAttribute("stores", storePage.getContent()); // Danh sách cửa hàng
        model.addAttribute("totalPages", storePage.getTotalPages()); // Tổng số trang
        model.addAttribute("totalElements", storePage.getTotalElements()); // Tổng số phần tử
        model.addAttribute("currentPage", page); // Trang hiện tại

        return "vendor/manage-product"; // Trả về view hiển thị danh sách cửa hàng
    }
    // Add product to store
    @PostMapping("/addStoreProduct")
    public String addStoreProduct(@RequestParam("productid") Long productId,
                                  @RequestParam("quantity") int quantity,
                                    RedirectAttributes model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) { return "redirect:/login"; }
        // Check if the product already exists in the store's inventory
        UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
        String owner = userDetails.getUsername();
        StoreEntity store = storeService.findByOwner(owner);
        Optional<StoreProductEntity> opt = storeProductService.findByStoreIdAndProductId(store.getId(), productId);
        StoreProductEntity storeProduct = null;
        if (opt.isPresent()) {
            storeProduct = opt.get();
            // Perform your logic here
        }

        if (storeProduct != null) {
            // If exists, update the quantity
            storeProduct.setQuantity(storeProduct.getQuantity() + quantity);
            storeProductService.save(storeProduct);
        } else {
            // If doesn't exist, create a new storeproduct record
            StoreProductEntity newStoreProduct = new StoreProductEntity();
            ProductEntity productEntity = productService.getProductById(productId);
            newStoreProduct.setProduct(productEntity);
            newStoreProduct.setStore(store);
            newStoreProduct.setQuantity(quantity);
            newStoreProduct.setSold(0); // Initially, no products are sold
            storeProductService.save(newStoreProduct);
        }
        model.addFlashAttribute("message", "Thêm sản phẩm thành công");
        // Redirect to the same page or another page
        return "redirect:/vendor/manage-product";
    }
    @PostMapping("/editStoreProduct")
    public String editStoreProduct(@RequestParam("productid") Long productId,
                                   @RequestParam("quantity") int quantity,
                                   RedirectAttributes redirectAttributes) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication.getPrincipal().equals("anonymousUser")) { return "redirect:/login"; }
        // Retrieve the product from the database
        StoreProductEntity storeProduct = storeProductService.findById(productId);
        ProductEntity productEntity = productService.getProductById(productId);
        // Update the product details
        storeProduct.setProduct(productEntity);
        storeProduct.setQuantity(quantity);
        // Save the updated product
        storeProductService.save(storeProduct);
        redirectAttributes.addFlashAttribute("message", "Cập nhật sản phẩm thành công");
        return "redirect:/vendor/manage-product";
    }

    @PostMapping("/deleteProduct")
    public String deleteProduct(@RequestParam("id") Long productId,
                                RedirectAttributes redirectAttributes) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication.getPrincipal().equals("anonymousUser")) { return "redirect:/login"; }
        UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
        String owner = userDetails.getUsername();
        StoreEntity store = storeService.findByOwner(owner);
        storeProductService.removeProductFromStore(store.getId(), productId);
        redirectAttributes.addFlashAttribute("message", "Xóa sản phẩm thành công");
        // Redirect lại trang quản lý sản phẩm
        return "redirect:/vendor/manage-product";
    }
}

