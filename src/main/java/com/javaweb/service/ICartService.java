package com.javaweb.service;

import java.util.List;

import org.springframework.data.repository.query.Param;

import com.javaweb.dto.CartProductDTO;
import com.javaweb.entity.CartEntity;
import com.javaweb.entity.UserEntity;

public interface ICartService {

	List<CartProductDTO> findCartItemsByUser(@Param("id") Long id);

	void updateQuantity(Long carItemtId, Long quantity);

	CartEntity findCartByUser(UserEntity user);

	void save(CartEntity cart);

	void addToCart(Long productId, Long quantity, UserEntity user);



}
