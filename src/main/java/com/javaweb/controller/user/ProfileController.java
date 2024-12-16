package com.javaweb.controller.user;

import com.javaweb.dto.ChangePasswordDTO;
import com.javaweb.entity.AddressEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.OrderItemEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.dto.AddressDTO;
import com.javaweb.dto.UserDTO;
import com.javaweb.service.IAddressService;
import com.javaweb.service.IOrderService;
import com.javaweb.service.IUserService;
import com.javaweb.service.auth.AuthenticationService;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    @Autowired
    private IUserService userService;
    @Autowired
    private IAddressService addressService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    AuthenticationService authenticationService;
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
        UserDTO user = userService.findByUserName(username);
        List<AddressEntity> addresses = addressService.getAddressesByUserId(user.getId());

        // Sắp xếp danh sách sao cho địa chỉ mặc định (isDefault = true) đứng đầu
        addresses.sort(Comparator.comparing(AddressEntity::getIsDefault).reversed());

        // Chuyển đổi AddressEntity thành AddressModel
        List<AddressDTO> addressDTOS = new ArrayList<>();
        for (AddressEntity address : addresses) {
            AddressDTO addressDTO = addressService.findAddressModelById(address.getId());
            addressDTOS.add(addressDTO);
        }
        model.addAttribute("currentPage", "address");
        model.addAttribute("addresses", addressDTOS);
        return new ModelAndView("user/address");
    }

    @PostMapping("saveOrUpdate/{username}")
    public ModelAndView save(
            @Valid AddressDTO address,
            @PathVariable String username,
            BindingResult result,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            return new ModelAndView("user/address");
        }

        try {
            UserDTO user = userService.findByUserName(username);
            UserEntity userEntity = new UserEntity();
            BeanUtils.copyProperties(user, userEntity);

            AddressEntity entity = new AddressEntity();
            address.setUser(userEntity);
            BeanUtils.copyProperties(address, entity);

            // Lưu địa chỉ và thiết lập nếu là địa chỉ mặc định
            addressService.save(entity);
            if (Boolean.TRUE.equals(entity.getIsDefault())) {
                addressService.setDefaultAddress(user.getId(), entity.getId());
            }

            // Thông báo trạng thái
            String message = (address.getId() != null)
                    ? "Address is Edited!!!!!!!!"
                    : "Address is saved!!!!!!!!";
            redirectAttributes.addFlashAttribute("message", message);

        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("redirect:/profile/address/" + username);
    }


    @GetMapping("/address/delete")
    public ModelAndView deleteAddress(@RequestParam("username") String username,
                                      @RequestParam("addressId") Long addressId,
                                      RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra xem người dùng có tồn tại không
            UserDTO user = userService.findByUserName(username);
            if (user == null) {
                redirectAttributes.addFlashAttribute("message", "User not found.");
                return new ModelAndView("redirect:/profile/address/" + username);
            }

            // Kiểm tra xem địa chỉ có thuộc về người dùng không
            Optional<AddressEntity> address = addressService.findById(addressId);
            if (address.isEmpty() || !address.get().getUser().getId().equals(user.getId())) {
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

    @GetMapping("/detail/{username}")
    public ModelAndView getDetail(@PathVariable String username, ModelMap model) {
        model.addAttribute("currentPage", "detail");
        UserDTO user = userService.findByUserName(username);
        model.addAttribute("user", user);
        return new ModelAndView("/user/account-detail");
    }
    @PostMapping("/changePassword/{username}")
    public ModelAndView changePassword(@ModelAttribute ChangePasswordDTO changePasswordDTO,
                                       @PathVariable String username,
                                       RedirectAttributes redirectAttributes) {
        // Lấy giá trị từ form
        String currentPassword = changePasswordDTO.getCurrentPassword();
        String newPassword = changePasswordDTO.getNewPassword();
        String confirmPassword = changePasswordDTO.getConfirmPassword();

        // Kiểm tra hợp lệ
        if (currentPassword == null || newPassword == null || confirmPassword == null) {
            redirectAttributes.addFlashAttribute("message", "All fields are required.");
            return new ModelAndView("redirect:/profile/detail/" + username);
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("message", "New password and confirmation do not match.");
            return new ModelAndView("redirect:/profile/detail/" + username);
        }

        // Gọi service để xử lý thay đổi mật khẩu (giả sử có UserService)
        boolean success = authenticationService.changePassword(username, currentPassword, newPassword);

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Password changed successfully.");

        } else {
            redirectAttributes.addFlashAttribute("message", "Current password is incorrect.");
        }
        return new ModelAndView("redirect:/profile/detail/" + username);
    }

    @GetMapping("checkorderlist/{username}")
    public String checkOrderlist(@PathVariable("username") String username, Model model) {
        // Kiểm tra nếu người dùng đăng nhập không khớp username được yêu cầu

        // Lấy danh sách đơn hàng của người dùng
        List<OrderEntity> orders = orderService.findOrdersByUsername(username);

        // Truyền dữ liệu vào model để hiển thị
        model.addAttribute("orders", orders);

        return "user/order"; // Trả về trang JSP "order"
    }
    public class RandomCodeGenerator {
        public static String generateRandomCode() {
            Random random = new Random();
            int part1 = 1000 + random.nextInt(9000); // Random 4 chữ số
            int part2 = 1000 + random.nextInt(9000); // Random 4 chữ số
            int part3 = 1000 + random.nextInt(9000); // Random 4 chữ số
            return String.format("%04d-%04d-%04d", part1, part2, part3);
        }
    }

    @GetMapping("ordersdetails/{orderId}")
    public String getOrderDetails(@PathVariable Long orderId, Model model) {
        OrderEntity order = orderService.findById(orderId)
                                        .orElseThrow(() -> new RuntimeException("Order not found"));
        List<OrderItemEntity> orderItems = order.getOrderItems(); // Lấy danh sách sản phẩm trong đơn hàng

        String trackingCode = RandomCodeGenerator.generateRandomCode();
        model.addAttribute("trackingCode", trackingCode);
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);

        return "user/orderDetail"; // Đường dẫn tới JSP

    }

}
