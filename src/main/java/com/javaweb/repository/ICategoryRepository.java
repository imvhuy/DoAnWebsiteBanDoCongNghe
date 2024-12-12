package com.javaweb.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.CategoryEntity;
@Repository
public interface ICategoryRepository  extends JpaRepository<CategoryEntity, Long>{
	List<CategoryEntity> findByNameContaining(String name);
    Page<CategoryEntity> findByNameContaining(String name, Pageable pageable);
    List<CategoryEntity> findAllByIsDeleted(boolean isDeleted);
    Page<CategoryEntity> findAll(Pageable pageable);
    List<CategoryEntity> findAll(Sort sort);
    List<CategoryEntity> findAllById(Iterable<Long> ids);
    CategoryEntity findBySlugAndIsDeleted(String slug,boolean isDeleted);
    Optional<CategoryEntity> findByName(String name);
}
