package com.javaweb.repository;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IProductRepository extends JpaRepository<ProductEntity, Long> {
    List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long id, Boolean isActive);
    Page<ProductEntity> findByNameContaining(String name, Pageable pageable);
    Page<ProductEntity> findAll(Pageable pageable);
    List<ProductEntity> findByNameContaining(String Name);
    List<ProductEntity> findAll(Sort sort);
    List<ProductEntity> findAllById(Iterable<Long> ids);


}
