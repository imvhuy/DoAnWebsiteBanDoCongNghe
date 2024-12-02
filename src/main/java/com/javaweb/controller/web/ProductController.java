package com.javaweb.controller.web;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.SubcategoryEntity;
import com.javaweb.service.ICategoryService;
import com.javaweb.service.IProductService;
import com.javaweb.service.ISubCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller("ProductControllerOfWeb")
@RequestMapping(value = "/products")
public class ProductController {

    @Autowired
    ICategoryService categoryService;
    @Autowired
    IProductService productService;
    @Autowired
    ISubCategoryService subcategoryService;

    @GetMapping("/{categoryslug}")
    public String getProduct(@PathVariable("categoryslug") String categorySlug,
                             @RequestParam("page") Optional<Integer> page, Model model) {
        int count = (int) productService.count();
        int currentPage = page.orElse(1);
        int pageSize = 16;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<ProductEntity> resultPage = null;
        CategoryEntity category = categoryService.findCategoryEntityBySlug(categorySlug, false);
        if (StringUtils.hasText(categorySlug)) {
            resultPage = productService.findByCategoryEntity_IdAndIsActive(category.getId(), true, pageable);
            model.addAttribute("name", category.getName());
        } else {
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
            List<SubcategoryEntity> subcategoryEntities = subcategoryService.getSubcategoryByCategoryId(category.getId());

            List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
            model.addAttribute("subcategories", subcategoryEntities);
            model.addAttribute("pageNumbers", pageNumbers);
        }
        model.addAttribute("productPages", resultPage);
        return "/web/product/list";
    }


    @GetMapping("/filter")
    public String filterProducts(
            @RequestParam Map<String, List<String>> params,
            Model model) {

        // Params sẽ chứa các tham số từ query string (key = subcategoryId, value = List<String> của các giá trị đã chọn)
//        List<ProductEntity> filteredProducts = productService.filterProducts(params);

        // Đưa danh sách sản phẩm đã lọc vào model để hiển thị trên trang
//        model.addAttribute("products", filteredProducts);
        return "productList"; // trả về trang hiển thị danh sách sản phẩm
    }

    @GetMapping("/{categorySlug}/{subcategorySlug}")
    public String getProduct(@PathVariable("categorySlug") String categorySlug,
                             @PathVariable("subcategorySlug") String subcategorySlug,
                             @RequestParam("page") Optional<Integer> page, Model model) {
        int count = (int) productService.count();
        int currentPage = page.orElse(1);
        int pageSize = 16;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<ProductEntity> resultPage = null;
        if (StringUtils.hasText(subcategorySlug)) {
            resultPage = productService.findByNameContaining(subcategorySlug, pageable);
            model.addAttribute("name", subcategorySlug);
        } else {
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
        }
        model.addAttribute("productPages", resultPage);
        return "/web/product/list";
    }


    @GetMapping
    public ModelAndView getAllProduct(@RequestParam(name = "name", required = false) String name,
                                      @RequestParam("page") Optional<Integer> page, Model model) {
        int count = (int) productService.count();
        int currentPage = page.orElse(1);
        int pageSize = 16;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<ProductEntity> resultPage = null;
        if (StringUtils.hasText(name)) {
            resultPage = productService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
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
        }
        model.addAttribute("productPages", resultPage);
        return new ModelAndView("/web/product/list");
    }
}
