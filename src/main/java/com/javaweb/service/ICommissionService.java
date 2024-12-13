package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.javaweb.entity.CommissionEntity;


public interface ICommissionService {
	public CommissionEntity saveCommission(CommissionEntity commissionEntity);
	public  List<CommissionEntity> findAll();
	public Optional<CommissionEntity> findById(Long ID);
	public Page<CommissionEntity> findAll(Pageable pageable);
	public void deleteById(Long id);
}
