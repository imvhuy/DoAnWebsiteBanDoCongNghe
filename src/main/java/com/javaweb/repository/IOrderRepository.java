package com.javaweb.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.OrderEntity;

@Repository
public interface IOrderRepository extends JpaRepository<OrderEntity, Long>{
	
    @Query("SELECT o FROM OrderEntity o WHERE o.user.username = :username")
    List<OrderEntity> findByUsername(String username);

   
    Page<OrderEntity> findByUser_Username(String username, Pageable pageable);
    
}