package com.javaweb.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.*;
@Repository
public interface IFavoriteProductRepository extends JpaRepository<FavoriteProductEntity, Long>{
	
	
	@Query ("SELECT new com.javaweb.dto.ProductDTO(p.id, p.productName, p.price, g.image) " +
			"FROM  FavoriteProductEntity fp " +
			"JOIN fp.product p " +
			"JOIN fp.user u " +
			"LEFT JOIN GalleryEntity  g ON g.productEntity = p  "+ 
			"WHERE u.id = :userId")
	List<ProductDTO> findFavoriteProductsByUser(@Param("userId") Long userId);


	 FavoriteProductEntity findFavoriteProductEntityByProductIdAndUserId(Long productId, Long userId);

	
	
	
}
