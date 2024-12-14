package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "category")
public class CategoryEntity extends BaseEntity {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "nvarchar(50) not null unique")
    private String name;

    @Column(columnDefinition = "nvarchar(50) unique")
    private String slug;
    @Column(name = "image", columnDefinition = "nvarchar(500) null")
    private String image;
    private Boolean isDeleted;
    @OneToMany(mappedBy = "categoryEntity")
    private List<ProductEntity> products;
    
    @ToString.Exclude
    @OneToMany(mappedBy = "categoryEntity", cascade = CascadeType.ALL)
    private List<SubcategoryEntity> subcategoryEntities;




}
