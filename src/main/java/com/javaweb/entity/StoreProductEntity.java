package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="storeproduct")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class StoreProductEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "storeid")
    private StoreEntity store;

    @ManyToOne
    @JoinColumn(name = "productid")
    private ProductEntity product;

    private Integer quantity;


}
