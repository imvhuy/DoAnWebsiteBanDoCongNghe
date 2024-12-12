package com.javaweb.repository;

import com.javaweb.entity.StoreEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IStoreRepository extends JpaRepository<StoreEntity, Long> {
    Page<StoreEntity> findByNameContaining(String storeName, Pageable pageable);

    List<StoreEntity> findByOwner_Username(String owner);
}
