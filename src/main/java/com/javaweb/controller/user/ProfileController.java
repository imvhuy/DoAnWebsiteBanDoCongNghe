package com.javaweb.controller.user;

import com.javaweb.entity.AddressEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.AddressModel;
import com.javaweb.model.UserModel;
import com.javaweb.service.IAddressService;
import com.javaweb.service.IUserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    @Autowired
    IUserService userService;
    @Autowired
    private IAddressService addressService;

//    @ModelAttribute("currentPage")
//    public String currentPage(HttpServletRequest request) {
//
//        String uri = request.getRequestURI();
//        if (uri.contains("/address")) {
//            return "address";
//        } else if (uri.contains("/detail")) {
//            return "detail";
//        } else {
//            return "dashboard";
//        }
//    }

    @GetMapping
    public String profile(ModelMap model) {
        return "redirect:/profile/{username}";
    }

    @GetMapping("/{username}")
    public ModelAndView profile(@PathVariable String username) {
        ModelAndView modelAndView = new ModelAndView("/user/dashboard");
        modelAndView.addObject("currentPage", "dashboard");
        return modelAndView;
    }

    @GetMapping("/address/{username}")
    public ModelAndView address(@PathVariable("username") String username, ModelMap model) {
        UserModel user = userService.findByUserName(username);
        List<AddressEntity> addresses = addressService.getAddressesByUserId(user.getId());

        // Sắp xếp danh sách sao cho địa chỉ mặc định (isDefault = true) đứng đầu
        addresses.sort(Comparator.comparing(AddressEntity::getIsDefault).reversed());

        // Chuyển đổi AddressEntity thành AddressModel
        List<AddressModel> addressModels = new ArrayList<>();
        for (AddressEntity address : addresses) {
            AddressModel addressModel = addressService.findAddressModelById(address.getId());
            addressModels.add(addressModel);
        }
        model.addAttribute("currentPage", "address");
        model.addAttribute("addresses", addressModels);
        return new ModelAndView("user/address");
    }

    @PostMapping("saveOrUpdate/{username}")
    public ModelAndView save(@Valid AddressModel address, @PathVariable String username, BindingResult result, RedirectAttributes redirectAttributes) {

        AddressEntity entity = new AddressEntity();
        if (result.hasErrors()) {
            return new ModelAndView("user/address");
        }
        UserModel user = userService.findByUserName(username);
        UserEntity userEntity = new UserEntity();
        BeanUtils.copyProperties(user, userEntity);
        address.setUser(userEntity);
        BeanUtils.copyProperties(address, entity);
        try {
            if (address.getId() == null) {
                addressService.save(entity);
                if (entity.getIsDefault() == true) {
                    entity = addressService.setDefaultAddress(user.getId(), entity.getId());
                    addressService.save(entity);
                }
            }
            else {
                if (entity.getIsDefault() == true) {
                    entity = addressService.setDefaultAddress(user.getId(), entity.getId());
                    addressService.save(entity);
                }
            }
            // gọi hàm save trong service
            //đưa thông báo về cho biến message
            String message = "";
            if (address.getId() != null) {
                message = "Address is Edited!!!!!!!!";
            } else {
                message = "Address is saved!!!!!!!!";
            }
            redirectAttributes.addFlashAttribute("message", message);
        } catch (Exception e) {
            System.out.println(e);
        }
        //redirect ve URL controller
        return new ModelAndView("redirect:/profile/address/" + username);
    }

    @GetMapping("/address/delete")
    public ModelAndView deleteAddress(@RequestParam("username") String username,
                                      @RequestParam("addressId") Long addressId,
                                      RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra xem người dùng có tồn tại không
            UserModel user = userService.findByUserName(username);
            if (user == null) {
                redirectAttributes.addFlashAttribute("message", "User not found.");
                return new ModelAndView("redirect:/profile/address/" + username);
            }

            // Kiểm tra xem địa chỉ có thuộc về người dùng không
            Optional<AddressEntity> address = addressService.findById(addressId);
            if (address == null || !address.get().getUser().getId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("message", "Address not found or does not belong to the user.");
                return new ModelAndView("redirect:/profile/address/" + username);
            }

            // Xóa địa chỉ
            addressService.deleteAddressById(addressId);
            redirectAttributes.addFlashAttribute("message", "Address has been deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error occurred while deleting the address.");
            System.out.println(e);
        }

        // Redirect lại trang địa chỉ của người dùng
        return new ModelAndView("redirect:/profile/address/" + username);
    }

    @GetMapping("/default")
    public Optional<AddressEntity> getDefaultAddress(@PathVariable Long userId) {
        return addressService.getDefaultAddress(userId);
    }

    @GetMapping("/detail/{username}")
    public ModelAndView getDetail(@PathVariable String username, ModelMap model) {
        model.addAttribute("currentPage", "detail");
        return new ModelAndView("/user/account-detail");
    }
}
