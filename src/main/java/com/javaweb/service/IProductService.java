package com.javaweb.service;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;

import com.javaweb.dto.ProductDTO;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.model.ProductModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Optional;

public interface IProductService {

	List<ProductDTO> findLatestProductInThisMonth(Date date);

	List<ProductDTO> findTopSellingProducts(Pageable pageable);

	List<ProductDTO> findTopTotalRatingProducts(Pageable pageable);

    void delete(ProductEntity entity);
    void deleteById(Long id);

    long count();

    List<ProductEntity> findAll();

    ProductEntity getProductById(Long id);

    <S extends ProductEntity> S save(S entity);

    Optional<ProductEntity> findById(Long id);

    List<ProductEntity> findByNameContaining(String Name);
    //tim kiem va phan trang
    Page<ProductEntity> findByNameContaining(String Name, Pageable pageable);

    Page<ProductEntity> findAll(Pageable pageable);
    List<ProductEntity> findAll(Sort sort);

    List<ProductEntity> findAllById(Iterable<Long> id);
    void deleteAll();

    List<GalleryEntity> getGalleryByProductId(Long id);

    ProductModel convertToModel(ProductEntity entity);

}


