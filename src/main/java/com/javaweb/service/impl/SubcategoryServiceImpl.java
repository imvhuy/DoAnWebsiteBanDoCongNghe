package com.javaweb.service.impl;

import com.javaweb.entity.SubcategoryEntity;
import com.javaweb.repository.ISubcategoryRepository;
import com.javaweb.service.ISubCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SubcategoryServiceImpl implements ISubCategoryService {
    @Autowired
    private ISubcategoryRepository attributeRepository;

    @Override
    public List<SubcategoryEntity> getAttributeByCategoryId(Long categoryId) {
        return attributeRepository.findByCategoryEntity_Id(categoryId);
    }
    public SubcategoryEntity getAttributeById(Long id) {
        return attributeRepository.findById(id).orElse(null);
    }
}
