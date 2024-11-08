package com.javaweb.service.impl;

import com.javaweb.entity.RoleEntity;
import com.javaweb.repository.IRoleRepository;
import com.javaweb.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements IRoleService {
    @Autowired
    private IRoleRepository roleRepository;

    @Override
    public List<RoleEntity> findAll() {
        return roleRepository.findAll();
    }
}
