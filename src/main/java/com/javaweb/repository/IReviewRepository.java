package com.javaweb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.javaweb.dto.ReviewDTO;
import com.javaweb.entity.ReviewEntity;
@Repository
public interface IReviewRepository  extends JpaRepository<ReviewEntity, Long>{
	@Query("SELECT new com.javaweb.dto.ReviewDTO(r.id, r.user, r.product,r.parentReview.id, r.content, r.rating,r.createdDate) " +
		       "FROM ReviewEntity r " +
		       "JOIN  r.user u " +
		       "JOIN  r.product  p " +
		       "WHERE r.product.id = :productId " +
		       "ORDER BY r.createdDate ")
		List<ReviewDTO> findReviewsByProductId(@Param("productId") Long productId);
		ReviewEntity findReviewEntityById(Long id);
		 long count();
		
		// Truy vấn số lượng review theo rating cho một sản phẩm
		    @Query("SELECT r.rating, COUNT(r) FROM ReviewEntity r WHERE r.product.id = :productId AND r.rating <> 0 GROUP BY r.rating ORDER BY r.rating DESC")
		    List<Object[]> countReviewsByRating(Long productId);

		    // Truy vấn giá trị trung bình của các review cho sản phẩm
		    @Query("SELECT AVG(r.rating) FROM ReviewEntity r WHERE r.product.id = :productId AND r.rating <> 0")
		    Double calculateAverageRating(Long productId);
		
}
