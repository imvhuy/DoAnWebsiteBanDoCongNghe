package com.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.CommissionEntity;
@Repository
public interface CommissionRepository extends JpaRepository<CommissionEntity, Long> {

}
