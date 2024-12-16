package com.javaweb.service.impl;

import com.javaweb.entity.RoleEntity;
import com.javaweb.repository.IRoleRepository;
import com.javaweb.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoleServiceImpl implements IRoleService {
    @Autowired
    private IRoleRepository roleRepository;

    @Override
    public List<RoleEntity> findAll() {
        return roleRepository.findAll();
    }
    @Override
    public Optional<RoleEntity> findById(Long roleId) {
       return roleRepository.findById(roleId);
    }
    @Override
    public List<RoleEntity> findByIdIn(List<Long> ids) {
        return roleRepository.findAllById(ids); // Sử dụng JpaRepository
    }

}
