package com.javaweb.service;

import com.javaweb.entity.SubcategoryValueEntity;

import java.util.List;

public interface ISubCategoryValueService {
    List<SubcategoryValueEntity> getSubcategoryValueBySubcategoryId(Long id);

    SubcategoryValueEntity getSubcategoryValueById(Long id);

    List<SubcategoryValueEntity> findByCategoryEntity_Id(Long id);

    List<SubcategoryValueEntity> findByIds(List<Long> ids);
}
