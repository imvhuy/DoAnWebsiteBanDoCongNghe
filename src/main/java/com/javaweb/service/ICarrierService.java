package com.javaweb.service;

import com.javaweb.entity.CarrierEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Optional;

public interface ICarrierService {
    void delete(CarrierEntity entity);
    void deleteById(Long id);
    long count();

    List<CarrierEntity> findAll();

    <S extends CarrierEntity> S save(S entity);

    Optional<CarrierEntity> findById(Long id);

    List<CarrierEntity> findByNameContaining(String name);
    //tim kiem va phan trang
    Page<CarrierEntity> findByNameContaining(String name, Pageable pageable);

    Page<CarrierEntity> findAll(Pageable pageable);

    List<CarrierEntity> findAll(Sort sort);

    List<CarrierEntity> findAllById(Iterable<Long> id);
    void deleteAll();
}
