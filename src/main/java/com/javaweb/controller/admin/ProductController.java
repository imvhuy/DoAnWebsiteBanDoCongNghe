package com.javaweb.controller.admin;



import com.javaweb.entity.ProductEntity;

import com.javaweb.model.ProductModel;
import com.javaweb.service.IProductService;
import com.javaweb.service.impl.ProductServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping(value ="/admin/products")
public class ProductController {
    @Autowired
    private IProductService productService;
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
        model.addAttribute("productName", productModel);
        return new ModelAndView("admin/products/addOrEdit", model);
    }
    @GetMapping("edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") Long id) {
        Optional<ProductEntity> optProduct = productService.findById(id);
        ProductModel productModel = new ProductModel();
        //kiểm tra sự tồn tại của category
        if (optProduct.isPresent()) {
            ProductEntity entity = optProduct.get();
            //copy từ entity sang cateModel
            BeanUtils.copyProperties(entity, productModel);
            //đấy dữ liệu ra view
            model.addAttribute("product", productModel);
            return new ModelAndView("admin/products/addOrEdit", model);
        }
        model.addAttribute("message", "Product is not existed!!!!");
        return new ModelAndView("admin/products", model);
    }
    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(RedirectAttributes model,
                                     @Valid @ModelAttribute ProductModel productModel, BindingResult result) {
        if (result.hasErrors()) {
            return new ModelAndView("admin/products/addOrEdit");
        }
        ProductEntity entity = new ProductEntity();
        //copy từ Model sang Entity
        BeanUtils.copyProperties(productModel, entity);
        try {
            // gọi hàm save trong service
            productService.save(entity);
            //đưa thông báo về cho biến message
            String message = "";
            if (productModel.getId() != null) {
                message = "Product is Edited!!!!!!!!";
            } else {
                message = "Product  is saved!!!!!!!!";
            }
            model.addFlashAttribute("message", message);
        }
        catch(Exception e) {
            System.out.println(e);
        }
        //redirect ve URL controller
        return new ModelAndView("redirect:/admin/products");
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

}
