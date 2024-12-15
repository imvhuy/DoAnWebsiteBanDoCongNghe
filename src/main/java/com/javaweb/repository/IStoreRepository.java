package com.javaweb.repository;

import com.javaweb.entity.StoreEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import com.javaweb.entity.*;
import com.javaweb.entity.UserEntity;


@Repository
public interface IStoreRepository extends JpaRepository<StoreEntity, Long> {
    Page<StoreEntity> findByNameContaining(String storeName, Pageable pageable);

    StoreEntity findByOwner_Username(String owner);

     StoreEntity findByOwner(UserEntity owner);

	Page<StoreEntity> findByIsActive(Boolean isActive, Pageable pageable);

	Page<StoreEntity> findByNameContainingAndIsActive(String storeName, Boolean isActive, Pageable pageable);
}
