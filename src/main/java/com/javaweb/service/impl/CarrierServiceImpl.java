package com.javaweb.service.impl;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.repository.ICarrierRepository;
import com.javaweb.service.ICarrierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
public class CarrierServiceImpl implements ICarrierService {
    @Autowired
    private ICarrierRepository ICarrierRepository;

    @Override
    public void delete(CarrierEntity entity) {
        ICarrierRepository.delete(entity);
    }

    @Override
    public void deleteById(Long id) {
        ICarrierRepository.deleteById(id);
    }

    @Override
    public long count() {
        return ICarrierRepository.count();
    }

    @Override
    public List<CarrierEntity> findAll() {
        return ICarrierRepository.findAll();
    }

    @Override
    public <S extends CarrierEntity> S save(S entity) {
        if(entity.getId() == null) {
            return ICarrierRepository.save(entity);
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
        return ICarrierRepository.save(entity);
    }

    @Override
    public Optional<CarrierEntity> findById(Long id) {
        return ICarrierRepository.findById(id);
    }

    @Override
    public List<CarrierEntity> findByNameContaining(String name) {
        return ICarrierRepository.findByNameContaining(name);
    }

    @Override
    public Page<CarrierEntity> findByNameContaining(String name, Pageable pageable) {
        return ICarrierRepository.findByNameContaining(name, pageable);
    }

    @Override
    public Page<CarrierEntity> findAll(Pageable pageable) {
        return ICarrierRepository.findAll(pageable);
    }

    @Override
    public List<CarrierEntity> findAll(Sort sort) {
        return ICarrierRepository.findAll();
    }

    @Override
    public List<CarrierEntity> findAllById(Iterable<Long> ids) {
        return ICarrierRepository.findAllById(ids);
    }


    @Override
    public void deleteAll() {
        ICarrierRepository.deleteAll();
    }
}
