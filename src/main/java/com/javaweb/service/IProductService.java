package com.javaweb.service;

import com.javaweb.dto.ProductDTO;
import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface IProductService {

	List<ProductDetailDTO> findLatestProductInThisMonth(Date date);

	List<ProductDetailDTO> findTopSellingProducts(Pageable pageable);

	List<ProductDetailDTO> findTopTotalRatingProducts(Pageable pageable);

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


    List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long categoryId, Boolean isActive);

    Page<ProductEntity> searchProducts(Map<String, String> params, Pageable page);

    Page<ProductEntity> filterProductsByCategoryAndValue(Long id, Map<String, String> params, Pageable page);

    long findMinMaxPriceByCategory(Long categoryId);
    Page<ProductEntity> findByNameContainingIgnoreCase(String name, Pageable pageable);

    List<ProductEntity> findByNameContainingIgnoreCase(String query);
    ProductDTO convertToDTO(ProductEntity entity);

	Long countTotalAvailableQuantityOfProduct(Long id);

    ProductEntity findByIdProductID(Long productId);

	List<ProductDetailDTO> findRelatedProductsByProduct(Long id);
}


