package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.javaweb.repository.IStoreProductRepository;
import com.javaweb.service.IStoreProductService;
@Service
public class StoreProductServiceImpl implements IStoreProductService {
	@Autowired
	IStoreProductRepository storeProductRepository;

	@Override
	public Long getTotalQuantityByProductId(Long productId) {
		return storeProductRepository.getTotalQuantityByProductId(productId);
	}
}
