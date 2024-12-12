package com.javaweb.controller.vendor;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.converter.UserConverter;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.StoreEntity;
import com.javaweb.service.IStoreService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.FileHandler;
import org.springframework.beans.BeanUtils;
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

    @GetMapping("/manage")
    public String showStoreManagementPage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            List<StoreEntity> stores = storeService.findByOwner(owner);
            model.addAttribute("stores", stores);
        }
        return "/vendor/manage-store";
    }

    // Handle store creation
    @PostMapping("/stores/saveOrUpdate")
    public String createOrUpdateStore(@ModelAttribute StoreEntity store,
                                      BindingResult result,
                                      @RequestParam("storeAvatar") MultipartFile storeAvatar, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "store/create"; // Return to the form if there are validation errors
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            UserDTO user = userService.findByUserName(owner);
            store.setOwner(userConverter.convertToEntity(user));
        }

        if (!storeAvatar.isEmpty()) {
            // Save the uploaded image to a directory or database
            String avatarPath = FileHandler.save(storeAvatar);
            store.setAvatar(avatarPath);
        }

        // Save or update store in the database
        storeService.save(store);
        redirectAttributes.addFlashAttribute("message", "Add Store Successfully");
        return "redirect:/vendor/manage"; // Redirect to the store list or a confirmation page
    }

    // Show edit store form (example)
    @GetMapping("/edit/{id}")
    public String showEditStoreForm(@PathVariable("id") Long storeId, Model model) {
        Optional<?> store = storeService.findById(storeId);
        model.addAttribute("store", store);
        return "store/edit"; // Path to the edit form
    }

    @PostMapping("stores/delete/{id}")
    public String deleteStore(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        storeService.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Store deleted successfully!");
        return "redirect:/vendor/manage";
    }

}
