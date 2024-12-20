package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDetailDTO {
	private Long id;
    private String name;
    private Long price;
    private String image;
    private Long totalSold;
    private Double rating;
    private String video;

    public ProductDetailDTO(Long id, String name, Long price, String image, Long totalSold) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.totalSold = totalSold;
    }

    
    public ProductDetailDTO(Long id, String name, Long price, String image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
    }

    public ProductDetailDTO(Long id, String name,Double rating, String image, Long price) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.rating = rating;
    }


}
