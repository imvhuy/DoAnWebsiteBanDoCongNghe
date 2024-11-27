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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javaweb.dto.CommissionDTO;
import com.javaweb.entity.CommissionEntity;
import com.javaweb.service.ICommissionService;

import jakarta.validation.Valid;

@Controller
@RequestMapping(value = "/admin/commissions")
public class CommissionController {
	
	@Autowired
    private ICommissionService commissionService;
	
    
    @GetMapping
    public ModelAndView list(ModelMap model, @RequestParam(value = "message", required = false) String message) {
        //gọi hàm findAll() trong service
        List<CommissionEntity> list = commissionService.findAll();
        if (!StringUtils.isEmpty(message)) {
            model.addAttribute("message", message);
        }
        // chuyển dữ liệu từ list lên biến commissions
        model.addAttribute("commissions", list);
        return new ModelAndView("forward:/admin/commissions/searchpaginated", model);
    }
    
    @GetMapping("add")
    public ModelAndView add(@ModelAttribute ModelMap model) {
        CommissionDTO CommissionModel = new CommissionDTO();
        model.addAttribute("commission", CommissionModel);
        return new ModelAndView("admin/commissions/addOrEdit", model);
    }


    @GetMapping("edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") Long id) {
        Optional<CommissionEntity> optcommission = commissionService.findById(id);
        CommissionDTO cateModel = new CommissionDTO();
        //kiểm tra sự tồn tại của commission
        if (optcommission.isPresent()) {
            CommissionEntity entity = optcommission.get();
            //copy từ entity sang cateModel
            BeanUtils.copyProperties(entity, cateModel);
            //đấy dữ liệu ra view
            model.addAttribute("commission", cateModel);
            return new ModelAndView("admin/commissions/addOrEdit", model);
        }
        model.addAttribute("message", "commission is not existed!!!!");
        return new ModelAndView("admin/commissions", model);
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(RedirectAttributes model,
                                     @Valid @ModelAttribute CommissionDTO CommissionModel, BindingResult result) {
        if (result.hasErrors()) {
            return new ModelAndView("admin/commissions/addOrEdit");
        }
        CommissionEntity entity = new CommissionEntity();
        //copy từ Model sang Entity
        BeanUtils.copyProperties(CommissionModel, entity);
        try {
            // gọi hàm save trong service
            commissionService.save(entity);
            //đưa thông báo về cho biến message
            String message = "";
            if (CommissionModel.getId() != null) {
                message = "commission is Edited!!!!!!!!";
            } else {
                message = "commission is saved!!!!!!!!";
            }
            model.addFlashAttribute("message", message);
        }
        catch(Exception e) {
            System.out.println(e);
        }
        //redirect ve URL controller
        return new ModelAndView("redirect:/admin/commissions");
    }

    @GetMapping(path = "/delete/{id}")
    public ModelAndView delete(RedirectAttributes model, @PathVariable("id") Long id) {
        Optional<CommissionEntity> optcommission = commissionService.findById(id);
        if (optcommission.isEmpty()) {
            model.addFlashAttribute("message", "commissions is not exits!!!!");
            return new ModelAndView("redirect:/admin/commissions");
        }
        commissionService.deleteById(id);
        model.addFlashAttribute("message", "commissions is deleted!!!!");
        return new ModelAndView("redirect:/admin/commissions");
    }

    @GetMapping("search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name) {
        List<CommissionEntity> list = null;
        // có nội dung truyền về không, name là tùy chọn khi required=false
        if (StringUtils.hasText(name)) {
            list = commissionService.findByNameContaining(name);
        } else {
            list = commissionService.findAll();
        }
        model.addAttribute("commissions", list);
        return "admin/commissions/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {
        int count = (int) commissionService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<CommissionEntity> resultPage = null;
        if (StringUtils.hasText(name)) {
            resultPage = commissionService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        }
        else{
            resultPage = commissionService.findAll(pageable);
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
        }   model.addAttribute("commissionPage", resultPage);
        return "admin/commissions/list";
    }
}
