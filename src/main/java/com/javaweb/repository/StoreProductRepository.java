package com.javaweb.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.StoreProductEntity;
@Repository
public interface StoreProductRepository extends JpaRepository<StoreProductEntity, Long> {

	public Page<StoreProductEntity> findByStoreIdAndProduct_ProductNameContaining(Long storeId, String productName, Pageable pageable);

	public Page<StoreProductEntity> findByStoreId(Long storeId, Pageable pageable);
	
	public List<StoreProductEntity> findByStoreId(Long storeId);
	
//	 @Query("SELECT p FROM ProductEntity p WHERE p.id IN (SELECT sp.product.id FROM StoreProductEntity sp WHERE sp.store.id = :storeId)")
//	    Page<ProductEntity> findProductsByStore(@Param("storeId") Long storeId, Pageable pageable);


}
