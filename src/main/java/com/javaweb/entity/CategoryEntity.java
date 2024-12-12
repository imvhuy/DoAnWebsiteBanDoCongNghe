package com.javaweb.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
    private String name;
    private String slug;
    @Column(name = "image", columnDefinition = "nvarchar(500) null")
    private String image;
    private Boolean isDeleted;
    @ToString.Exclude
    @OneToMany(mappedBy = "categoryEntity", cascade = CascadeType.ALL)
    private List<SubcategoryEntity> attributeEntities;


    @ToString.Exclude
    @JsonIgnore
    @OneToMany(mappedBy = "categoryEntity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProductEntity> products;

    @ToString.Exclude
    @OneToMany(mappedBy = "categoryEntity", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<SubcategoryEntity> subcategoryEntities;

}
