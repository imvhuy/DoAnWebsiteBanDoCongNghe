package com.javaweb.service;

import com.javaweb.entity.StoreEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface IStoreService {
    Page<StoreEntity> findByStoreName(String storeName, Pageable pageable);
    Page<StoreEntity> findAll(Pageable pageable);
    Optional<StoreEntity> findById(Long storeId);
    List<StoreEntity> findAll();
    StoreEntity save(StoreEntity storeEntity);
    void deleteById(Long id);
    StoreEntity findByOwner(String ownerId);
}
