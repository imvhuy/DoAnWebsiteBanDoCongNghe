package com.javaweb.repository;

import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.SubcategoryValueEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.entity.ProductEntity;

import java.util.Date;
import java.util.List;

@Repository
public interface IProductRepository extends JpaRepository<ProductEntity, Long> {
    @Query("SELECT new com.javaweb.dto.ProductDetailDTO(p.id, p.name, p.price, g.image) " +
            "FROM ProductEntity p " +
            "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
            "WHERE g.type = 'front' " +
            "AND MONTH(g.createdDate) = MONTH(:date) " +
            "AND YEAR(g.createdDate) = YEAR(:date)")
    List<ProductDetailDTO> findLatestProductInThisMonth(@Param("date") Date date);

    @Query("SELECT new com.javaweb.dto.ProductDetailDTO(" +
            "p.id, p.name, p.price, g.image, SUM(oi.count)) " +
            "FROM OrderItemEntity oi " +
            "JOIN oi.product p " +
            "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
            "WHERE g.type = 'front' " +
            "GROUP BY p.id, p.name, p.price, g.image " +
            "ORDER BY SUM(oi.count) DESC")
    List<ProductDetailDTO> findTopSellingProducts(Pageable pageable);

    // Truy vấn tính tổng đánh giá của từng sản phẩm
    @Query("SELECT  new com.javaweb.dto.ProductDetailDTO(p.id , p.name, AVG(r.rating), g.image, p.price) " +
            "FROM ProductEntity p " +
            "LEFT JOIN ReviewEntity r ON r.product = p " +
            "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
            "WHERE g.type = 'front' " +
            "GROUP BY p.id, p.name, p.price, g.image " +
            "ORDER BY AVG(r.rating) DESC")
    List<ProductDetailDTO> findTopTotalRatingProducts(Pageable pageable);

    // Truy vấn tính tổng số lượng của từng sản phẩm
    @Query("SELECT  MAX(ps.quantity) " +
            "FROM ProductEntity p " +
            "JOIN p.productStore ps " +
            "WHERE p.id = :id")
    Long countTotalAvailableQuantityOfProduct(@Param("id") Long id);

    List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long id, Boolean isActive);

    Page<ProductEntity> findByNameContaining(String name, Pageable pageable);

    List<ProductEntity> findByNameContaining(String name);

    Page<ProductEntity> findAll(Pageable pageable);

    List<ProductEntity> findAll(Sort sort);

    List<ProductEntity> findAllById(Iterable<Long> ids);

    Page<ProductEntity> findByNameContainingIgnoreCase(String name, Pageable pageable);

    long count();

    Page<ProductEntity> findByCategoryEntity_IdAndIsActive(Long id, boolean isActive, Pageable pageable);

    Page<ProductEntity> findBySubCategoryValues(List<SubcategoryValueEntity> subCategoryValues, Pageable pageable);

    // Query để lấy giá thấp nhất và cao nhất của sản phẩm
    @Query("SELECT MAX(p.price) FROM ProductEntity p WHERE (:categoryId IS NULL OR p.categoryEntity.id = :categoryId)")
    Long findMinMaxPriceByCategory(Long categoryId);

    List<ProductEntity> findByNameContainingIgnoreCase(String name);
}

