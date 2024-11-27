package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    private Boolean isDeleted = false;

    @ManyToOne
    @JoinColumn(name = "attribute_id")
    private SubcategoryEntity subcategoryEntity;

    @ManyToOne
    @JoinColumn(name = "cart_item_id")
    private CartItemEntity cartItem;



}
