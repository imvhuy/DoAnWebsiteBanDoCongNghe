package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.javaweb.entity.CarrierEntity;
import com.javaweb.entity.CommissionEntity;
import com.javaweb.repository.ICommissionRepository;
import com.javaweb.service.ICommissionService;

@Service
public class CommissionServiceImpl implements  ICommissionService{
	@Autowired
    private ICommissionRepository commissionRepository;
	@Override
	public List<CommissionEntity> findByNameContaining(String name) {
		return commissionRepository.findByNameContaining(name);
	}

	@Override
	public Page<CommissionEntity> findByNameContaining(String name, Pageable pageable) {
		return commissionRepository.findByNameContaining(name, pageable);
	}

	@Override
	public Page<CommissionEntity> findAll(Pageable pageable) {
		return commissionRepository.findAll(pageable);
	}

	@Override
	public List<CommissionEntity> findAll() {
		return commissionRepository.findAll();
	}

	@Override
	public Optional<CommissionEntity> findById(Long id) {
		return commissionRepository.findById(id);
	}

	@Override
	public long count() {
		return commissionRepository.count();
	}

	@Override
	public void deleteById(Long id) {
		commissionRepository.deleteById(id);
	}

	@Override
	public <S extends CommissionEntity> S save(S entity) {
		 if(entity.getId() == null) {
	            return commissionRepository.save(entity);
	        }
	        else {
	            Optional<CommissionEntity> opt = findById(entity.getId());
	            if (opt.isPresent()) {
	                if(StringUtils.isEmpty(entity.getName())) {
	                    entity.setName(opt.get().getName());
	                }
	                else {
	                    entity.setName(entity.getName());
	                }
	            }
	        }
	        return commissionRepository.save(entity);
	}
	
    @Override
    public List<CommissionEntity> findAllById(Iterable<Long> ids) {
        return commissionRepository.findAllById(ids);
    }
    @Override
    public List<CommissionEntity> findAll(Sort sort) {
        return commissionRepository.findAll();
    }
    
    @Override
    public void deleteAll() {
    	commissionRepository.deleteAll();
    }
}
