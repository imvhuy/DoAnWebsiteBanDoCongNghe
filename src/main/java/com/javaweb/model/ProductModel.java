package com.javaweb.model;

import com.javaweb.entity.ReviewEntity;
import com.javaweb.entity.StoreEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductModel {
    private Long id;

    private String name;

    private String description;

    private Double price;

    private Double promotionalPrice;

    private Long quantity;

    private Long sold;

    private Boolean isActive;

    private Boolean isSelling;

    private String video;

    private Long styleValueId;

    private StoreEntity store;

}
