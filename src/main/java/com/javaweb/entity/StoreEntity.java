package com.javaweb.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
    private String name;

    @Column(name = "bio")
    private String bio;

    private String address;

    @Column(name = "isActive")
    private Boolean isActive = false;

    @Column(name = "isOpen")
    private Boolean isOpen = false;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "point")
    private Integer point;

    @Column(name = "rating")
    private Integer  rating;

    @ManyToOne
    @ToString.Exclude
    @JoinColumn(name = "ownerid")
    private UserEntity owner;


    @ToString.Exclude
    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL)
    private List<StoreProductEntity> storeProduct;

    @OneToOne
    @JoinColumn(name = "commissionid")
    @ToString.Exclude
    private CommissionEntity commission;

}