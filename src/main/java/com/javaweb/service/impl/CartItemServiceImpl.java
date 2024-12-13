package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaweb.entity.CartEntity;
import com.javaweb.entity.CartItemEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.ICartItemRepository;
import com.javaweb.service.*;
@Service
public class CartItemServiceImpl implements ICartItemService{
	@Autowired
	ICartItemRepository cartItemRepository;
	
	@Override
	public CartItemEntity findById(Long id) {
		return cartItemRepository.findById(id).orElse(null);
	}
	@Override
	public void save(CartItemEntity cartItem) {
		cartItemRepository.save(cartItem);
	}
	@Transactional
	@Override
	public void deleteAllByCart(CartEntity cart) {
		cartItemRepository.deleteAllByCart(cart);
	}
	

}
