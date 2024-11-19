package com.javaweb.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.VoucherEntity;
@Repository
public interface PromotionRepository extends JpaRepository<VoucherEntity, Long> {

	List<VoucherEntity> findByDescriptionContainingIgnoreCase(String description);
	Page<VoucherEntity> findByDescriptionContainingIgnoreCase(String description, Pageable pageable);

}
