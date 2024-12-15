package com.javaweb.controller.user;

import com.javaweb.dto.PaymentDTO;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.IOrderService;
import com.javaweb.service.IUserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class PaymentReturnController {
    @Autowired
    IOrderService orderService;
    @Autowired
    IUserService userService;

    @GetMapping("paymentReturn")
    public String paymentReturn(@RequestParam Map<String, String> params, Model model, @SessionAttribute PaymentDTO paymentDTO) {
        // Kiểm tra mã phản hồi từ VNPay
        String responseCode = params.get("vnp_ResponseCode");
        if ("00".equals(responseCode)) {
            // Thanh toán thành công
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            UserEntity user = userService.findByUserNameEntity(username);
            String payDate = params.get("vnp_PayDate");
            try {
                if(paymentDTO.getVoucher().isEmpty()){
                    paymentDTO.setVoucher("0");
                }
                orderService.createOrders(user.getId(), Long.parseLong(paymentDTO.getCarrierId()), Long.parseLong(paymentDTO.getAddress()), paymentDTO.getPaymentMethod(),Long.parseLong(paymentDTO.getVoucher()));
                model.addAttribute("message", "Thanh toán thành công");
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("message", e.getMessage());
            }

        } else {
            // Thanh toán thất bại
            model.addAttribute("errorMessage", "Thanh toán thất bại, hãy thử lại. Mã lỗi: " + responseCode);
        }
        return "/user/payment-status";
    }
}
