package com.javaweb.service;

import java.util.List;

import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.FavoriteProductEntity;

public interface IFavoriteProductService {

	List<ProductDTO> findFavoriteProductsByUser(Long userId);

	boolean addFavoriteProduct(Long productId, Long userId);

	boolean removeFavoriteProduct(Long productId, Long userId);

	FavoriteProductEntity findFavoriteProductEntityByProductIdAndUserId(Long productId, Long userId);

}
