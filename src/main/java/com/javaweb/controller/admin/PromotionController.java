package com.javaweb.controller.admin;

import com.javaweb.entity.VoucherEntity;
import com.javaweb.service.IPromotionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.Optional;

@Controller
@RequestMapping(value = "/admin/promotions")
public class PromotionController {

    @Autowired
    private IPromotionService promotionService;
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")

    // Hiển thị danh sách các voucher với phân trang và tìm kiếm theo tên
    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page,
                       @RequestParam(defaultValue = "10") int size,
                       @RequestParam(value = "name", required = false) String name,
                       ModelMap model) 
    {
        // Tạo Pageable từ các tham số trang và kích thước
        Pageable pageable = PageRequest.of(page, size);
        Page<VoucherEntity> promotionPage;

        if (name != null && !name.isEmpty()) {
            // Tìm kiếm theo mô tả nếu tên được cung cấp
            promotionPage = promotionService.findByDescriptionContainingIgnoreCase(name, pageable);
            model.addAttribute("name", name);
        } else {
            // Không tìm kiếm, chỉ phân trang toàn bộ danh sách
            promotionPage = promotionService.findAll(pageable);
        }

        // Thêm các thuộc tính vào model để hiển thị trên view
        model.addAttribute("promotionPage", promotionPage);  // Trang hiện tại
        model.addAttribute("promotions", promotionPage.getContent());  // Dữ liệu của trang
        model.addAttribute("totalPages", promotionPage.getTotalPages()); // Tổng số trang
        model.addAttribute("totalElements", promotionPage.getTotalElements()); // Tổng số mục
        model.addAttribute("currentPage", page);  // Trang hiện tại
        model.addAttribute("size", size); // Thêm size vào model để giữ giá trị cho form
        model.addAttribute("page", page); // Thêm page vào model để giữ giá trị cho form

        return "admin/promotions/promotion-list";  // View hiển thị danh sách voucher
    }


    // Hiển thị trang thêm mới promotion
    @GetMapping("add")
    public ModelAndView add(ModelMap model) {
        VoucherEntity voucherEntity = new VoucherEntity();  // Tạo đối tượng voucher mới
        model.addAttribute("voucher", voucherEntity);
        return new ModelAndView("admin/promotions/addOrEdit", model);  // View cho trang thêm
    }

    // Hiển thị trang chỉnh sửa promotion
    @GetMapping("edit/{id}")
    public ModelAndView edit(@PathVariable("id") Long id, @RequestParam(value = "view", required = false) String view, ModelMap model) {
        Optional<VoucherEntity> optionalVoucher = promotionService.findById(id);
        if (optionalVoucher.isPresent()) {
            model.addAttribute("voucher", optionalVoucher.get());
            model.addAttribute("view", view);  // Thêm tham số 'view' vào model
            return new ModelAndView("admin/promotions/addOrEdit", model);  // View chỉnh sửa
        }
        return new ModelAndView("redirect:/admin/promotions");
    }


    // Lưu hoặc cập nhật promotion
    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(@ModelAttribute("voucher") VoucherEntity voucherEntity,
                                     RedirectAttributes model) {
        promotionService.save(voucherEntity);

        return new ModelAndView("redirect:/admin/promotions");  // Quay lại danh sách promotion
    }

    // Xử lý xóa promotion
    @GetMapping("delete/{id}")
    public ModelAndView delete(@PathVariable("id") Long id, RedirectAttributes model) {
        Optional<VoucherEntity> optionalVoucher = promotionService.findById(id);
        if (optionalVoucher.isEmpty()) {
            return new ModelAndView("redirect:/admin/promotions");
        }
        promotionService.deleteById(id);  // Xóa voucher
        
        return new ModelAndView("redirect:/admin/promotions");  // Quay lại danh sách promotion
    }
}
