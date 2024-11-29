package com.javaweb.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.ProductEntity;

@Repository
public interface IProductRepository extends JpaRepository<ProductEntity, Long>{
	@Query("SELECT new com.javaweb.dto.ProductDTO(p.id, p.productName, p.price, g.image) " +
		       "FROM ProductEntity p " +
		       "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
		       "WHERE g.type = 'front' " +
		       "AND MONTH(g.createdDate) = MONTH(:date) " +
		       "AND YEAR(g.createdDate) = YEAR(:date)")
		List<ProductDTO> findLatestProductInThisMonth(@Param("date") Date date);

	 @Query("SELECT new com.javaweb.dto.ProductDTO(" +
	           "p.id, p.productName, p.price, g.image, SUM(oi.count)) " +
	           "FROM OrderItemEntity oi " +
	           "JOIN oi.product p " +
	           "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
	           "GROUP BY p.id, p.productName, p.price, g.image " +
	           "ORDER BY SUM(oi.count) DESC")
	    List<ProductDTO> findTopSellingProducts(Pageable pageable);
	 
	// Truy vấn tính tổng đánh giá của từng sản phẩm
	    @Query("SELECT  new com.javaweb.dto.ProductDTO(p.id , p.productName, SUM(r.rating), g.image, p.price) " +
	           "FROM ProductEntity p " +
	           "LEFT JOIN ReviewEntity r ON r.product = p " +
	           "LEFT JOIN GalleryEntity g ON g.productEntity = p " +
	           "GROUP BY p.id, p.productName, p.price, g.image "+
		         "ORDER BY SUM(r.rating) DESC")
	    List<ProductDTO> findTopTotalRatingProducts(Pageable pageable);

}
