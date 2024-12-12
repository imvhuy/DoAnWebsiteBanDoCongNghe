package com.javaweb.repository;

import com.javaweb.entity.ProductEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface IProductRepository extends JpaRepository<ProductEntity,Long> {
    List<ProductEntity> findByNameContaining(String Name);
   Page<ProductEntity> findByNameContaining(String Name, Pageable pageable);

    Page<ProductEntity> findAll(Pageable pageable);
    List<ProductEntity> findAll(Sort sort);
    List<ProductEntity> findAllById(Iterable<Long> ids);
    Page<ProductEntity> findByNameContainingIgnoreCase(String name, Pageable pageable);
}
