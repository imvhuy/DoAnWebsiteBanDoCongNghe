package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "delivery")
public class DeliveryEntity extends BaseEntity{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String deliveryName;

    @Column(columnDefinition = "DECIMAL(10, 2)")
    private Double price;

    @Column(columnDefinition = "LONGTEXT")
    @Lob
    private String description;

    @ManyToOne
    @JoinColumn(name = "carrier_id")
    private CarrierEntity carrier;

    private Boolean isDeleted = false;

}
