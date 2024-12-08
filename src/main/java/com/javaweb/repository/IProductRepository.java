package com.javaweb.repository;

import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.SubcategoryValueEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IProductRepository extends JpaRepository<ProductEntity, Long> {
    List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long id, Boolean isActive);
    Page<ProductEntity> findByNameContaining(String name, Pageable pageable);
    Page<ProductEntity> findAll(Pageable pageable);
    List<ProductEntity> findByNameContaining(String Name);
    List<ProductEntity> findAll(Sort sort);
    List<ProductEntity> findAllById(Iterable<Long> ids);
    long count();
    Page<ProductEntity> findByCategoryEntity_IdAndIsActive(Long id, boolean isActive, Pageable pageable);

    Page<ProductEntity> findBySubCategoryValues(List<SubcategoryValueEntity> subCategoryValues, Pageable pageable);
    // Query để lấy giá thấp nhất và cao nhất của sản phẩm
    @Query("SELECT MAX(p.price) FROM ProductEntity p WHERE (:categoryId IS NULL OR p.categoryEntity.id = :categoryId)")
    Long findMinMaxPriceByCategory(Long categoryId);
    List<ProductEntity> findByNameContainingIgnoreCase(String name);
}
