package com.javaweb.controller.shipper;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.dto.OrderStatisticsDTO;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.ShipperCarrierEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.IOrderService;
import com.javaweb.service.IShipperCarrierService;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.ShipperCarrierServiceImpl;
import com.javaweb.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller("StatisticsController")
@RequestMapping(value ="/shipper/statistics")
public class StatisticsController {
    @Autowired
    private IOrderService orderStatisticsService;
    @Autowired
    private IShipperCarrierService shipperCarrierServiceImpl;
    @Autowired
    private IUserService userServiceImpl;

    @RequestMapping( method = RequestMethod.GET)
    public String getStatistics(@AuthenticationPrincipal UserEntity currentUser, Model model) {
        // Lấy carrierId từ shipper đăng nhập
        Long carrierId = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            UserInfoUserDetails userDetails = (UserInfoUserDetails) authentication.getPrincipal();
            String owner = userDetails.getUsername();
            UserDTO userDTO = userServiceImpl.findByUserName(owner);
            ShipperCarrierEntity shipperCarrier = shipperCarrierServiceImpl.getShipperByUserId(userDTO.getId());
            if (shipperCarrier == null) {
                throw new RuntimeException("Shipper này chưa được liên kết với bất kỳ Carrier nào.");
            }
            carrierId = shipperCarrier.getCarrier().getId();
        }

        // Lấy thống kê
        List<OrderStatisticsDTO> statistics = orderStatisticsService.getOrderStatistics(carrierId);
        Double totalAmount = orderStatisticsService.getTotalAmount(carrierId);
        List<OrderStatisticsDTO> statistics2 = orderStatisticsService.getStatisticsByStatus(carrierId);

        // Truyền dữ liệu vào model
        model.addAttribute("statistics2", statistics2);
        model.addAttribute("statistics", statistics);
        model.addAttribute("totalAmount", totalAmount);
        return "shipper/statistics/statistics";
    }
}
