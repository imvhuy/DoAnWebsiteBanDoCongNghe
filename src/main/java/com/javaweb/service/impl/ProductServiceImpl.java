package com.javaweb.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.javaweb.dto.ProductDTO;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IProductService;
@Service
public class ProductServiceImpl implements IProductService{
	@Autowired
    private IProductRepository productRepository;
	@Override
	public List<ProductDTO> findLatestProductInThisMonth(Date date){
		return productRepository.findLatestProductInThisMonth(date);
	}
	
	 @Override
	public List<ProductDTO> findTopSellingProducts(Pageable pageable){
		 return productRepository.findTopSellingProducts(pageable);
	 }
	 
	 @Override
	public List<ProductDTO> findTopTotalRatingProducts(Pageable pageable){
		 return productRepository.findTopTotalRatingProducts(pageable);
	 }
}
