package com.javaweb.repository;

import com.javaweb.entity.StoreEntity;
import com.javaweb.entity.StoreProductEntity;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IStoreProductRepository extends JpaRepository<StoreProductEntity, Long> {
    @Query("SELECT SUM(sp.quantity) FROM StoreProductEntity sp WHERE sp.product.id = :productId")
    Long getTotalQuantityByProductId(@Param("productId") Long productId);

    @Query("SELECT SUM(sp.sold) FROM StoreProductEntity sp WHERE sp.product.id = :productId")
    Long getTotalSoldByProductId(@Param("productId") Long productId);  // Phương thức tính tổng số sản phẩm đã bán
    
	public Page<StoreProductEntity> findByStoreIdAndProduct_NameContaining(Long storeId, String name, Pageable pageable);

	public Page<StoreProductEntity> findByStoreId(Long storeId, Pageable pageable);
	
	public List<StoreProductEntity> findByStoreId(Long storeId);
	
//	 @Query("SELECT p FROM ProductEntity p WHERE p.id IN (SELECT sp.product.id FROM StoreProductEntity sp WHERE sp.store.id = :storeId)")
//	    Page<ProductEntity> findProductsByStore(@Param("storeId") Long storeId, Pageable pageable);
	@Query("SELECT s FROM StoreProductEntity sp JOIN sp.store s WHERE sp.product.id = :productId AND  sp.quantity >= :quantity")
	public List<StoreEntity> findStoresByProductIdAndQuantity(@Param("productId") Long productId, @Param("quantity") Long quantity) ;
	
	@Modifying
	@Query("UPDATE StoreProductEntity sp SET sp.quantity = sp.quantity - :quantity , sp.sold = COALESCE(sp.sold, 0) + :quantity WHERE  sp.product.id = :productId AND sp.store.id = :storeId")
	public void updateQuantityAfterUserPlaceOrderItem( @Param("storeId") Long storeId,@Param("productId") Long productId, @Param("quantity") Long quantity);



} 