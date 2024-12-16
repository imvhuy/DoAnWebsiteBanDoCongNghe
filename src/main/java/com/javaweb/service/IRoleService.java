package com.javaweb.service;

import com.javaweb.entity.RoleEntity;

import java.util.List;
import java.util.Optional;

public interface IRoleService {
    List<RoleEntity> findAll();
    Optional<RoleEntity> findById(Long roleId);
	List<RoleEntity> findByIdIn(List<Long> ids);
}
