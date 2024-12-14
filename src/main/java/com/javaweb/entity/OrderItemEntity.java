package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "orderitem")
public class OrderItemEntity  extends BaseEntity{
	
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    
    @ManyToOne
    @JoinColumn(name = "orderId")
    private OrderEntity  order;
    
    @ManyToOne
    @JoinColumn(name = "productId")
    private ProductEntity  product;
    
    
    private int count;
}
