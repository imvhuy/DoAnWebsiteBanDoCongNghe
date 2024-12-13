package com.javaweb.controller.vendor;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.converter.UserConverter;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.StoreEntity;
import com.javaweb.service.IStoreService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.FileHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/vendor")
public class StoreController {
    @Autowired
    IStoreService storeService;

    @Autowired
    IUserService userService;

    @Autowired
    UserConverter userConverter;

    @GetMapping("/manage-store")
    public String showStoreManagementPage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            StoreEntity currentStore = storeService.findByOwner(owner);
            model.addAttribute("store", currentStore);
            return "/vendor/manage-store";
        }
        return "/vendor/manage-store";
    }

    @PostMapping("/saveOrUpdate")
    public String registerStore(@ModelAttribute StoreEntity store,
                                @RequestParam("avatarStore") MultipartFile avatar, RedirectAttributes model) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            if (!avatar.isEmpty()) {
                String avatarPath = FileHandler.save(avatar);
                store.setAvatar(avatarPath);
            }
            store.setOwner(userConverter.convertToEntity(userService.findByUserName(owner)));
            if(store.getId() == null) {
                model.addFlashAttribute("message", "Đăng ký thành công, hãy chờ Admin duyệt!!");
            }
            else {
                model.addFlashAttribute("message", "Chỉnh sửa thông tin cửa hàng thành công");
            }
            storeService.save(store);
            // Gửi thông tin đã đăng ký đến trang xác nhận
            model.addAttribute("store", store);
            return "redirect:/vendor/manage-store";
        } catch (Exception e) {
            model.addAttribute("message", "Có lỗi xảy ra khi đăng ký cửa hàng.");
            return "redirect:/vendor/manage-store";
        }
    }

    @PostMapping("stores/delete/{id}")
    public String deleteStore(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        storeService.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Store deleted successfully!");
        return "redirect:/vendor/manage";
    }

}
