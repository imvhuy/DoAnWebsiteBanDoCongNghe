package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartProductDTO {
	//id cua cartitem
	private Long carItemtId;
	//id cua product
	private Long id;
    private String name;
    private Long price;
    private String image;
    private Long quantity;
    private Long availableQuantity;
    private Long promotionalPrice;
    
	public CartProductDTO( Long carItemtId,Long id, String name, Long price, String image, Long quantity,Long promotionalPrice) {
		this.carItemtId = carItemtId;
		this.id = id;
		this.name = name;
		this.price = price;
		this.image = image;
		this.quantity = quantity;
		this.promotionalPrice= promotionalPrice;
	}
    
    
    

    
}
