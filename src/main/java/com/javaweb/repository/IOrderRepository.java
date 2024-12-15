package com.javaweb.repository;

import com.javaweb.dto.MonthRevenuesDTO;
import com.javaweb.entity.OrderEntity;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import com.javaweb.entity.OrderEntity;

@Repository
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
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = :status")
    Page<OrderEntity> findByCarrierIdAndStatusWithDelivery(@Param("shipperId") Long shipperId,
                                                           @Param("status") String status,
                                                           Pageable pageable);

    @Query("SELECT o.status, COUNT(o.id) AS totalOrders " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND s.orderId = o.id " +
            "GROUP BY o.status")
    List<Object[]> countOrdersByStatus(@Param("shipperId") Long shipperId);


    @Query("SELECT SUM(o.amountToGD) " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = 'Đã vận chuyển' AND s.orderId = o.id")
    Double calculateTotalAmount(@Param("shipperId") Long shipperId);


    @Query("SELECT o FROM OrderEntity o WHERE o.user.username = :username")
    List<OrderEntity> findByUsername(String username);


    Page<OrderEntity> findByUser_Username(String username, Pageable pageable);

    @Query("SELECT o.status, COUNT(o.id) AS totalOrders, SUM(o.amountToGD) AS totalMoney " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND s.orderId = o.id " +
            "GROUP BY o.status")
    List<Object[]> countOrdersAndTotalMoneyByStatus(@Param("shipperId") Long shipperId);

    @Query("SELECT o FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId  AND o.status IN :statuses")
    Page<OrderEntity> findByCarrierIdAndStatuses(@Param("shipperId") Long shipperId,
                                                 @Param("statuses") List<String> statuses,
                                                 Pageable pageable);

    @Query("SELECT o FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = 'đã vận chuyển'")
    Page<OrderEntity> findCompletedOrdersByCarrierId(@Param("shipperId") Long shipperId, Pageable pageable);


    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId  " +
            "AND o.status = :status " +
            "AND (LOWER(o.address) LIKE LOWER(CONCAT('%', :search, '%')) " +
            "OR LOWER(o.user.fullName) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<OrderEntity> findByCarrierIdStatusAndSearch(@Param("shipperId") Long shipperId,
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
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId " +
            "AND (LOWER(o.address) LIKE LOWER(CONCAT('%', :search, '%')) " +
            "OR LOWER(o.user.fullName) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<OrderEntity> findByCarrierIdAndSearch(@Param("shipperId") Long shipperId,
                                               @Param("search") String search,
                                               Pageable pageable);

    @Query("SELECT MONTH(o.modifiedDate) AS month, YEAR(o.modifiedDate) AS year, SUM(o.amountToGD) AS totalRevenue " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = 'đã vận chuyển' AND s.orderId = o.id  " +
            "GROUP BY YEAR(o.modifiedDate), MONTH(o.modifiedDate) " +
            "ORDER BY YEAR(o.modifiedDate), MONTH(o.modifiedDate)")
    List<Object[]> calculateMonthlyRevenue(@Param("shipperId") Long shipperId);

    @Query("SELECT COUNT(o) FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = 'đang vận chuyển' AND s.orderId = o.id ")
    Long countInProgressOrders(@Param("shipperId") Long shipperId);

    @Query("SELECT COUNT(o) FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = 'đã vận chuyển' AND s.orderId = o.id ")
    Long countDeliveredOrders(@Param("shipperId") Long shipperId);

    @Query("SELECT COUNT(o) FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId AND o.status = 'chờ vận chuyển' AND s.orderId = o.id ")
    Long countPendingOrders(@Param("shipperId") Long shipperId);


    @Query("SELECT o.id, o.address, o.status " +
            "FROM OrderEntity o " +
            "JOIN DeliveryEntity d ON o.id = d.order.id " +
            "WHERE d.carrier.id = :carrierId AND o.status IN :statuses")
    List<Object[]> findOrdersByCarrierAndStatuses(@Param("carrierId") Long carrierId, @Param("statuses") List<String> statuses);

    @Query("SELECT o FROM OrderEntity o JOIN DeliveryEntity d ON o.id = d.order.id " +
            "JOIN ShipperCarrierEntity s ON s.carrier.id = d.carrier.id " +
            "WHERE s.user.id = :shipperId ORDER BY o.createdDate DESC LIMIT 1")
    OrderEntity findLatestOrderByCarrierId(@Param("shipperId") Long shipperId);

    @Query("SELECT o FROM OrderEntity o " +
            "WHERE o.id = :id AND o.status = :status AND " +
            "(o.user.fullName LIKE %:search%)")
    Page<OrderEntity> findByIdStatusAndSearch(@Param("id") Long id, @Param("status") String status,
                                              @Param("search") String search, Pageable pageable);

    @Query("SELECT o FROM OrderEntity o " +
            "WHERE o.id = :id AND o.status = :status")
    Page<OrderEntity> findByIdAndStatus(@Param("id") Long id, @Param("status") String status, Pageable pageable);

    @Query("SELECT  new com.javaweb.dto.MonthRevenuesDTO(MONTH(o.modifiedDate),SUM(o.amountFromUser)) " +
            "FROM OrderEntity o " +
            "WHERE o.storeId = :storeId AND o.status = 'đã vận chuyển' AND YEAR(o.modifiedDate) = :year " +
            "GROUP BY YEAR(o.modifiedDate), MONTH(o.modifiedDate) ")
    List<MonthRevenuesDTO> getMonthRevenuesByStoreId(@Param("storeId") Long storeId, @Param("year") int year);

    @Query("SELECT  MONTH(o.modifiedDate),COUNT(o.id) " +
            "FROM OrderEntity o " +
            "WHERE o.storeId = :storeId AND o.status = 'đã vận chuyển' AND YEAR(o.modifiedDate) = :year " +
            "GROUP BY YEAR(o.modifiedDate), MONTH(o.modifiedDate) ")
    List<Object[]> getTotalMonthlyOrdersByStoreId(@Param("storeId") Long storeId, @Param("year") int year);

    @Query("SELECT o FROM OrderEntity o " +
            "WHERE o.status = :status AND " +
            "(o.user.fullName LIKE %:search%)")
    Page<OrderEntity> findByStatusAndSearch(@Param("status") String status, @Param("search") String search,
                                            Pageable pageable);

    @Query("SELECT o FROM OrderEntity o " +
            "WHERE o.user.fullName LIKE %:search%")
    Page<OrderEntity> findBySearch(@Param("search") String search, Pageable pageable);


}