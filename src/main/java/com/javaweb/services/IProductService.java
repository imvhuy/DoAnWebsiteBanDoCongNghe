package com.javaweb.services;

import com.javaweb.entity.ProductEntity;

import java.util.List;

public interface IProductService {
    List<ProductEntity> getAllProducts();

    ProductEntity getProductById(Long id);

    ProductEntity saveProduct(ProductEntity product);

    void deleteProduct(Long id);

}
