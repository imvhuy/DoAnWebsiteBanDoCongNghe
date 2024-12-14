package com.javaweb.repository;

import java.util.List;

import com.javaweb.entity.StoreEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.*;

@Repository
public interface IStoreRepository extends JpaRepository<StoreEntity, Long> {
    Page<StoreEntity> findByNameContaining(String storeName, Pageable pageable);

    StoreEntity findByOwner_Username(String owner);


}
