package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.javaweb.entity.VoucherEntity;

public interface IPromotionService {

	  void delete(VoucherEntity entity);
	    void deleteById(Long id);

	    long count();

	    List<VoucherEntity> findAll();
	    
	    public VoucherEntity save(VoucherEntity entity);
	    
	    Optional<VoucherEntity> findById(Long id);

	    List<VoucherEntity> findByDescriptionContainingIgnoreCase(String description);

	    Page<VoucherEntity> findByDescriptionContainingIgnoreCase(String description, Pageable pageable);

	    Page<VoucherEntity> findAll(Pageable pageable);

	    List<VoucherEntity> findAll(Sort sort);

	    List<VoucherEntity> findAllById(Iterable<Long> ids);

	    void deleteAll();
}
