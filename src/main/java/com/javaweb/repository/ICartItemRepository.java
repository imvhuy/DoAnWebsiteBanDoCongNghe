package com.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.CartItemEntity;
import com.javaweb.entity.CartEntity;

@Repository
public interface ICartItemRepository extends JpaRepository<CartItemEntity, Long>{
	void deleteAllByCart(CartEntity cart);
}
