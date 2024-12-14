package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.javaweb.entity.CommissionEntity;


public interface ICommissionService {
	CommissionEntity saveCommission(CommissionEntity commissionEntity);
	List<CommissionEntity> findAll();
	Optional<CommissionEntity> findById(Long ID);
	Page<CommissionEntity> findAll(Pageable pageable);
	void deleteById(Long id);
	List<CommissionEntity> findAllById(Iterable<Long> ids);
	List<CommissionEntity> findAll(Sort sort);
	<S extends CommissionEntity> S save(S entity);
}
