package com.javaweb.controller.admin;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.model.CategoryModel;
import com.javaweb.model.CategoryModel;
import com.javaweb.service.ICategoryService;

import jakarta.validation.Valid;

@Controller
@RequestMapping(value = "/admin/categories")
public class CategoryController {
	
	@Autowired
    private ICategoryService categoryService;
	
    
    @GetMapping
    public ModelAndView list(ModelMap model, @RequestParam(value = "message", required = false) String message) {
        //gọi hàm findAll() trong service
        List<CategoryEntity> list = categoryService.findAll();
        if (!StringUtils.isEmpty(message)) {
            model.addAttribute("message", message);
        }
        // chuyển dữ liệu từ list lên biến categories
        model.addAttribute("categories", list);
        return new ModelAndView("forward:/admin/categories/searchpaginated", model);
    }
    
    @GetMapping("add")
    public ModelAndView add(@ModelAttribute ModelMap model) {
        CategoryModel categoryModel = new CategoryModel();
        model.addAttribute("category", categoryModel);
        return new ModelAndView("admin/categories/addOrEdit", model);
    }


    @GetMapping("edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") Long id) {
        Optional<CategoryEntity> optCategory = categoryService.findById(id);
        CategoryModel cateModel = new CategoryModel();
        //kiểm tra sự tồn tại của category
        if (optCategory.isPresent()) {
            CategoryEntity entity = optCategory.get();
            //copy từ entity sang cateModel
            BeanUtils.copyProperties(entity, cateModel);
            //đấy dữ liệu ra view
            model.addAttribute("Category", cateModel);
            return new ModelAndView("admin/categories/addOrEdit", model);
        }
        model.addAttribute("message", "Category is not existed!!!!");
        return new ModelAndView("admin/categories", model);
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(RedirectAttributes model,
                                     @Valid @ModelAttribute CategoryModel CategoryModel, BindingResult result) {
        if (result.hasErrors()) {
            return new ModelAndView("admin/categories/addOrEdit");
        }
        CategoryEntity entity = new CategoryEntity();
        //copy từ Model sang Entity
        BeanUtils.copyProperties(CategoryModel, entity);
        try {
            // gọi hàm save trong service
            categoryService.save(entity);
            //đưa thông báo về cho biến message
            String message = "";
            if (CategoryModel.getId() != null) {
                message = "Category is Edited!!!!!!!!";
            } else {
                message = "Category is saved!!!!!!!!";
            }
            model.addFlashAttribute("message", message);
        }
        catch(Exception e) {
            System.out.println(e);
        }
        //redirect ve URL controller
        return new ModelAndView("redirect:/admin/categories");
    }

    @GetMapping(path = "/delete/{id}")
    public ModelAndView delete(RedirectAttributes model, @PathVariable("id") Long id) {
        Optional<CategoryEntity> optCategory = categoryService.findById(id);
        if (optCategory.isEmpty()) {
            model.addFlashAttribute("message", "categories is not exits!!!!");
            return new ModelAndView("redirect:/admin/categories");
        }
        categoryService.deleteById(id);
        model.addFlashAttribute("message", "categories is deleted!!!!");
        return new ModelAndView("redirect:/admin/categories");
    }

    @GetMapping("search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name) {
        List<CategoryEntity> list = null;
        // có nội dung truyền về không, name là tùy chọn khi required=false
        if (StringUtils.hasText(name)) {
            list = categoryService.findByNameContaining(name);
        } else {
            list = categoryService.findAll();
        }
        model.addAttribute("categories", list);
        return "admin/categories/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {
        int count = (int) categoryService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<CategoryEntity> resultPage = null;
        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        }
        else{
            resultPage = categoryService.findAll(pageable);
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
        }   model.addAttribute("categoryPage", resultPage);
        return "admin/categories/list";
    }
}
