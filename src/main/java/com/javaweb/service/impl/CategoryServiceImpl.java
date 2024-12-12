package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;
import org.springframework.stereotype.Service;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.repository.ICategoryRepository;
import com.javaweb.service.ICategoryService;

@Service
public class CategoryServiceImpl implements ICategoryService {
	@Autowired
    private ICategoryRepository categoryRepository;

	@Override
	public List<CategoryEntity> getAllCategories() {
		return categoryRepository.findAllByIsDeleted(false);
	}

	@Override
	public List<CategoryEntity> findByNameContaining(String name) {
		return categoryRepository.findByNameContaining(name);
	}

	@Override
	public CategoryEntity findCategoryEntityBySlug(String slug, boolean isDelete) {
		return categoryRepository.findBySlugAndIsDeleted(slug, isDelete);
	}

	@Override
	public Optional<CategoryEntity> findByName(String name) {
		return categoryRepository.findByName(name);
	}

	@Override
	public Page<CategoryEntity> findByNameContaining(String name, Pageable pageable) {
		return categoryRepository.findByNameContaining(name, pageable);
	}

	@Override
	public Page<CategoryEntity> findAll(Pageable pageable) {
		return categoryRepository.findAll(pageable);
	}

	@Override
	public List<CategoryEntity> findAll() {
		return categoryRepository.findAll();
	}

	@Override
	public Optional<CategoryEntity> findById(Long id) {
		return categoryRepository.findById(id);
	}

	@Override
	public long count() {
		return categoryRepository.count();
	}

	@Override
	public void deleteById(Long id) {
		categoryRepository.deleteById(id);
	}

	@Override
	public <S extends CategoryEntity> S save(S entity) {
		 if(entity.getId() == null) {
	            return categoryRepository.save(entity);
	        }
	        else {
	            Optional<CategoryEntity> opt = findById(entity.getId());
	            if (opt.isPresent()) {
	                if(StringUtils.isEmpty(entity.getName())) {
	                    entity.setName(opt.get().getName());
	                }
	                else {
	                    entity.setName(entity.getName());
	                }
	            }
	        }
	        return categoryRepository.save(entity);
	}

}
