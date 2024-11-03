package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "stylevalue")
public class StyleValueEntity extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String name;

    private Boolean isDeleted = false;

    @ManyToOne
    @JoinColumn(name = "styleid")
    private StyleEntity styleEntity;

    @ManyToOne
    @JoinColumn(name = "cartItemId")
    private CartItemEntity cartItem;

}
