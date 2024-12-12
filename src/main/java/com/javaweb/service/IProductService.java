package com.javaweb.service;

import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.model.ProductModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface IProductService {
    void delete(ProductEntity entity);

    Page<ProductEntity> findByCategoryEntity_IdAndIsActive(Long categoryId, boolean IsActive, Pageable pageable);

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

    ProductDTO convertToModel(ProductEntity entity);

    List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long categoryId, Boolean isActive);

    Page<ProductEntity> searchProducts(Map<String, String> params, Pageable page);

    Page<ProductEntity> filterProductsByCategoryAndValue(Long id, Map<String, String> params, Pageable page);

    long findMinMaxPriceByCategory(Long categoryId);

    List<ProductEntity> findByNameContainingIgnoreCase(String query);

    ProductEntity findByIdProductID(Long productId);
}

