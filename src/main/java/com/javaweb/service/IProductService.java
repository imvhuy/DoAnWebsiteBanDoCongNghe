package com.javaweb.service;

import com.javaweb.entity.ProductEntity;

import java.util.List;

public interface IProductService {
    List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long categoryId, Boolean isActive);
}
