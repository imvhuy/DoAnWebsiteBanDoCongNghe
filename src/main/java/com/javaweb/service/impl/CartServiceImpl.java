package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.javaweb.dto.CartProductDTO;
import com.javaweb.repository.*;
import com.javaweb.service.*;
import com.javaweb.entity.*;
@Service
public class CartServiceImpl implements ICartService{
	@Autowired
	private ICartRepository cartRepository;
	@Autowired
	private ICartItemRepository cartItemRepository;
	@Autowired
	private ICartItemService cartItemService;
	@Override
	public List<CartProductDTO> findCartItemsByUser(@Param("id") Long id){
		return cartRepository.findCartItemsByUser(id);
	}
	@Override
	public void updateQuantity(Long carItemtId, Long quantity) {
        CartItemEntity cartItem = cartItemService.findById(carItemtId);
        if (cartItem != null) {
            cartItem.setQuantity(quantity);
            cartItemService.save(cartItem);
        } else {
            throw new RuntimeException("Product not found in cart");
        }
    }
	@Override
	public CartEntity findCartByUser(UserEntity user) {
		return cartRepository.findCartEntityByUser(user);
	}

}
