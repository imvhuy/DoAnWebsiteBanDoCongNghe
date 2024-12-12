package com.javaweb.repository;

import com.javaweb.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface IRoleRepository extends JpaRepository<RoleEntity, Long> {
    RoleEntity findByName(String name);
}
