package com.javaweb.repository;

import com.javaweb.entity.CarrierEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CarrierRepository extends JpaRepository<CarrierEntity, Long> {
    List<CarrierEntity> findByNameContaining(String name);
    Page<CarrierEntity> findByNameContaining(String name, Pageable pageable);

    Page<CarrierEntity> findAll(Pageable pageable);
    List<CarrierEntity> findAll(Sort sort);
    List<CarrierEntity> findAllById(Iterable<Long> ids);
}
