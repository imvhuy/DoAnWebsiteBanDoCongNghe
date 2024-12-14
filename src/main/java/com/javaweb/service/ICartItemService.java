package com.javaweb.service;

import com.javaweb.entity.CartEntity;
import com.javaweb.entity.CartItemEntity;

public interface ICartItemService {

	CartItemEntity findById(Long id);

	void save(CartItemEntity cartItem);

	void deleteAllByCart(CartEntity cart);

	void deleteById(Long id);

}
