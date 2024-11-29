package com.javaweb.repository;

import com.javaweb.entity.StoreProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface StoreProductRepository extends JpaRepository<StoreProductEntity, Long> {
    @Query("SELECT SUM(sp.quantity) FROM StoreProductEntity sp WHERE sp.product.id = :productId")
    Long getTotalQuantityByProductId(@Param("productId") Long productId);
} 