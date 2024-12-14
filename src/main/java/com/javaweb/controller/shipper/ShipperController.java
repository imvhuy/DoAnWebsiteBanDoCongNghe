package com.javaweb.controller.shipper;

import com.javaweb.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/shipper")
public class ShipperController {
    @Autowired
    private IOrderService orderService;
    @GetMapping(value = "/home")
    public String home(Model model) {
        // Lấy dữ liệu từ service
        Long inProgressCount = orderService.getInProgressOrdersCount();
        Long deliveredCount = orderService.getDeliveredOrdersCount();
        Long pendingCount = orderService.getPendingOrdersCount();

        // Thêm dữ liệu vào model để gửi sang JSP
        model.addAttribute("inProgressCount", inProgressCount);
        model.addAttribute("deliveredCount", deliveredCount);
        model.addAttribute("pendingCount", pendingCount);

        return "shipper/home"; // Tên file JSP
    }
}
