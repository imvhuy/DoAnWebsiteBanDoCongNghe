package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.javaweb.entity.CommissionEntity;

public interface ICommissionService {
	void delete(CommissionEntity entity);
    void deleteById(Long id);

    long count();

    List<CommissionEntity> findAll();

    <S extends CommissionEntity> S save(S entity);

    Optional<CommissionEntity> findById(Long id);

    List<CommissionEntity> findByNameContaining(String name);
    //tim kiem va phan trang
    Page<CommissionEntity> findByNameContaining(String name, Pageable pageable);

    Page<CommissionEntity> findAll(Pageable pageable);

    List<CommissionEntity> findAll(Sort sort);

    List<CommissionEntity> findAllById(Iterable<Long> id);
    void deleteAll();
}
