package com.javaweb.service.impl;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.repository.CarrierRepository;
import com.javaweb.service.CarrierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
public class CarrierServiceImpl implements CarrierService {
    @Autowired
    private CarrierRepository carrierRepository;

    @Override
    public void delete(CarrierEntity entity) {
        carrierRepository.delete(entity);
    }

    @Override
    public void deleteById(Long id) {
        carrierRepository.deleteById(id);
    }

    @Override
    public long count() {
        return carrierRepository.count();
    }

    @Override
    public List<CarrierEntity> findAll() {
        return carrierRepository.findAll();
    }

    @Override
    public <S extends CarrierEntity> S save(S entity) {
        if(entity.getId() == null) {
            return carrierRepository.save(entity);
        }
        else {
            Optional<CarrierEntity> opt = findById(entity.getId());
            if (opt.isPresent()) {
                if(StringUtils.isEmpty(entity.getName())) {
                    entity.setName(opt.get().getName());
                }
                else {
                    entity.setName(entity.getName());
                }
            }
        }
        return carrierRepository.save(entity);
    }

    @Override
    public Optional<CarrierEntity> findById(Long id) {
        return carrierRepository.findById(id);
    }

    @Override
    public List<CarrierEntity> findByNameContaining(String name) {
        return carrierRepository.findByNameContaining(name);
    }

    @Override
    public Page<CarrierEntity> findByNameContaining(String name, Pageable pageable) {
        return carrierRepository.findByNameContaining(name, pageable);
    }

    @Override
    public Page<CarrierEntity> findAll(Pageable pageable) {
        return carrierRepository.findAll(pageable);
    }

    @Override
    public List<CarrierEntity> findAll(Sort sort) {
        return carrierRepository.findAll();
    }

    @Override
    public List<CarrierEntity> findAllById(Iterable<Long> ids) {
        return carrierRepository.findAllById(ids);
    }


    @Override
    public void deleteAll() {
        carrierRepository.deleteAll();
    }
}
