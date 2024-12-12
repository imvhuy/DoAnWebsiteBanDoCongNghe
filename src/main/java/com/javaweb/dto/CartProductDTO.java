package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartProductDTO {
	private Long id;
    private String name;
    private Long price;
    private String image;
    private Long quantity;
    private Long availableQuantity;
    
	public CartProductDTO(Long id, String name, Long price, String image, Long quantity) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.quantity = quantity;
	}
    
    
    

    
}
