package com.javaweb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.dto.ReviewDTO;
import com.javaweb.entity.ReviewEntity;
import com.javaweb.repository.IReviewRepository;
import com.javaweb.service.IReviewService;
@Service
public class ReviewServiceImpl implements IReviewService{
	@Autowired
    private IReviewRepository reviewRepository;
	@Override
	public List<ReviewDTO> findReviewsByProductId(Long productId){
		return reviewRepository.findReviewsByProductId(productId);
	}
	@Override
	public ReviewEntity findReviewEntityById(Long id) {
		return reviewRepository.findReviewEntityById(id);
	}
	
	@Override
	public ReviewEntity saveReviewEntity(ReviewEntity review) {
		return reviewRepository.save(review);
	}
	
	@Override
	public long countTotalReviews() {
		return reviewRepository.count()	;
	}
	
	 @Override
	public List<Object[]> countReviewsByRating(Long productId){
		 return reviewRepository.countReviewsByRating( productId);
	 }
	 
	 @Override
	public Double calculateAverageRating(Long productId) {
		 return reviewRepository.calculateAverageRating(productId);
	 }
}
