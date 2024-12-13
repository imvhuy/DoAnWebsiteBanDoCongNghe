package com.javaweb.service.impl;

import com.javaweb.dto.OrderStatisticsDTO;
import com.javaweb.entity.OrderEntity;
import com.javaweb.repository.IOrderRepository;
import com.javaweb.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements IOrderService {
    @Autowired
    private IOrderRepository orderRepository;
    @Override
    public List<OrderEntity> getAllOrders() {
        return orderRepository.findAll();
    }

    // Lọc đơn hàng theo trạng thái
    @Override
    public List<OrderEntity> getOrdersByStatus(String status) {
        return orderRepository.findByStatus(status);
    }

    @Override
    public List<OrderEntity> findAll() {
        return orderRepository.findAll();
    }

    @Override
    public Page<OrderEntity> findAll(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findAll(pageable);
    }

    @Override
    public Page<OrderEntity> findByStatus(String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findByStatus(status, pageable);
    }

    @Override
    public Page<OrderEntity> findByCarrierId(Long carrierId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findByCarrierId(carrierId, pageable);
    }

    // Lấy đơn hàng theo carrierId và trạng thái
    @Override
    public Page<OrderEntity> findByCarrierIdAndStatus(Long carrierId, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findByCarrierIdAndStatusWithDelivery(carrierId, status, pageable);
    }

    @Override
    public void updateStatus(Long orderId, String newStatus) {
        // Tìm đơn hàng dựa trên ID
        OrderEntity order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId));

        // Cập nhật trạng thái mới
        order.setStatus(newStatus);

        // Lưu thay đổi vào cơ sở dữ liệu
        orderRepository.save(order);
    }

    @Override
    public List<OrderStatisticsDTO> getOrderStatistics(Long carrierId) {
        List<Object[]> rawStatistics = orderRepository.countOrdersByStatus(carrierId);
        List<OrderStatisticsDTO> statistics = new ArrayList<>();
        for (Object[] raw : rawStatistics) {
            OrderStatisticsDTO dto = new OrderStatisticsDTO();
            dto.setStatus((String) raw[0]);
            dto.setTotalOrders((Long) raw[1]);
            statistics.add(dto);
        }
        return statistics;
    }

    @Override
    public Double getTotalAmount(Long carrierId) {
        return orderRepository.calculateTotalAmount(carrierId);
    }
    @Override
    public List<OrderStatisticsDTO> getStatisticsByStatus(Long carrierId) {
        List<Object[]> results = orderRepository.countOrdersAndTotalMoneyByStatus(carrierId);
        List<OrderStatisticsDTO> statistics = new ArrayList<>();

        for (Object[] row : results) {
            OrderStatisticsDTO dto = new OrderStatisticsDTO();
            dto.setStatus((String) row[0]);
            dto.setTotalOrders((Long) row[1]);
            dto.setTotalMoney((Double) row[2]);

            statistics.add(dto);
        }

        return statistics;
    }

    @Override
    public Page<OrderEntity> findByCarrierIdAndStatuses(Long carrierId, List<String> statuses, int page, int size) {
        // Tạo Pageable object từ page và size
        Pageable pageable = PageRequest.of(page, size);

        // Gọi repository để lấy dữ liệu
        return orderRepository.findByCarrierIdAndStatuses(carrierId, statuses, pageable);
    }

    @Override
    public Page<OrderEntity> findCompletedOrdersByCarrierId(Long carrierId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findCompletedOrdersByCarrierId(carrierId, pageable);
    }

    @Override
    public Page<OrderEntity> findByCarrierIdStatusAndSearch(Long carrierId, String status, String search, int page, int size) {
        return orderRepository.findByCarrierIdStatusAndSearch(carrierId, status, search, PageRequest.of(page, size));
    }

    @Override
    public Page<OrderEntity> findByCarrierIdStatusesAndSearch(Long carrierId, List<String> statuses, String search, int page, int size) {
        return orderRepository.findByCarrierIdStatusesAndSearch(carrierId, statuses, search, PageRequest.of(page, size));
    }

    @Override
    public Page<OrderEntity> findByCarrierIdAndSearch(Long carrierId, String search, int page, int size) {
        return orderRepository.findByCarrierIdAndSearch(carrierId, search, PageRequest.of(page, size));
    }


}
