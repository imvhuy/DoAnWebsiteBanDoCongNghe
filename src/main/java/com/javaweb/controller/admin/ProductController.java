package com.javaweb.controller.admin;



import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;

import com.javaweb.model.ProductModel;
import com.javaweb.repository.StoreProductRepository;
import com.javaweb.service.IProductService;
import com.javaweb.service.impl.CategoryServiceImpl;
import com.javaweb.service.impl.GalleryServiceImpl;
import com.javaweb.service.impl.ProductServiceImpl;
import jakarta.validation.Path;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping(value ="/admin/products")
public class ProductController {
    @Autowired
    private IProductService productService;
    @Autowired
    private GalleryServiceImpl galleryServiceImpl;
    @Autowired
    private CategoryServiceImpl categoryServiceImpl;
    @Autowired
    private StoreProductRepository storeProductRepository;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping
    public ModelAndView list(ModelMap model, @RequestParam(value = "message", required = false) String message) {
        //gọi hàm findAll() trong service
        List<ProductEntity> list = productService.findAll();
        if (!StringUtils.isEmpty(message)) {
            model.addAttribute("message", message);
        }
        // chuyển dữ liệu từ list lên biến categories
        model.addAttribute("products", list);
        return new ModelAndView("/admin/products/list", model);
    }

    @GetMapping("add")
    public ModelAndView add(@ModelAttribute ModelMap model) {
        ProductModel productModel = new ProductModel();
        List<CategoryEntity> categories = categoryServiceImpl.findAll(); // Giả sử bạn có CategoryService
        model.addAttribute("categories", categories); // Truyền danh sách vào model
        model.addAttribute("product", productModel);
        return new ModelAndView("admin/products/addOrEdit", model);
    }
    @GetMapping("edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") Long id) {
        Optional<ProductEntity> opt = productService.findById(id);
        if (opt.isPresent()) {
            ProductEntity entity = opt.get();
            ProductModel productModel = new ProductModel();
            BeanUtils.copyProperties(entity, productModel);

            // Lấy tổng quantity từ bảng storeproduct
            Long totalQuantity = storeProductRepository.getTotalQuantityByProductId(id);
            productModel.setTotalQuantity(totalQuantity != null ? totalQuantity : 0L);

            // Set category info
            if (entity.getCategoryEntity() != null) {
                productModel.setCategoryId(entity.getCategoryEntity().getId());
                productModel.setCategoryName(entity.getCategoryEntity().getName());
            }

            // Lấy danh sách ảnh từ gallery theo product_id
            List<GalleryEntity> galleryList = productService.getGalleryByProductId(id);
            
            // Map ảnh theo type
            for (GalleryEntity gallery : galleryList) {
                String type = gallery.getType();
                String imageUrl = gallery.getImage(); // URL ảnh từ database
                
                // Set URL ảnh vào các trường tương ứng của ProductModel
                switch (type.toLowerCase()) {
                    case "right":
                        productModel.setRightImage(imageUrl);
                        break;
                    case "left":
                        productModel.setLeftImage(imageUrl);
                        break;
                    case "behind":
                        productModel.setBehindImage(imageUrl);
                        break;
                    case "front":
                        productModel.setFrontImage(imageUrl);
                        break;
                }
            }

            model.addAttribute("product", productModel);
            return new ModelAndView("admin/products/addOrEdit", model);
        }
        model.addAttribute("message", "Product not found");
        return new ModelAndView("redirect:/admin/products", model);
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(RedirectAttributes redirectAttributes,
                               @Valid @ModelAttribute("product") ProductModel productModel,
                               BindingResult result) {
        if (result.hasErrors()) {
            return new ModelAndView("admin/products/addOrEdit");
        }

        try {
            ProductEntity entity = new ProductEntity();
            // Copy dữ liệu từ model sang entity
            BeanUtils.copyProperties(productModel, entity);

            // Set category nếu có
            if (productModel.getCategoryId() != null) {
                CategoryEntity category = categoryServiceImpl.findById(productModel.getCategoryId())
                    .orElseThrow(() -> new RuntimeException("Category not found"));
                entity.setCategoryEntity(category);
            }

            // Lưu entity
            entity = productService.save(entity);

            // Thêm thông báo thành công
            String successMessage = productModel.getId() == null ?
                "Product added successfully!" : "Product updated successfully!";
            redirectAttributes.addFlashAttribute("message", successMessage);

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error processing product: " + e.getMessage());
        }

        return new ModelAndView("redirect:/admin/products");
    }

    // Phương thức hỗ trợ update gallery image
    private void updateGalleryImage(ProductEntity product, String type, MultipartFile image) throws IOException {
        Optional<GalleryEntity> existingGallery = galleryServiceImpl.findByProductAndType(product.getId(), type);
        if (existingGallery.isPresent()) {
            GalleryEntity gallery = existingGallery.get();
            gallery.setImage(saveImage(image));
            galleryServiceImpl.save(gallery);
        } else {
            createGalleryImage(product, type, image);
        }
    }

    // Phương thức hỗ trợ tạo mới gallery image
    private void createGalleryImage(ProductEntity product, String type, MultipartFile image) throws IOException {
        GalleryEntity gallery = new GalleryEntity();
        gallery.setProductEntity(product);
        gallery.setType(type);
        gallery.setImage(saveImage(image));
        galleryServiceImpl.save(gallery);
    }

    // Phương thức hỗ trợ lưu file
    private String saveImage(MultipartFile file) throws IOException {
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        File dest = new File(uploadPath + fileName);
        file.transferTo(dest);
        return fileName;
    }

    @GetMapping(path = "/delete/{id}")
    public ModelAndView delete(RedirectAttributes model, @PathVariable("id") Long id) {
        Optional<ProductEntity> optCategory = productService.findById(id);
        if (optCategory.isEmpty()) {
            model.addFlashAttribute("message", "products is not exits!!!!");
            return new ModelAndView("redirect:/admin/products");
        }
        productService.deleteById(id);
        model.addFlashAttribute("message", "products  is deleted!!!!");
        return new ModelAndView("redirect:/admin/products");
    }

    @GetMapping("search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name) {
        List<ProductEntity> list = null;
        // có nội dung truyền về không, name là tùy chọn khi required=false
        if (StringUtils.hasText(name)) {
            list = productService.findByNameContaining(name);
        } else {
            list = productService.findAll();
        }
        model.addAttribute("products", list);
        return "admin/products/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {
        int count = (int) productService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<ProductEntity> resultPage = null;
        if (StringUtils.hasText(name)) {
            resultPage = productService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        }
        else{
            resultPage = productService.findAll(pageable);
        }
        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            if (totalPages > count) {
                if (end == totalPages) start = end - count;
                else if (start == 1) end = start + count;
            }
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }   model.addAttribute("productPage", resultPage);
        return "admin/products/list";
    }


    // Hàm lưu file vào thư mục
    private static final String UPLOAD_DIR = "C:/upload/";
    @PostMapping("/uploadImages/{productId}")
    public String uploadImages(@PathVariable Long productId, @RequestParam("images") List<MultipartFile> images) {
        ProductEntity product = productService.getProductById(productId);

        try {
            for (MultipartFile image : images) {
                String fileName = image.getOriginalFilename();
                File file = new File(UPLOAD_DIR + fileName);
                image.transferTo(file);

                // Thêm ảnh vào Gallery
                GalleryEntity galleryEntity = new GalleryEntity();
                galleryEntity.setProductEntity(product);
                galleryEntity.setImage(fileName);
                galleryEntity.setType("image/jpeg"); // Hoặc kiểu MIME thích hợp
                galleryServiceImpl.addGalleryImage(galleryEntity);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "Error uploading images: " + e.getMessage();
        }

        return "Images uploaded successfully!";
    }


}