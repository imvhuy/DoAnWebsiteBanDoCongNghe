package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.entity.OrderItemEntity;
import com.javaweb.repository.IOrderItemRepository;
import com.javaweb.service.IOrderItemService;
@Service
public class OrderItemServiceImpl implements IOrderItemService{
	@Autowired
	IOrderItemRepository orderItemRepository ;
	@Override
	public void save(OrderItemEntity orderItem) {
		orderItemRepository.save(orderItem);
	}
}
