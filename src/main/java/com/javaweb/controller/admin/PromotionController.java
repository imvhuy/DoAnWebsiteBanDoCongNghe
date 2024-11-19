package com.javaweb.controller.admin;

import com.javaweb.entity.VoucherEntity;
import com.javaweb.model.Response;
import com.javaweb.service.PromotionService;

import jakarta.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
@Controller
@RequestMapping(value = "/admin/promotions")
@EnableMethodSecurity
public class PromotionController {
	
	@Autowired
    private PromotionService promotionService;

    // Hiển thị danh sách các voucher
    //@PreAuthorize("hasAuthority('ROLE_ADMIN')")
//	@GetMapping
//	public String list(@RequestParam(defaultValue = "0") int page,
//	                   @RequestParam(defaultValue = "5") int size,
//	                   ModelMap model, 
//	                   @RequestParam(value = "message", required = false) String message) {
//	    Pageable pageable = PageRequest.of(page, size);
//	    Page<VoucherEntity> promotionPage = promotionService.findAll(pageable);
//
//	    if (message != null) {
//	        model.addAttribute("message", message);
//	    }
//	    model.addAttribute("promotionPage", promotionPage);
//	    model.addAttribute("promotions", promotionPage.getContent());
//	    return "admin/promotions/promotion-list";
//	}
	
	
	@GetMapping
	public String list(@RequestParam(defaultValue = "0") int page,
	                   @RequestParam(defaultValue = "5") int size,
	                   @RequestParam(value = "name", required = false) String name,
	                   ModelMap model, 
	                   @RequestParam(value = "message", required = false) String message) {
	    Pageable pageable = PageRequest.of(page, size);
	    Page<VoucherEntity> promotionPage;

	    if (name != null && !name.isEmpty()) {
	        // Thực hiện tìm kiếm nếu có tên được cung cấp
	        promotionPage = promotionService.findByDescriptionContainingIgnoreCase(name, pageable);
	        model.addAttribute("name", name);
	    } else {
	        // Không tìm kiếm, chỉ phân trang toàn bộ danh sách
	        promotionPage = promotionService.findAll(pageable);
	    }

	    if (message != null) {
	        model.addAttribute("message", message);
	    }
	    model.addAttribute("promotionPage", promotionPage);
	    model.addAttribute("promotions", promotionPage.getContent());
	    return "admin/promotions/promotion-list";
	}


    // Hiển thị trang thêm mới promotion
    @GetMapping("add")
    //@PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ModelAndView add(ModelMap model) {
        VoucherEntity voucherEntity = new VoucherEntity();  // Tạo đối tượng voucher mới
        model.addAttribute("voucher", voucherEntity);
        return new ModelAndView("admin/promotions/addOrEdit", model);  // View cho trang thêm
    }

    // Hiển thị trang chỉnh sửa promotion
    @GetMapping("edit/{id}")
    //@PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ModelAndView edit(@PathVariable("id") Long id, ModelMap model) {
        Optional<VoucherEntity> optionalVoucher = promotionService.findById(id);
        if (optionalVoucher.isPresent()) {
            model.addAttribute("voucher", optionalVoucher.get());
            return new ModelAndView("admin/promotions/addOrEdit", model);  // View chỉnh sửa
        }
        model.addAttribute("message", "Voucher not found!");
        return new ModelAndView("redirect:/admin/promotions");
    }

    @PostMapping("saveOrUpdate")
    //@PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ModelAndView saveOrUpdate(@Valid @ModelAttribute("voucher") VoucherEntity voucherEntity,
                                     BindingResult result, RedirectAttributes model) {
        if (result.hasErrors()) {
            return new ModelAndView("admin/promotions/addOrEdit"); // Trả về trang với thông báo lỗi
        }
        promotionService.save(voucherEntity);
        String message = (voucherEntity.getId() != null) ? "Promotion updated successfully!" : "Promotion added successfully!";
        model.addFlashAttribute("message", message);
        return new ModelAndView("redirect:/admin/promotions");
    }


    // Xử lý xóa promotion
    @GetMapping("delete/{id}")
    //@PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ModelAndView delete(@PathVariable("id") Long id, RedirectAttributes model) {
        Optional<VoucherEntity> optionalVoucher = promotionService.findById(id);
        if (optionalVoucher.isEmpty()) {
            model.addFlashAttribute("message", "Voucher not found!");
            return new ModelAndView("redirect:/admin/promotions");
        }
        promotionService.deleteById(id);  // Xóa voucher
        model.addFlashAttribute("message", "Promotion deleted successfully!");  // Thêm thông báo
        return new ModelAndView("redirect:/admin/promotions");  // Quay lại danh sách promotion
    }
}
