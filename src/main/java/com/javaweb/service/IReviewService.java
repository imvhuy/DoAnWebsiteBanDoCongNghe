package com.javaweb.service;

import java.util.List;

import com.javaweb.dto.ReviewDTO;
import com.javaweb.entity.ReviewEntity;

public interface IReviewService {

	List<ReviewDTO> findReviewsByProductId(Long productId);

	ReviewEntity findReviewEntityById(Long id);

	ReviewEntity saveReviewEntity(ReviewEntity review);

	long countTotalReviews();

	Double calculateAverageRating(Long productId);

	List<Object[]> countReviewsByRating(Long productId);

}
