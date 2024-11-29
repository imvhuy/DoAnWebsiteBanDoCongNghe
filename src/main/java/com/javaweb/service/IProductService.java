package com.javaweb.service;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;

import com.javaweb.dto.ProductDTO;

public interface IProductService {

	List<ProductDTO> findLatestProductInThisMonth(Date date);

	List<ProductDTO> findTopSellingProducts(Pageable pageable);

	List<ProductDTO> findTopTotalRatingProducts(Pageable pageable);

}
