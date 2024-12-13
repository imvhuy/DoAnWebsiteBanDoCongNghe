package com.javaweb.repository;

import com.javaweb.entity.StoreProductEntity;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IStoreProductRepository extends JpaRepository<StoreProductEntity, Long> {
    @Query("SELECT SUM(sp.quantity) FROM StoreProductEntity sp WHERE sp.product.id = :productId")
    Long getTotalQuantityByProductId(@Param("productId") Long productId);

    @Query("SELECT SUM(sp.sold) FROM StoreProductEntity sp WHERE sp.product.id = :productId")
    Long getTotalSoldByProductId(@Param("productId") Long productId);  // Phương thức tính tổng số sản phẩm đã bán

    List<StoreProductEntity> findByStoreId(Long storeId);

    // Lấy thông tin sản phẩm trong cửa hàng theo ID
    Optional<StoreProductEntity> findByStoreIdAndProductId(Long storeId, Long productId);

    Page<StoreProductEntity> findByStoreIdAndProduct_NameContaining(Long storeId, String name, Pageable pageable);

    Page<StoreProductEntity> findByStoreId(Long storeId, Pageable pageable);

//	 @Query("SELECT p FROM ProductEntity p WHERE p.id IN (SELECT sp.product.id FROM StoreProductEntity sp WHERE sp.store.id = :storeId)")
//	    Page<ProductEntity> findProductsByStore(@Param("storeId") Long storeId, Pageable pageable);

}
