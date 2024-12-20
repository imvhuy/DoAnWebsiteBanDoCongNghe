package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "carrier")
public class CarrierEntity extends BaseEntity{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private Long price;

    @OneToMany(mappedBy = "carrier", cascade = CascadeType.ALL)
    private List<DeliveryEntity> carriers;

    @OneToMany(mappedBy = "carrier", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ShipperCarrierEntity> shippers;

}
