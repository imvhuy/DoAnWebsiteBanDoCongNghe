package com.javaweb.service;

import com.javaweb.entity.SubcategoryValueEntity;

import java.util.List;

public interface ISubcategoryValueService {
    List<SubcategoryValueEntity> getAttributeValuesByAttributeId(Long id);

    SubcategoryValueEntity getAttributeValueById(Long id);
}
