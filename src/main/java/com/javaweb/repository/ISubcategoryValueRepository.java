package com.javaweb.repository;


import com.javaweb.entity.SubcategoryValueEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface ISubcategoryValueRepository extends JpaRepository<SubcategoryValueEntity, Long> {
    List<SubcategoryValueEntity> findBySubcategoryEntity_Id(Long subcategoryId);

    @Query("SELECT sv FROM SubcategoryValueEntity sv " +
            "JOIN sv.subcategoryEntity sc " +
            "JOIN sc.categoryEntity c " +
            "WHERE c.id = :categoryId")
    List<SubcategoryValueEntity> findByCategoryEntity_Id(Long categoryId);
    SubcategoryValueEntity findBySlug(String slug);
    List<SubcategoryValueEntity> findByIdIn(List<Long> ids);

    List<SubcategoryValueEntity> findByValueIn(Collection<String> values);
}
