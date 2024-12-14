package com.javaweb.dto;

public class FavoriteProductDTO {
	private Long productId;
	private Long userId;
	
	public FavoriteProductDTO(Long productId, Long userId) {
		this.productId = productId;
		this.userId = userId;
	}
	public FavoriteProductDTO(Long productId) {
		this.productId = productId;
	}
	public Long getProductId() {
		return productId;
	}
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	
}
