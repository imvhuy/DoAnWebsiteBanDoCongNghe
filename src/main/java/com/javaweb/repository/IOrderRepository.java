package com.javaweb.repository;

import com.javaweb.entity.OrderEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IOrderRepository extends JpaRepository<OrderEntity, Long> {
    List<OrderEntity> findByStatus(String status);
    Page<OrderEntity> findByStatus(String status, Pageable pageable);

    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId")
    Page<OrderEntity> findByCarrierId(@Param("carrierId") Long carrierId, Pageable pageable);

    // Lấy đơn hàng theo carrierId và trạng thái
    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId AND o.status = :status")
    Page<OrderEntity> findByCarrierIdAndStatus(@Param("carrierId") Long carrierId,
                                               @Param("status") String status,
                                               Pageable pageable);

    @Query("SELECT o FROM OrderEntity o LEFT JOIN FETCH o.delivery d " +
            "WHERE d.carrier.id = :carrierId AND o.status = :status")
    Page<OrderEntity> findByCarrierIdAndStatusWithDelivery(@Param("carrierId") Long carrierId,
                                                           @Param("status") String status,
                                                           Pageable pageable);

    @Query("SELECT o.status, COUNT(o.id) AS totalOrders " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId " +
            "GROUP BY o.status")
    List<Object[]> countOrdersByStatus(@Param("carrierId") Long carrierId);


    @Query("SELECT SUM(o.amountToGD) " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId AND o.status = 'Đã vận chuyển'")
    Double calculateTotalAmount(@Param("carrierId") Long carrierId);


    @Query("SELECT o.status, COUNT(o.id) AS totalOrders, SUM(o.amountToGD) AS totalMoney " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId " +
            "GROUP BY o.status")
    List<Object[]> countOrdersAndTotalMoneyByStatus(@Param("carrierId") Long carrierId);

    @Query("SELECT o FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId AND o.status IN :statuses")
    Page<OrderEntity> findByCarrierIdAndStatuses(@Param("carrierId") Long carrierId,
                                                 @Param("statuses") List<String> statuses,
                                                 Pageable pageable);

    @Query("SELECT o FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId AND o.status = 'đã vận chuyển'")
    Page<OrderEntity> findCompletedOrdersByCarrierId(@Param("carrierId") Long carrierId, Pageable pageable);


    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId " +
            "AND o.status = :status " +
            "AND (LOWER(o.address) LIKE LOWER(CONCAT('%', :search, '%')) " +
            "OR LOWER(o.user.fullName) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<OrderEntity> findByCarrierIdStatusAndSearch(@Param("carrierId") Long carrierId,
                                                     @Param("status") String status,
                                                     @Param("search") String search,
                                                     Pageable pageable);

    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId " +
            "AND o.status IN :statuses " +
            "AND (LOWER(o.address) LIKE LOWER(CONCAT('%', :search, '%')) " +
            "OR LOWER(o.user.fullName) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<OrderEntity> findByCarrierIdStatusesAndSearch(@Param("carrierId") Long carrierId,
                                                       @Param("statuses") List<String> statuses,
                                                       @Param("search") String search,
                                                       Pageable pageable);

    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId " +
            "AND (LOWER(o.address) LIKE LOWER(CONCAT('%', :search, '%')) " +
            "OR LOWER(o.user.fullName) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<OrderEntity> findByCarrierIdAndSearch(@Param("carrierId") Long carrierId,
                                               @Param("search") String search,
                                               Pageable pageable);

    @Query("SELECT MONTH(o.modifiedDate) AS month, YEAR(o.modifiedDate) AS year, SUM(o.amountToGD) AS totalRevenue " +
            "FROM OrderEntity o " +
            "WHERE o.status = 'đã vận chuyển' " +
            "GROUP BY YEAR(o.modifiedDate), MONTH(o.modifiedDate) " +
            "ORDER BY YEAR(o.modifiedDate), MONTH(o.modifiedDate)")
    List<Object[]> calculateMonthlyRevenue();

    @Query("SELECT COUNT(o) FROM OrderEntity o WHERE o.status = 'đang vận chuyển'")
    Long countInProgressOrders();

    @Query("SELECT COUNT(o) FROM OrderEntity o WHERE o.status = 'đã vận chuyển'")
    Long countDeliveredOrders();

    @Query("SELECT COUNT(o) FROM OrderEntity o WHERE o.status = 'chờ vận chuyển'")
    Long countPendingOrders();

    @Query("SELECT o.id, o.address, o.status " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId AND o.status IN :statuses")
    List<Object[]> findOrdersByCarrierAndStatuses(@Param("carrierId") Long carrierId, @Param("statuses") List<String> statuses);

    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId ORDER BY o.createdDate DESC LIMIT 1")
    OrderEntity findLatestOrderByCarrierId(@Param("carrierId") Long carrierId);


}
