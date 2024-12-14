package com.javaweb.controller.vendor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vendor")
public class VendorOrderController {

    @Autowired
    private IOrderService orderService;

    // Hiển thị danh sách đơn hàng
    @GetMapping("/manage-orders")
    public String manageOrders(
            @RequestParam(name = "status", required = false) String status,
            @RequestParam(name = "orderId", required = false) String orderId,
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model) {

        // Lấy danh sách đơn hàng theo trạng thái hoặc tìm kiếm theo ID
        List<Order> orders = orderService.getOrders(status, orderId, page);
        int totalPages = orderService.getTotalPages(status, orderId);

        // Thêm các thuộc tính vào model để hiển thị trên JSP
        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("orderId", orderId);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "manage-orders";  // trả về view manage-orders.jsp
    }

    // Cập nhật trạng thái đơn hàng
    @PostMapping("/update-order-status")
    public String updateOrderStatus(
            @RequestParam("orderId") Long orderId,
            @RequestParam("newStatus") String newStatus) {

        // Cập nhật trạng thái đơn hàng
        orderService.updateOrderStatus(orderId, newStatus);

        // Quay lại trang quản lý đơn hàng
        return "redirect:/vendor/manage-orders";
    }
}