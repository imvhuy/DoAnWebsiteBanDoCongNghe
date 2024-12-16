package com.javaweb.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.VoucherEntity;
@Repository
public interface IPromotionRepository extends JpaRepository<VoucherEntity, Long> {

	List<VoucherEntity> findByDescriptionContainingIgnoreCase(String description);
	Page<VoucherEntity> findByDescriptionContainingIgnoreCase(String description, Pageable pageable);
	
	@Modifying
	@Query("UPDATE VoucherEntity v SET v.quantity = :quantity WHERE id = :id")
	void updateQuantity(@Param("id") Long id,@Param("quantity") int quantity);
	
	List<VoucherEntity> findByQuantityGreaterThan(int quantity);

}
