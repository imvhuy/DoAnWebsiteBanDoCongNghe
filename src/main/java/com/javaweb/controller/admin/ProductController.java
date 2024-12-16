package com.javaweb.controller.admin;


import com.javaweb.dto.GalleryDTO;
import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.SubcategoryValueEntity;
import com.javaweb.service.*;
import com.javaweb.service.impl.SubcategoryServiceImpl;
import com.javaweb.utils.FileHandler;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
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
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping(value ="/admin/products")
@EnableMethodSecurity
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class ProductController {
    @Autowired
    private IProductService productService;
    @Autowired
    private IGalleryService galleryService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IStoreProductService storeProductService;
    @Autowired
    private ISubCategoryValueService subCategoryValueService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "1") int page, // Đặt giá trị mặc định là 1 thay vì 0
                       @RequestParam(defaultValue = "10") int size,
                       @RequestParam(value = "name", required = false) String name,
                       ModelMap model) {
        // Kiểm tra tham số page và size có hợp lệ không
        if (page < 1) {
            page = 1;  // Đảm bảo trang luôn bắt đầu từ 1
        }
        if (size <= 0) {
            size = 10;  // Đặt lại kích thước nếu không hợp lệ
        }

        Pageable pageable = PageRequest.of(page - 1, size);  // Trừ 1 để sử dụng với pageable, vì pageable bắt đầu từ 0
        Page<ProductEntity> productPage;

        if (name != null && !name.isEmpty()) {
            productPage = productService.findByNameContainingIgnoreCase(name, pageable);
            model.addAttribute("name", name);
        } else {
            productPage = productService.findAll(pageable);
        }


        model.addAttribute("productPage", productPage);
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalElements", productPage.getTotalElements());
        model.addAttribute("currentPage", page);
        model.addAttribute("size", size);

        return "admin/products/list";
    }

    @GetMapping("add")
    public ModelAndView add(@ModelAttribute ModelMap model) {
        ProductDTO productDTO = new ProductDTO();
        List<CategoryEntity> categories = categoryService.findAll();
        List<GalleryDTO> galleryDTOList = new ArrayList<>();
        productDTO.setGalleries(galleryDTOList);
        model.addAttribute("categories", categories); // Truyền danh sách vào model
        model.addAttribute("product", productDTO);
        return new ModelAndView("admin/products/addOrEdit", model);
    }
    @GetMapping("/products/images/{imageName}")
    public ResponseEntity<InputStreamResource> getImage(@PathVariable("imageName") String imageName) {
        String imagePath = "C:/HK1_NAM3/LapTrinhWeb/uploads/" + imageName; // Đảm bảo đường dẫn đúng
        try {
            Path path = Paths.get(imagePath);
            if (!Files.exists(path)) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }

            // Tự động phát hiện định dạng của ảnh
            String mimeType = Files.probeContentType(path);
            if (mimeType == null) {
                mimeType = "application/octet-stream"; // Default nếu không thể xác định
            }

            InputStream imageStream = Files.newInputStream(path);
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", mimeType); // Content-Type dựa trên loại ảnh thực tế

            InputStreamResource resource = new InputStreamResource(imageStream);
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(resource);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    @GetMapping("edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") Long id) {
        Optional<ProductEntity> opt = productService.findById(id);
        if (opt.isPresent()) {
            ProductEntity entity = opt.get();
            ProductDTO productDTO = new ProductDTO();
            BeanUtils.copyProperties(entity, productDTO);

            // Lấy tổng quantity từ bảng storeproduct
            Long totalQuantity = storeProductService.getTotalQuantityByProductId(id);
            productDTO.setTotalQuantity(totalQuantity != null ? totalQuantity : 0L);

            Long totalSold = storeProductService.getTotalSoldByProductId(id);
            productDTO.setTotalSold(totalSold != null ? totalSold : 0L);

            // Set category info
            List<CategoryEntity> categories = categoryService.findAll();
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

            // Thêm thông tin vào model
            model.addAttribute("product", productDTO);
            model.addAttribute("categories", categories);
            return new ModelAndView("admin/products/addOrEdit", model);
        }
        model.addAttribute("message", "Product not found");
        return new ModelAndView("redirect:/admin/products", model);
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(RedirectAttributes redirectAttributes,
                                     @Valid @ModelAttribute("product") ProductDTO productDTO,
                                     BindingResult result,
                                     @RequestParam(value = "rightImage", required = false) MultipartFile rightImage,
                                     @RequestParam(value = "leftImage", required = false) MultipartFile leftImage,
                                     @RequestParam(value = "behindImage", required = false) MultipartFile behindImage,
                                     @RequestParam(value = "frontImage", required = false) MultipartFile frontImage) {

        if (result.hasErrors()) {
            return new ModelAndView("admin/products/addOrEdit");
        }

        try {
            ProductEntity entity = new ProductEntity();
            if (productDTO.getId() != null) {
                Optional<ProductEntity> optEntity = productService.findById(productDTO.getId());
                optEntity.ifPresent(existingEntity -> entity.setId(existingEntity.getId()));  // Cập nhật ID nếu có
            }

            BeanUtils.copyProperties(productDTO, entity);  // Copy dữ liệu từ DTO vào entity
            // Xử lý upload ảnh và lưu vào cơ sở dữ liệu
            List<GalleryEntity> galleryEntities = new ArrayList<>();
            galleryEntities.addAll(processUploadedImage(rightImage, "right", entity));
            galleryEntities.addAll(processUploadedImage(leftImage, "left", entity));
            galleryEntities.addAll(processUploadedImage(behindImage, "behind", entity));
            galleryEntities.addAll(processUploadedImage(frontImage, "front", entity));
            if (!galleryEntities.isEmpty()) {
                // Set danh sách ảnh (galleries) vào product entity
                entity.setGalleryEntities(galleryEntities); // Gắn danh sách ảnh vào product
                // Lưu tất cả ảnh vào DB

                // Cập nhật lại thông tin ảnh cho productDTO (để hiển thị trong view)
                for (GalleryEntity gallery : galleryEntities) {
                    productDTO.getGalleries().add(new GalleryDTO(gallery.getImage(), gallery.getType()));
                }
            }

            // Gán category cho sản phẩm nếu có

            if (productDTO.getCategoryName() != null && !productDTO.getCategoryName().isEmpty()) {
                CategoryEntity category = categoryService.findByName(productDTO.getCategoryName())
                        .orElseThrow(() -> new RuntimeException("Category not found"));
                entity.setCategoryEntity(category);
            }
            String video = productDTO.getVideo();
            String videoPro = processYouTubeUrl(video);
            // Lưu sản phẩm vào cơ sở dữ liệu
            entity.setVideo(videoPro);
            List<SubcategoryValueEntity> subcategoryValues = subCategoryValueService.findByNames(productDTO.getSubcategoryName());
            entity.setSubCategoryValues(subcategoryValues);
            productService.save(entity);
            galleryService.saveAll(galleryEntities);

            // Xử lý từng ảnh và lưu vào DB

            redirectAttributes.addFlashAttribute("message", "Product " + (productDTO.getId() == null ? "added" : "updated") + " successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error processing product: " + e.getMessage());
        }

        return new ModelAndView("redirect:/admin/products");
    }

    /**
     * Xử lý ảnh upload và tạo các entity tương ứng
     */
    private List<GalleryEntity> processUploadedImage(MultipartFile image, String type, ProductEntity productEntity) {
        List<GalleryEntity> galleryEntities = new ArrayList<>();
        if (image != null && !image.isEmpty()) {
            // Process the image
            String imageName = FileHandler.save(image);  // Save image using FileHandler (similar to your original code)

            // If saving was successful, create a new GalleryEntity
            if (imageName != null) {
                GalleryEntity gallery = new GalleryEntity();
                gallery.setImage(imageName);  // Store the image name
                gallery.setType(type);  // Set the image type (e.g., "right", "left")
                gallery.setProductEntity(productEntity);  // Associate the image with the product
                galleryEntities.add(gallery);
            }
        }
        return galleryEntities;
    }

    public String processYouTubeUrl(String videoUrl) {
        String videoPro = null;

        if (videoUrl != null && !videoUrl.isEmpty()) {
            // Sử dụng regex để lấy videoId từ URL chuẩn
            String youtubeRegex = "^(https?://(?:www\\.)?youtube\\.com/watch\\?v=)([a-zA-Z0-9_-]+)";
            Pattern pattern = Pattern.compile(youtubeRegex);
            Matcher matcher = pattern.matcher(videoUrl);

            if (matcher.find()) {
                String videoId = matcher.group(2);  // Lấy videoId từ URL
                videoPro = "https://www.youtube.com/embed/" + videoId;  // Chuyển thành embed URL
            } else {
                // Nếu không phải là YouTube URL chuẩn, trả về null hoặc xử lý theo yêu cầu
                videoPro = videoUrl;
            }
        }

        return videoPro;
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
              //  galleryServiceImpl.addGalleryImage(galleryEntity);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "Error uploading images: " + e.getMessage();
        }

        return "Images uploaded successfully!";
    }
}