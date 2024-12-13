package com.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.OrderEntity;

@Repository
public interface IOrderRepository extends JpaRepository<OrderEntity, Long>{

}
