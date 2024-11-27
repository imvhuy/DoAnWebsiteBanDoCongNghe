package com.javaweb.dto;

public class ProductDTO {
	private Long productId;
    private String productName;
    private Double price;
    private String image;
    private Long totalSold;

    // Constructor
    public ProductDTO(Long productId, String productName, Double price, String image,Long totalSold) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.image = image;
        this.totalSold = totalSold;
    }

    // Getters and Setters
    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

	public Long getTotalSold() {
		return totalSold;
	}

	public void setTotalSold(Long totalSold) {
		this.totalSold = totalSold;
	}
    
}
