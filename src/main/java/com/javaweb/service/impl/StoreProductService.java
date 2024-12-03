package com.javaweb.service.impl;

import com.javaweb.repository.IStoreProductRepository;
import com.javaweb.service.IStoreProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreProductService implements IStoreProductService {
    @Autowired
    private IStoreProductRepository storeProductRepository;

    @Override
    public Long getTotalQuantityByProductId(Long productId) {
        return storeProductRepository.getTotalQuantityByProductId(productId);
    }

    @Override
    public Long getTotalSoldByProductId(Long productId) {
        return storeProductRepository.getTotalSoldByProductId(productId);
    }
}
