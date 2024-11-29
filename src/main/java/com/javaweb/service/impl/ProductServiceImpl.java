package com.javaweb.service.impl;

import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements IProductService {

    @Autowired
    IProductRepository productRepository;

    @Override
    public List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long categoryId, Boolean isActive) {
        return productRepository.findAllByCategoryEntity_IdAndIsActive(categoryId, isActive);
    }


}
