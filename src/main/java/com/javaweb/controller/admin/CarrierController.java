package com.javaweb.controller.admin;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.dto.CarrierDTO;
import com.javaweb.service.ICarrierService;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
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
@RequestMapping(value = "/admin/carriers")
@EnableMethodSecurity
public class CarrierController {
    @Autowired
    private ICarrierService ICarrierService;

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping
    public ModelAndView list(ModelMap model, @RequestParam(value = "message", required = false) String message) {
        //gọi hàm findAll() trong service
        List<CarrierEntity> list = ICarrierService.findAll();
        if (!StringUtils.isEmpty(message)) {
            model.addAttribute("message", message);
        }
        // chuyển dữ liệu từ list lên biến categories
        model.addAttribute("carrier", list);
        return new ModelAndView("forward:/admin/carriers/searchpaginated", model);
    }

    @GetMapping("add")
    public ModelAndView add(@ModelAttribute ModelMap model) {
        CarrierDTO categoryModel = new CarrierDTO();
        model.addAttribute("carrier", categoryModel);
        return new ModelAndView("admin/carriers/addOrEdit", model);
    }


    @GetMapping("edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") Long id) {
        Optional<CarrierEntity> optCarrier = ICarrierService.findById(id);
        CarrierDTO cateModel = new CarrierDTO();
        //kiểm tra sự tồn tại của category
        if (optCarrier.isPresent()) {
            CarrierEntity entity = optCarrier.get();
            //copy từ entity sang cateModel
            BeanUtils.copyProperties(entity, cateModel);
            //đấy dữ liệu ra view
            model.addAttribute("carrier", cateModel);
            return new ModelAndView("admin/carriers/addOrEdit", model);
        }
        model.addAttribute("message", "Carrier is not existed!!!!");
        return new ModelAndView("admin/carriers", model);
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(RedirectAttributes model,
                                     @Valid @ModelAttribute CarrierDTO carrierModel, BindingResult result) {
        if (result.hasErrors()) {
            return new ModelAndView("admin/carriers/addOrEdit");
        }
        CarrierEntity entity = new CarrierEntity();
        //copy từ Model sang Entity
        BeanUtils.copyProperties(carrierModel, entity);
        try {
            // gọi hàm save trong service
            ICarrierService.save(entity);
            //đưa thông báo về cho biến message
            String message = "";
            if (carrierModel.getId() != null) {
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
        return new ModelAndView("redirect:/admin/carriers");
    }

    @GetMapping(path = "/delete/{id}")
    public ModelAndView delete(RedirectAttributes model, @PathVariable("id") Long id) {
        Optional<CarrierEntity> optCategory = ICarrierService.findById(id);
        if (optCategory.isEmpty()) {
            model.addFlashAttribute("message", "Carriers is not exits!!!!");
            return new ModelAndView("redirect:/admin/carriers");
        }
        ICarrierService.deleteById(id);
        model.addFlashAttribute("message", "Carriers is deleted!!!!");
        return new ModelAndView("redirect:/admin/carriers");
    }

    @GetMapping("search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name) {
        List<CarrierEntity> list = null;
        // có nội dung truyền về không, name là tùy chọn khi required=false
        if (StringUtils.hasText(name)) {
            list = ICarrierService.findByNameContaining(name);
        } else {
            list = ICarrierService.findAll();
        }
        model.addAttribute("categories", list);
        return "admin/carriers/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {
        int count = (int) ICarrierService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<CarrierEntity> resultPage = null;
        if (StringUtils.hasText(name)) {
            resultPage = ICarrierService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        }
        else{
            resultPage = ICarrierService.findAll(pageable);
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
        }   model.addAttribute("carrierPage", resultPage);
        return "admin/carriers/list";
    }

}
