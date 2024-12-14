package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.javaweb.entity.*;

public interface IStoreProductService {

	Page<StoreProductEntity> findByStoreIdAndProductName(Long storeId, String name, Pageable pageable);
	Page<StoreProductEntity> findByStoreId(Long storeId, Pageable pageable);
	List<ProductEntity> getProductsByStore(Long storeId);
//	public Page<ProductEntity> findProductsByStoreAndPage(Long storeId, Pageable pageable);
	StoreProductEntity findById(Long storeproductID);

	Page<StoreProductEntity> findByStoreIdAndProductNameAndCategoryId(Long storeId, String productName, Long categoryId, Pageable pageable);

	Page<StoreProductEntity> findByStoreIdAndCategoryId(Long storeId, Long categoryId, Pageable pageable);

	Optional<StoreProductEntity> findByStoreIdAndProductId(Long storeId, Long productId);
    Long getTotalQuantityByProductId(Long productId);

    Long getTotalSoldByProductId(Long productId);

	void save(StoreProductEntity storeProduct);

	void removeProductFromStore(Long storeId, Long productId);

	List<StoreEntity> findStoresByProductIdAndQuantity(Long productId, Long quantity);
	void updateQuantityAfterUserPlaceOrderItem(Long storeId, Long productId, Long quantity);
}
