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
    private ISubcategoryValueRepository subcategoryValueRepository;

    @Override
    public List<SubcategoryValueEntity> getSubcategoryValueBySubcategoryId(Long id) {
        return subcategoryValueRepository.findBySubcategoryEntity_Id(id);
    }

    @Override
    public SubcategoryValueEntity getSubcategoryValueById(Long id) {
        return subcategoryValueRepository.findById(id).orElse(null);
    }
    @Override
    public List<SubcategoryValueEntity> findByCategoryEntity_Id(Long id) {
        return subcategoryValueRepository.findByCategoryEntity_Id(id);
    }
    @Override
    public List<SubcategoryValueEntity> findByIds(List<Long> ids) {
        return subcategoryValueRepository.findByIdIn(ids);
    }
    @Override
    public List<SubcategoryValueEntity> findByNames(List<String> name) {
        return subcategoryValueRepository.findByValueIn(name);
    }
}
