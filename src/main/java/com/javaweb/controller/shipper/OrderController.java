package com.javaweb.controller.shipper;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.*;
import com.javaweb.service.IOrderService;
import com.javaweb.service.IShipperCarrierService;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller("OrderShipperController")
@RequestMapping(value ="/shipper/orders")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @Autowired
    private IShipperCarrierService shipperCarrierService;
    @Autowired
    private IUserService userService;
    @Autowired
    private TransactionServiceImpl transactionServiceImpl;

    @GetMapping
    public ModelAndView list(
            @AuthenticationPrincipal UserEntity currentUser, // Lấy thông tin user đăng nhập
            ModelMap model,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        UserDTO userDTO = null;
        // Lấy Carrier của shipper đăng nhập
        Long carrierId = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            userDTO = userService.findByUserName(owner);
            ShipperCarrierEntity shipperCarrier = shipperCarrierService.getShipperByUserId(userDTO.getId());
            if (shipperCarrier == null) {
                throw new RuntimeException("Shipper này chưa được liên kết với bất kỳ Carrier nào.");
            }
            carrierId = shipperCarrier.getCarrier().getId();
        }


        // Chuyển đổi trạng thái không dấu thành có dấu
        String convertedStatus = null;
        if (status != null) {
            switch (status) {
                case "ChoVanChuyen":
                    convertedStatus = "Chờ vận chuyển";
                    break;
                case "DangVanChuyen":
                    convertedStatus = "Đang vận chuyển";
                    break;
                default:
                    convertedStatus = null;
            }
        }

        // Gọi service để lấy danh sách đơn hàng dựa trên carrier của shipper
        Page<OrderEntity> orderPage;
        if (convertedStatus != null && search != null && !search.isEmpty()) {
            // Lọc theo trạng thái và từ khóa tìm kiếm
            orderPage = orderService.findByCarrierIdStatusAndSearch(userDTO.getId(), convertedStatus, search, page, size);
        } else if (convertedStatus != null) {
            // Lọc theo trạng thái
            orderPage = orderService.findByCarrierIdAndStatus(userDTO.getId(), convertedStatus, page, size);
        } else if (search != null && !search.isEmpty()) {
            // Lọc theo từ khóa tìm kiếm
            orderPage = orderService.findByCarrierIdAndSearch(userDTO.getId(), search, page, size);
        } else {
            // Lọc theo trạng thái mặc định
            orderPage = orderService.findByCarrierIdAndStatuses(userDTO.getId(), List.of("đang vận chuyển", "chờ vận chuyển"), page, size);
        }


        // Thêm thông tin vào model
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("status", status);

        return new ModelAndView("shipper/orders/orderList", model);
    }
    @PostMapping("/updateStatus")
    public String updateOrderStatus(
            @RequestParam("orderId") Long orderId,
            @RequestParam("newStatus") String newStatus,
            RedirectAttributes redirectAttributes) {
        try {
            // Cập nhật trạng thái của đơn hàng
            orderService.updateStatus(orderId, newStatus);

            if ("đã vận chuyển".equals(newStatus)) {
                // Lấy đối tượng OrderEntity từ orderId
                Optional<OrderEntity> order = orderService.findById(orderId);

                // Kiểm tra nếu order tồn tại
                if (order != null) {
                    // Lấy transaction liên quan đến đơn hàng
                    TransactionEntity transaction = transactionServiceImpl.findByOrder(order);

                    // Kiểm tra nếu transaction tồn tại
                    if (transaction != null) {
                        // Cập nhật isPaid thành true
                        transaction.setIsPaid(true);

                        // Lưu lại transaction đã cập nhật
                        transactionServiceImpl.save(transaction);
                    } else {
                        throw new RuntimeException("Không tìm thấy giao dịch cho đơn hàng này.");
                    }
                } else {
                    throw new RuntimeException("Không tìm thấy đơn hàng.");
                }
            }

            // Thêm thông báo thành công vào flash attributes
            redirectAttributes.addFlashAttribute("message", "Trạng thái đã được cập nhật thành công!");
        } catch (Exception e) {
            // Thêm thông báo lỗi vào flash attributes
            redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái thất bại: " + e.getMessage());
        }

        // Chuyển hướng về trang đơn hàng
        return "redirect:/shipper/orders";
    }


    @GetMapping("/completed")
    public ModelAndView completedOrders(
            @AuthenticationPrincipal UserEntity currentUser,
            ModelMap model,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {

        Long carrierId = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            UserDTO userDTO = userService.findByUserName(owner);
            ShipperCarrierEntity shipperCarrier = shipperCarrierService.getShipperByUserId(userDTO.getId());
            if (shipperCarrier == null) {
                throw new RuntimeException("Shipper này chưa được liên kết với bất kỳ Carrier nào.");
            }
            carrierId = shipperCarrier.getCarrier().getId();
        }

        // Gọi service để lấy danh sách đơn hàng đã vận chuyển
        Page<OrderEntity> orderPage = orderService.findCompletedOrdersByCarrierId(carrierId, page, size);

        // Thêm dữ liệu vào model
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());

        return new ModelAndView("shipper/orders/completedOrderList", model);
    }




}
