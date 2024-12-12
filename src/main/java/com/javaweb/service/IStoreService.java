package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.javaweb.entity.StoreEntity;

public interface IStoreService {

	
	 public Page<StoreEntity> findByStoreName(String storeName, Pageable pageable);
	 public Page<StoreEntity> findAll(Pageable pageable);
	 public Optional<StoreEntity> findById(Long storeId);
	 public List<StoreEntity> findAll();
	 public StoreEntity save(StoreEntity storeEntity);
	 public void deleteById(Long id);
}
