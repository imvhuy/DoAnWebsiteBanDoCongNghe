package com.javaweb.dto;

import java.util.Date;

import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.UserEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReviewDTO {
	private Long id;
	private UserEntity user;
	 private ProductEntity product;
	 private Long parent_id;
	 private String content;
	 private int rating;
	 private Date createdDate;
}
