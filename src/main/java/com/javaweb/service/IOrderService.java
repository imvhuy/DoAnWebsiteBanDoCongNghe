package com.javaweb.service;

import com.javaweb.dto.MonthlyRevenueDTO;
import com.javaweb.dto.OrderStatisticsDTO;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.ProductEntity;
import org.springframework.data.domain.Page;

import java.util.List;

public interface IOrderService {
    List<OrderEntity> getAllOrders();

    // Lọc đơn hàng theo trạng thái
    List<OrderEntity> getOrdersByStatus(String status);

    List<OrderEntity> findAll();

    Page<OrderEntity> findAll(int page, int size);

    Page<OrderEntity> findByStatus(String status, int page, int size);

    Page<OrderEntity> findByCarrierId(Long carrierId, int page, int size);

    // Lấy đơn hàng theo carrierId và trạng thái
    Page<OrderEntity> findByCarrierIdAndStatus(Long carrierId, String status, int page, int size);

    void updateStatus(Long orderId, String newStatus);

    List<OrderStatisticsDTO> getOrderStatistics(Long carrierId);

    Double getTotalAmount(Long carrierId);

    List<OrderStatisticsDTO> getStatisticsByStatus(Long carrierId);

    Page<OrderEntity> findByCarrierIdAndStatuses(Long carrierId, List<String> statuses, int page, int size);

    Page<OrderEntity> findCompletedOrdersByCarrierId(Long carrierId, int page, int size);

    Page<OrderEntity> findByCarrierIdStatusAndSearch(Long carrierId, String status, String search, int page, int size);

    Page<OrderEntity> findByCarrierIdStatusesAndSearch(Long carrierId, List<String> statuses, String search, int page, int size);

    Page<OrderEntity> findByCarrierIdAndSearch(Long carrierId, String search, int page, int size);

    List<MonthlyRevenueDTO> getMonthlyRevenue();

    Long getInProgressOrdersCount();

    Long getDeliveredOrdersCount();

    Long getPendingOrdersCount();
}
