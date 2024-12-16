package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;
import java.util.Set;

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


    private Boolean isActive;

    private Boolean isSelling;

    private String video;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private CategoryEntity categoryEntity;

    @ToString.Exclude
    @OneToMany(mappedBy = "productEntity", cascade = CascadeType.ALL)
    private List<GalleryEntity> galleryEntities;

    @ToString.Exclude
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<StoreProductEntity> productStore;

    @ToString.Exclude
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ReviewEntity> rating;
    
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<OrderItemEntity> orderItems;
    
    @OneToMany(mappedBy = "product")
    private List<FavoriteProductEntity> favortieProductEntitys;
    

    @ManyToMany
    @JoinTable(
            name = "product_sub_cat_value",  // Tên bảng nối
            joinColumns = @JoinColumn(name = "product_id"),  // Cột khóa ngoại cho Product
            inverseJoinColumns = @JoinColumn(name = "sub_cat_value_id")  // Cột khóa ngoại cho SubCategoryValue
    )
    private List<SubcategoryValueEntity> subCategoryValues;


}
