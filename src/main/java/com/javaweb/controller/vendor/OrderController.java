package com.javaweb.controller.vendor;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.service.IOrderService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("OrderOfVendor")
@RequestMapping("/vendor")
public class OrderController {

    @Autowired
    private IOrderService orderService;

//    // Hiển thị danh sách đơn hàng
    @GetMapping("/manage-order")
    public String manageOrders(
            @RequestParam(name = "status", required = false) String status,
            @RequestParam(name = "orderId", required = false) String orderId,
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model) {

        // Lấy danh sách đơn hàng theo trạng thái hoặc tìm kiếm theo ID
//        List<OrderEntity> orders = orderService.getOrders(status, orderId, page);
//        int totalPages = orderService.getTotalPages(status, orderId);
//
//        // Thêm các thuộc tính vào model để hiển thị trên JSP
//        model.addAttribute("orders", orders);
//        model.addAttribute("status", status);
//        model.addAttribute("orderId", orderId);
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPages", totalPages);

        return "vendor/manage-order";  // trả về view manage-orders.jsp
    }

    // Cập nhật trạng thái đơn hàng
    @PostMapping("/update-order-status")
    public String updateOrderStatus(
            @RequestParam("orderId") Long orderId,
            @RequestParam("newStatus") String newStatus) {

        // Cập nhật trạng thái đơn hàng
//        orderService.updateOrderStatus(orderId, newStatus);

        // Quay lại trang quản lý đơn hàng
        return "redirect:/vendor/manage-orders";
    }
    
}