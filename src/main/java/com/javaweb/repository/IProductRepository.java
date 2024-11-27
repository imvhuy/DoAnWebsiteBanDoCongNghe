package com.javaweb.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.ProductEntity;

public interface IProductRepository extends JpaRepository<ProductEntity, Long>{
	@Query("SELECT new com.javaweb.dto.ProductDTO(p.id, p.productName, p.price, g.image,0) " +
		       "FROM ProductEntity p " +
		       "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
		       "WHERE g.type = 'front' " +
		       "AND MONTH(g.createdDate) = MONTH(:date) " +
		       "AND YEAR(g.createdDate) = YEAR(:date)")
		List<ProductDTO> findLatestProductInThisMonth(@Param("date") Date date);

	 @Query("SELECT new com.javaweb.dto.ProductDTO(" +
	           "p.id, p.productName, p.price, p.image, SUM(oi.count)) " +
	           "FROM OrderItemEntity oi " +
	           "JOIN oi.product p " +
	           "GROUP BY p.id, p.productName, p.price, p.image " +
	           "ORDER BY SUM(oi.count) DESC")
	    List<ProductDTO> findTopSellingProducts(Pageable pageable);

}
