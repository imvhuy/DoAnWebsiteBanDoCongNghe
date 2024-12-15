package com.javaweb.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.StoreLevelEntity;
@Repository
public interface IStoreLevelRepository extends JpaRepository<StoreLevelEntity, Long> {

	Optional<StoreLevelEntity> findTopByMinPointLessThanEqualOrderByMinPointDesc(Long minPoint);
}
