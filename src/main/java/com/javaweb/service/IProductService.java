package com.javaweb.service;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Optional;

public interface IProductService {
    void delete(ProductEntity entity);
    void deleteById(Long id);

    long count();

    List<ProductEntity> findAll();

    <S extends ProductEntity> S save(S entity);

    Optional<ProductEntity> findById(Long id);

    List<ProductEntity> findByNameContaining(String productName);
    //tim kiem va phan trang
    Page<ProductEntity> findByNameContaining(String productName, Pageable pageable);

    Page<ProductEntity> findAll(Pageable pageable);
    List<ProductEntity> findAll(Sort sort);

    List<ProductEntity> findAllById(Iterable<Long> id);
    void deleteAll();

}

