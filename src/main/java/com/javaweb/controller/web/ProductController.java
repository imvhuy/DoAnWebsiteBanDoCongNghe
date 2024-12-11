package com.javaweb.controller.web;

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
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
    public ModelAndView getProduct(@PathVariable("categoryslug") String categorySlug,
                                   @RequestParam Map<String, String> filters, Model model) {
        int count = (int) productService.count();
        int currentPage = 1;
        if (filters.containsKey("page")) {
            currentPage = Integer.parseInt(filters.get("page"));
            filters.remove("page");
        }
        int pageSize = 12;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<ProductEntity> resultPage = null;
        CategoryEntity category = categoryService.findCategoryEntityBySlug(categorySlug, false);
        // Lấy giá trị giá thấp nhất và cao nhất của sản phẩm theo danh mục (nếu có)
        long maxPrice = 0;
        try {
            long minMaxPrice = productService.findMinMaxPriceByCategory(category.getId());
            maxPrice = minMaxPrice;
            model.addAttribute("maxPrice", maxPrice);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (maxPrice == 0) {
            model.addAttribute("maxPrice", 50000000);
        }
        model.addAttribute("params", filters);

        model.addAttribute("category", category);
        if (!filters.isEmpty()) {
            resultPage = productService.filterProductsByCategoryAndValue(category.getId(), filters, pageable);
        } else {
            resultPage = productService.findByCategoryEntity_IdAndIsActive(category.getId(), true, pageable);
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
        List<SubcategoryEntity> subcategoryEntities = subcategoryService.getSubcategoryByCategoryId(category.getId());
        model.addAttribute("subcategories", subcategoryEntities);
        model.addAttribute("productPages", resultPage);
        return new ModelAndView("web/product/list");
    }

    @GetMapping("/filter")
    public ModelAndView filterProducts(@RequestParam Map<String, String> filters, Model model,
                                       @RequestParam("page") Optional<Integer> page) {
        // Call service to fetch filtered products
        filters.entrySet().removeIf(entry -> entry.getValue() == null || entry.getValue().isEmpty());
        int count = (int) productService.count();
        int currentPage = page.orElse(1);
        int pageSize = 16;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<ProductEntity> resultPage = null;
        resultPage = productService.searchProducts(filters, pageable);
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
        model.addAttribute("appliedFilters", filters);
        return new ModelAndView("/web/product/list");
    }

    @GetMapping
    public ModelAndView getAllProduct(@RequestParam(name = "text", required = false) String name,
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
        ProductEntity productEntity = new ProductEntity();
        productEntity = resultPage.getContent().get(0);
        List<SubcategoryEntity> subcategoryEntities = subcategoryService.getSubcategoryByCategoryId(productEntity.getCategoryEntity().getId());
        model.addAttribute("subcategories", subcategoryEntities);
        model.addAttribute("productPages", resultPage);
        return new ModelAndView("/web/product/list");
    }
}
