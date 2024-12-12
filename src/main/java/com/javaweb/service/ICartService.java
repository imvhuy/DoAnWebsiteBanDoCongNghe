package com.javaweb.service;

import java.util.List;

import org.springframework.data.repository.query.Param;

import com.javaweb.dto.CartProductDTO;

public interface ICartService {

	List<CartProductDTO> findCartItemsByUser(@Param("id") Long id);

}
