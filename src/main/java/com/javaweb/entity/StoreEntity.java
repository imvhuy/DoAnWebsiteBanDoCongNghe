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
@Table(name="store")
public class StoreEntity extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, unique = true)
    private String storeName;

    @Column(name = "bio")
    private String bio;

    @Column(name = "isActive")
    private Boolean isActive;

    @Column(name = "isOpen")
    private Boolean isOpen;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "point")
    private int point;

    @Column(name = "rating")
    private int  rating;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    private List<StoreProductEntity> storeProduct;

    @OneToOne
    @JoinColumn(name = "commissionid")
    private CommissionEntity commission;


}