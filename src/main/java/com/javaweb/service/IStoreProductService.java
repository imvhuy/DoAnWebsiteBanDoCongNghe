package com.javaweb.service;


public interface IStoreProductService {
    Long getTotalQuantityByProductId(Long productId);

    Long getTotalSoldByProductId(Long productId);
}
