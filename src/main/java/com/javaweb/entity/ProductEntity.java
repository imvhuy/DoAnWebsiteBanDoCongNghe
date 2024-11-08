package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "product")
public class ProductEntity extends BaseEntity {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String productName;

    @Column(columnDefinition = "LONGTEXT")
    @Lob
    private String description;

    private Double price;

    private Double promotionalPrice;

    private Long quantity;

    private Long sold;

    private Boolean isActive;

    private Boolean isSelling;

    private String video;

//    @OneToMany(mappedBy = "productEntity", cascade = CascadeType.ALL)
//    private List<GalleryEntity> galleryEntities;

    private Long styleValueId;

    private Long StoreId;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ReviewEntity> rating;

}
