package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.repository.*;
import com.javaweb.service.IFavoriteProductService;
import com.javaweb.entity.*;
@Service
public class FavoriteProductServiceImpl  implements IFavoriteProductService{
	@Autowired
    private IFavoriteProductRepository favoriteProductRepository;
	@Autowired
    private IUserRepository userRepository;
	@Autowired
    private IProductRepository productRepository;
	@Override
	public List<ProductDetailDTO> findFavoriteProductsByUser(Long userId){
		return favoriteProductRepository.findFavoriteProductsByUser(userId);
	}
	
	 @Override
	public boolean addFavoriteProduct(Long productId,Long userId) {
	        //Tim kiem user, product
	        UserEntity  user = userRepository.findById(userId).orElse(null);
	        ProductEntity product = productRepository.findById(productId).orElse(null);
	        
	        if (product != null && user != null) {
	           FavoriteProductEntity favProduct = new FavoriteProductEntity();
	           favProduct.setUser(user);
	           favProduct.setProduct(product);
	           favoriteProductRepository.save(favProduct);
	            return true;
	        }
	        return false;
	    }
	 

		@Override
		public boolean removeFavoriteProduct(Long productId,Long userId) {
		        //Tim kiem user, product
		        UserEntity  user = userRepository.findById(userId).orElse(null);
		        ProductEntity product = productRepository.findById(productId).orElse(null);
		        FavoriteProductEntity favoriteProduct = favoriteProductRepository.findFavoriteProductEntityByProductIdAndUserId(productId, userId);
		        if (favoriteProduct != null) {
		           favoriteProductRepository.delete(favoriteProduct);
		            return true;
		        }
		        return false;
		    }
		
		@Override
		public FavoriteProductEntity findFavoriteProductEntityByProductIdAndUserId(Long productId, Long userId) {
			return favoriteProductRepository.findFavoriteProductEntityByProductIdAndUserId(productId, userId);
		}
}
