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

    private String name;

    @Column(columnDefinition = "LONGTEXT")
    @Lob
    private String description;

    private Long price;

    private String color;

    @Column(columnDefinition = "LONGTEXT")
    @Lob
    private String configuration;

    private Long promotionalPrice;

    private Long sold;

    private Boolean isActive;

    private Boolean isSelling;

    private String video;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private CategoryEntity categoryEntity;

    @OneToMany(mappedBy = "productEntity", cascade = CascadeType.ALL)
    private List<GalleryEntity> galleryEntities;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<StoreProductEntity> productStore;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ReviewEntity> rating;



}