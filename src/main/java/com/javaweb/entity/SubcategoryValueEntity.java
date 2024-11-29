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
@Table(name = "subcategory_value")
public class SubcategoryValueEntity extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "value", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String value;

    private String slug;

    private Boolean isDeleted = false;

    @ManyToOne
    @JoinColumn(name = "subcategory_id")
    private SubcategoryEntity subcategoryEntity;

    @ManyToOne
    @JoinColumn(name = "cart_item_id")
    private CartItemEntity cartItem;

    @ManyToMany(mappedBy = "subCategoryValues")
    private Set<ProductEntity> products;

}
