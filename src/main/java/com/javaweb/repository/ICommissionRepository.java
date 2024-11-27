package com.javaweb.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.CommissionEntity;


@Repository
public interface ICommissionRepository extends JpaRepository<CommissionEntity, Long>{
	List<CommissionEntity> findByNameContaining(String name);
    Page<CommissionEntity> findByNameContaining(String name, Pageable pageable);

    Page<CommissionEntity> findAll(Pageable pageable);
    List<CommissionEntity> findAll(Sort sort);
    List<CommissionEntity> findAllById(Iterable<Long> ids);
}
