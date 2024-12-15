package com.javaweb.controller.vendor;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.service.IOrderService;

import java.util.Arrays;
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
        @RequestParam(value = "id", required = false) Long id,
        @RequestParam(value = "status", required = false) String status,
        @RequestParam(value = "search", required = false) String search,
        @RequestParam(value = "page", defaultValue = "0") int page,
        @RequestParam(value = "size", defaultValue = "10") int size,
        Model model) {

    Pageable pageable = PageRequest.of(page, size);
    Page<OrderEntity> orderPage;

    // Convert status if needed
    String convertedStatus = null;
    if (status != null) {
        switch (status) {
            case "ChoVanChuyen":
                convertedStatus = "Chờ vận chuyển";
                break;
            case "DangVanChuyen":
                convertedStatus = "Đang vận chuyển";
                break;
            case "DaVanChuyen":
                convertedStatus = "Đã vận chuyển";
                break;
            default:
                convertedStatus = null;
        }
    }

    // Query logic
    if (id != null && convertedStatus != null && search != null && !search.isEmpty()) {
        // Filter by ID, status, and search (name)
        orderPage = orderService.findByIdStatusAndSearch(id, convertedStatus, search, pageable);
    } else if (id != null && convertedStatus != null) {
        // Filter by ID and status
        orderPage = orderService.findByIdAndStatus(id, convertedStatus, pageable);
    } else if (id != null) {
        // Filter by ID only
        Optional<OrderEntity> order = orderService.findById(id);
        if (order.isPresent()) {
            model.addAttribute("orders", List.of(order.get()));
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", 1);
            model.addAttribute("statusList", Arrays.asList("Đang vận chuyển", "Đã vận chuyển", "Chờ vận chuyển"));
            return "vendor/manage-order";
        } else {
            model.addAttribute("message", "Không tìm thấy đơn hàng.");
            return "vendor/manage-order";
        }
    } else if (convertedStatus != null && search != null && !search.isEmpty()) {
        // Filter by status and search (name)
        orderPage = orderService.findByStatusAndSearch(convertedStatus, search, pageable);
    } else if (convertedStatus != null) {
        // Filter by status
        orderPage = orderService.findByStatus(convertedStatus, pageable);
    } else if (search != null && !search.isEmpty()) {
        // Filter by search (name)
        orderPage = orderService.findBySearch(search, pageable);
    } else {
        // Default case: return all orders
        orderPage = orderService.findAll(pageable);
    }

    // Add attributes to the model
    model.addAttribute("orders", orderPage.getContent());
    model.addAttribute("currentPage", page);
    model.addAttribute("totalPages", orderPage.getTotalPages());
    model.addAttribute("statusList", Arrays.asList("Đang vận chuyển", "Đã vận chuyển", "Chờ vận chuyển"));
    return "vendor/manage-order"; // Return the JSP file
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