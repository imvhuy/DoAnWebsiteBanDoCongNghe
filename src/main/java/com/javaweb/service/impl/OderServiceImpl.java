package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.IOrderRepository;
import com.javaweb.service.IOrderService;

@Service

public class OderServiceImpl implements IOrderService {
	
	   @Autowired
	    private IOrderRepository orderRepository;
	 //vũ làm nha a Thao iu   
	 @Override
	    public List<OrderEntity> findOrdersByUsername(String username) {
	        return orderRepository.findByUsername(username);
	    }
	 @Override
	 public Page<OrderEntity> findOrdersByUsername(String username, Pageable pageable) {
	        return orderRepository.findByUser_Username(username, pageable);
	    }
	 @Override
	 public Optional<OrderEntity> findById(Long orderId) {
		    return orderRepository.findById(orderId);
		}
}
