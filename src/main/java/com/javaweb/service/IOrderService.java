package com.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.javaweb.entity.AddressEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.UserEntity;

public interface IOrderService {

	
	//vũ làm nha a Thao iu
	 List<OrderEntity> findOrdersByUsername(String username);

	Page<OrderEntity> findOrdersByUsername(String username, Pageable pageable);

	Optional<OrderEntity> findById(Long orderId);


}