package com.javaweb.service;

import com.javaweb.entity.UserEntity;
import com.javaweb.dto.MonthRevenuesDTO;
import com.javaweb.dto.MonthlyRevenueDTO;
import com.javaweb.dto.OrderStatisticsDTO;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.ProductEntity;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

public interface IOrderService {
    OrderEntity createOrder(OrderEntity order);

    List<OrderEntity> getAllOrders();

    // Lọc đơn hàng theo trạng thái
    List<OrderEntity> getOrdersByStatus(String status);

    List<OrderEntity> findAll();

    Page<OrderEntity> findAll(int page, int size);

    Page<OrderEntity> findByStatus(String status, Pageable pageable);

    Page<OrderEntity> findByCarrierId(Long carrierId, int page, int size);

	Boolean createOrderForStore(UserEntity user, Long userAddressId);
    // Lấy đơn hàng theo carrierId và trạng thái
    Page<OrderEntity> findByCarrierIdAndStatus(Long shipperId, String status, int page, int size);

	void createOrders(Long userId,Long carrierId,Long address,String method,Long voucherId);
    void updateStatus(Long orderId, String newStatus);

    List<OrderStatisticsDTO> getOrderStatistics(Long carrierId);

    Double getTotalAmount(Long carrierId);

    List<OrderStatisticsDTO> getStatisticsByStatus(Long carrierId);

    Page<OrderEntity> findByCarrierIdAndStatuses(Long shipperId, List<String> statuses, int page, int size);

	//vũ làm nha a Thao iu
	 List<OrderEntity> findOrdersByUsername(String username);

    Page<OrderEntity> findCompletedOrdersByCarrierId(Long shipperId, int page, int size);
	Page<OrderEntity> findOrdersByUsername(String username, Pageable pageable);

    Page<OrderEntity> findByCarrierIdStatusAndSearch(Long shipperId, String status, String search, int page, int size);

    Page<OrderEntity> findByCarrierIdStatusesAndSearch(Long carrierId, List<String> statuses, String search, int page, int size);

    Page<OrderEntity> findByCarrierIdAndSearch(Long shipperId, String search, int page, int size);

    List<MonthlyRevenueDTO> getMonthlyRevenue(Long shipperId);

    Long getInProgressOrdersCount(Long shipperId);

    Long getDeliveredOrdersCount(Long shipperId);

    Long getPendingOrdersCount(Long shipperId);

    List<Object[]> findOrdersByCarrierAndStatuses(Long carrierId, List<String> statuses);

    OrderEntity findLatestOrderByCarrierId(Long carrierId);

    Optional<OrderEntity> findById(Long orderId);

    Page<OrderEntity> getOrdersByIdAndStatus(Long id, String status, int page, int size);

    Page<OrderEntity> findAll(Pageable pageable);

    Page<OrderEntity> findByIdStatusAndSearch(Long id, String status, String search, Pageable pageable);

    Page<OrderEntity> findByIdAndStatus(Long id, String status, Pageable pageable);

    Page<OrderEntity> findByStatusAndSearch(String status, String search, Pageable pageable);

    Page<OrderEntity> findBySearch(String search, Pageable pageable);

	List <MonthRevenuesDTO> getMonthRevenuesByStoreId(Long storeId,int year);

	List<Object[]> getTotalMonthlyOrdersByStoreId(Long storeId, int year);
}
