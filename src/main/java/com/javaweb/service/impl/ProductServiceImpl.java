package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.ProductRepository;
import com.javaweb.service.IProductService;
@Service
public class ProductServiceImpl implements IProductService {

    @Autowired
    private ProductRepository productRepository;

    public ProductEntity getProductById(Long productID) {
        return productRepository.findById(productID).orElse(null); // Nếu không tìm thấy, trả về null
    }
}
