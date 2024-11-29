package com.javaweb.controller.web;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.ProductEntity;
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
    public ModelAndView getProduct(@PathVariable("categoryslug") String categorySlug, Model model) {
        CategoryEntity category = categoryService.findCategoryEntityBySlug(categorySlug, false);
        List<ProductEntity> products = category.getProducts();
        model.addAttribute("products", products);
        return new ModelAndView("/web/product/list");
    }

    @GetMapping("/{categorySlug}/{subcategorySlug}")
    public String getProduct(@PathVariable("categorySlug") String categorySlug,
                             @PathVariable("subcategorySlug") String subcategorySlug,
                             @RequestParam("page") Optional<Integer> page, Model model) {
//            int count = (int) IProductService.count();
//            int currentPage = page.orElse(1);
//            int pageSize = size.orElse(3);
//            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
//            Page<CarrierEntity> resultPage = null;
//            if (StringUtils.hasText(name)) {
//                resultPage = ICarrierService.findByNameContaining(name, pageable);
//                model.addAttribute("name", name);
//            }
//            else{
//                resultPage = ICarrierService.findAll(pageable);
//            }
//            int totalPages = resultPage.getTotalPages();
//            if (totalPages > 0) {
//                int start = Math.max(1, currentPage - 2);
//                int end = Math.min(currentPage + 2, totalPages);
//                if (totalPages > count) {
//                    if (end == totalPages) start = end - count;
//                    else if (start == 1) end = start + count;
//                }
//                List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
//                model.addAttribute("pageNumbers", pageNumbers);
//            }   model.addAttribute("carrierPage", resultPage);
            return "admin/carriers/list";
    }

    @GetMapping("/")
    public ModelAndView getAllProduct(@PathVariable("slug") String slug, Model model){
        List<ProductEntity> productEntities = new ArrayList<>();


        model.addAttribute("products", productEntities);
        return new ModelAndView("/web/product/list");
    }
}
