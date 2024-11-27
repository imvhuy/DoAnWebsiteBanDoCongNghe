package com.javaweb.repository;

import com.javaweb.entity.SubcategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISubcategoryRepository extends JpaRepository<SubcategoryEntity, Long> {
    List<SubcategoryEntity> findByCategoryEntity_Id(Long categoryId);
}
