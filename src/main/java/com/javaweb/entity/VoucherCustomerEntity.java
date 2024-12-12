package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "vouchercustomer")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class VoucherCustomerEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

   //Quan hệ Many-to-One với UserEntity
	@ManyToOne
	@JoinColumn(name = "CustomerId", nullable = false, referencedColumnName = "id")
	private UserEntity user;


    // Quan hệ Many-to-One với Voucher
	 @ManyToOne
	    @JoinColumn(name = "VoucherId", nullable = false)
	    private VoucherEntity voucher;
	 
    @Column(name = "status", nullable = false)
    private String status;
    
    
}
