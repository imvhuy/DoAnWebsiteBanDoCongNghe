package com.javaweb.controller.shipper;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.NotificationEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.ShipperCarrierEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.IOrderService;
import com.javaweb.service.IShipperCarrierService;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.NotificationServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/shipper")
public class ShipperController {
    @Autowired
    private IOrderService orderService;
    @Autowired
    private NotificationServiceImpl notificationServiceImpl;
    @Autowired
    private IUserService userService;
    @Autowired
    private IShipperCarrierService shipperCarrierService;

    @GetMapping(value = "/home")
    public String home(Model model) {
        // Lấy dữ liệu từ service
        Long carrierId = null;
        // Lấy carrierId từ thông tin đăng nhập
        UserDTO userDTO= null;
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
        Long inProgressCount = orderService.getInProgressOrdersCount(userDTO.getId());
        Long deliveredCount = orderService.getDeliveredOrdersCount(userDTO.getId());
        Long pendingCount = orderService.getPendingOrdersCount(userDTO.getId());

        // Thêm dữ liệu vào model để gửi sang JSP
        model.addAttribute("inProgressCount", inProgressCount);
        model.addAttribute("deliveredCount", deliveredCount);
        model.addAttribute("pendingCount", pendingCount);

        return "shipper/home"; // Tên file JSP
    }

    @GetMapping("/notifications")
    @ResponseBody
    public List<Map<String, String>> getPendingAndInProgressOrders() {
        Long carrierId = null;

        // Lấy carrierId từ thông tin đăng nhập của shipper
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

        // Lấy danh sách đơn hàng chờ vận chuyển và đang vận chuyển
        List<Object[]> orders = orderService.findOrdersByCarrierAndStatuses(
                carrierId,
                List.of("đang vận chuyển", "chờ vận chuyển")
        );

        // Chuyển đổi danh sách Object[] thành danh sách Map để gửi về client
        List<Map<String, String>> notifications = new ArrayList<>();
        for (Object[] order : orders) {
            Map<String, String> notification = new HashMap<>();
            notification.put("orderId", order[0].toString());
            notification.put("address", order[1].toString());
            notification.put("status", order[2].toString());
            notifications.add(notification);
        }
        return notifications;
    }

    @GetMapping("/latest-order")
    @ResponseBody
    public Map<String, String> getLatestOrder() {
        Long carrierId = null;
        // Lấy carrierId từ thông tin đăng nhập
        UserDTO userDTO= null;
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

        // Lấy order gần nhất
        OrderEntity latestOrder = orderService.findLatestOrderByCarrierId(userDTO.getId());

        // Chuẩn bị dữ liệu trả về
        Map<String, String> response = new HashMap<>();
        response.put("address", latestOrder.getAddress());
        response.put("status", latestOrder.getStatus());
        response.put("createdDate", latestOrder.getCreatedDate().toString());
        return response;
    }


}
