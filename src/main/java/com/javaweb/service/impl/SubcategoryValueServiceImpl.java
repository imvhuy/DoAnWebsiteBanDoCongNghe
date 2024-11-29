package com.javaweb.service.impl;

import com.javaweb.entity.SubcategoryValueEntity;
import com.javaweb.repository.ISubcategoryValueRepository;
import com.javaweb.service.ISubCategoryValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SubcategoryValueServiceImpl implements ISubCategoryValueService {
    @Autowired
    private ISubcategoryValueRepository attributeValueRepository;

    @Override
    public List<SubcategoryValueEntity> getSubcategoryValueBySubcategoryId(Long id) {
        return attributeValueRepository.findBySubcategoryEntity_Id(id);
    }

    @Override
    public SubcategoryValueEntity getSubcategoryValueById(Long id) {
        return attributeValueRepository.findById(id).orElse(null);
    }
}
