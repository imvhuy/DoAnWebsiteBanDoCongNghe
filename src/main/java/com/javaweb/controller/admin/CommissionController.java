package com.javaweb.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

import com.javaweb.entity.*;
import com.javaweb.service.ICommissionService;
import com.javaweb.service.*;

@Controller
@RequestMapping(value = "/admin/commissions")
@EnableMethodSecurity
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class CommissionController {

	@Autowired
    private ICommissionService commissionService;

    @Autowired
    private IStoreService storeService;
    
    // Hiển thị danh sách tất cả các Commission
    @GetMapping
    public String showCommissionList(@RequestParam(defaultValue = "0") int page,
                                     @RequestParam(defaultValue = "5") int size, 
                                     Model model) {
        // Tạo đối tượng Pageable cho phân trang
        Pageable pageable = PageRequest.of(page, size);

        // Lấy danh sách các commission với phân trang
        Page<CommissionEntity> commissionPage = commissionService.findAll(pageable);

        // Thêm dữ liệu vào model
        model.addAttribute("commissionPage", commissionPage);
        model.addAttribute("commissionList", commissionPage.getContent());
        model.addAttribute("size", size);
        model.addAttribute("page", page);

        return "admin/commissions/commission-list"; // Trang JSP để hiển thị danh sách commission
    }

    
    // Trang hiển thị form để tạo Commission và chọn Store
    @GetMapping("add")
    public String showAddCommissionForm(Model model) {
        // Lấy danh sách tất cả Store
        List<StoreEntity> storeList = storeService.findAll();
        model.addAttribute("storeList", storeList);
        model.addAttribute("commission", new CommissionEntity());
        return "admin/commissions/addOrEdit"; // Trang JSP để hiển thị form
    }
    @GetMapping("edit/{id}")
    public String showEditCommissionForm(@PathVariable("id") Long id, Model model) {
        // Tìm commission theo id
        Optional<CommissionEntity> commissionOptional = commissionService.findById(id);
        if (commissionOptional.isEmpty()) {
            model.addAttribute("error", "Commission không tồn tại!");
            return "redirect:/admin/commissions"; // Nếu không tìm thấy commission, quay lại danh sách
        }

        // Lấy commission từ Optional
        CommissionEntity commission = commissionOptional.get();

        // Lấy danh sách tất cả store để người dùng chọn
        List<StoreEntity> storeList = storeService.findAll();
        model.addAttribute("storeList", storeList);
        model.addAttribute("commission", commission);

        return "admin/commissions/addOrEdit"; // Trang JSP để hiển thị form chỉnh sửa commission
    }
    // Xử lý khi form được submit để lưu Commission và gán cho Store
    @PostMapping("saveOrUpdate")
    public String saveCommission(@RequestParam(name = "isDeleted", required = false) Boolean isDeleted,@RequestParam("storeId") Long storeId, 
                                 CommissionEntity commissionEntity, 
                                 Model model) {
    	 if (isDeleted == null) {
    	        isDeleted = false;
    	    }
        // Tìm Store theo storeId
        Optional<StoreEntity> storeOptional = storeService.findById(storeId);
        if (storeOptional.isEmpty()) {
            model.addAttribute("error", "Store không tồn tại!");
            return "admin/commissions/addOrEdit"; // Nếu không tìm thấy store, quay lại trang tạo commission
        }

        // Lấy store từ Optional
        StoreEntity store = storeOptional.get();

        // Gán Store vào Commission
        commissionEntity.setStore(store);
        // Nếu commissionEntity có id, nghĩa là đang cập nhật
        if (commissionEntity.getId() != null) {
            // Cập nhật Commission nếu có id
            commissionEntity.setIsDeleted(isDeleted);
            commissionService.saveCommission(commissionEntity);
            model.addAttribute("message", "Commission đã được cập nhật thành công!");
        } else {
            // Thêm mới Commission nếu không có id
            CommissionEntity savedCommission = commissionService.saveCommission(commissionEntity);
            
            // Cập nhật commissionId vào Store (store đã được lấy trước đó)
            store.setCommission(savedCommission);  // Gán commission vào store

            // Lưu Store sau khi cập nhật commissionId
            storeService.save(store);

            model.addAttribute("message", "Commission đã được thêm và gán cho Store thành công!");
        }

        return "redirect:/admin/commissions"; // Chuyển hướng đến danh sách commission
    }			

    @GetMapping("delete/{id}")
    public ModelAndView delete(@PathVariable("id") Long id, RedirectAttributes model) {
        // Kiểm tra xem CommissionEntity có tồn tại hay không
        Optional<CommissionEntity> optionalCommission = commissionService.findById(id);
        if (optionalCommission.isEmpty()) {
            return new ModelAndView("redirect:/admin/commissions"); // Nếu không tồn tại, quay lại trang danh sách
        }

        CommissionEntity commission = optionalCommission.get();
        StoreEntity store = commission.getStore();

        // Kiểm tra nếu store hoặc store.commission là null để tránh NullPointerException
        if (store != null && store.getCommission() != null) {
            store.setCommission(null);  // Xóa commission khỏi store
            storeService.save(store);    // Lưu lại Store sau khi thay đổi
        }

        // Xóa CommissionEntity khỏi cơ sở dữ liệu
        commissionService.deleteById(id);

        // Quay lại danh sách commissions
        return new ModelAndView("redirect:/admin/commissions");
    }

}
