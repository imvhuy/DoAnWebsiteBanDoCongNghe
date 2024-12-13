package com.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.OrderItemEntity;
@Repository
public interface IOrderItemRepository extends JpaRepository<OrderItemEntity, Long>{

}
