package com.javaweb.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.javaweb.entity.*;

public interface IStoreProductService {

	public Page<StoreProductEntity> findByStoreIdAndProductName(Long storeId, String name, Pageable pageable);
	public Page<StoreProductEntity> findByStoreId(Long storeId, Pageable pageable);
	public List<ProductEntity> getProductsByStore(Long storeId);
//	public Page<ProductEntity> findProductsByStoreAndPage(Long storeId, Pageable pageable);
	public StoreProductEntity findById(Long storeproductID);

    Long getTotalQuantityByProductId(Long productId);

    Long getTotalSoldByProductId(Long productId);
    
    public void save(StoreProductEntity storeProduct);
}
