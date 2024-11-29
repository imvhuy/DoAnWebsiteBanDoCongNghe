package com.javaweb.repository;


import com.javaweb.entity.SubcategoryValueEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISubcategoryValueRepository extends JpaRepository<SubcategoryValueEntity, Long> {
    List<SubcategoryValueEntity> findBySubcategoryEntity_Id(Long subcategoryId);
}
