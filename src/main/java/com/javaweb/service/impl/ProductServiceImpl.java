package com.javaweb.service.impl;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.CarrierRepository;
import com.javaweb.repository.ProductRepository;
import com.javaweb.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements IProductService {
    @Autowired
    private ProductRepository productRepository;
    @Override
    public void delete(ProductEntity entity) {
        productRepository.delete(entity);
    }

    @Override
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public long count() {
        return productRepository.count();
    }

    @Override
    public List<ProductEntity> findAll() {
        return productRepository.findAll();
    }

    @Override
    public <S extends ProductEntity> S save(S entity) {
        if(entity.getId() == null) {
            return productRepository.save(entity);
        }
        else {
            Optional<ProductEntity> opt = findById(entity.getId());
            if (opt.isPresent()) {
                if(StringUtils.isEmpty(entity.getName())) {
                    entity.setName(opt.get().getName());
                }
                else {
                    entity.setName(entity.getName());
                }
            }
        }
        return productRepository.save(entity);
    }

    @Override
    public Optional<ProductEntity> findById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    public List<ProductEntity> findByNameContaining(String Name) {
        return productRepository.findByNameContaining(Name);
    }

    @Override
    public Page<ProductEntity> findByNameContaining(String Name, Pageable pageable) {
        return productRepository.findByNameContaining(Name, pageable);
    }

    @Override
    public Page<ProductEntity> findAll(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Override
    public List<ProductEntity> findAll(Sort sort) {
        return productRepository.findAll(sort);
    }

    @Override
    public List<ProductEntity> findAllById(Iterable<Long> id) {
        return productRepository.findAllById(id);
    }

    @Override
    public void deleteAll() {
        productRepository.deleteAll();
    }
}
