package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.mapping.Join;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "orders")
public class OrderEntity extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "nvarchar(500)")
    private String address;

    @Column(columnDefinition = "nvarchar(50)")
    private String status;

    @Column(columnDefinition = "DECIMAL(10,2)")
    private Double amountFromUser;

    @Column(columnDefinition = "DECIMAL(10,2)")
    private Double amountToStore;

    @Column(columnDefinition = "DECIMAL(10,2)")
    private Double amountToGD;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;


}
