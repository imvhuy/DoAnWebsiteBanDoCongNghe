package com.javaweb.service;

import com.javaweb.entity.SubcategoryEntity;

import java.util.List;

public interface ISubCategoryService {
    List<SubcategoryEntity> getSubcategoryByCategoryId(Long categoryId);
}
