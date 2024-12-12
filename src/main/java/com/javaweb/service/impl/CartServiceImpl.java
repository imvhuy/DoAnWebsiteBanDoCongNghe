package com.javaweb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.javaweb.dto.CartProductDTO;
import com.javaweb.repository.ICartRepository;
import com.javaweb.service.ICartService;
@Service
public class CartServiceImpl implements ICartService{
	@Autowired
	private ICartRepository cartRepository;
	
	@Override
	public List<CartProductDTO> findCartItemsByUser(@Param("id") Long id){
		return cartRepository.findCartItemsByUser(id);
	}
}
