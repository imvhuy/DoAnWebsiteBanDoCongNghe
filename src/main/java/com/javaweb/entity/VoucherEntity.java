package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.sql.Date;
import java.util.List;

@Entity
@Table(name = "voucher")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class VoucherEntity extends BaseEntity  {

	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "description", columnDefinition = "nvarchar(1000)")
    private String description;

    @Column(name = "discount", nullable = false)
    private Integer discount;

    @Column(name = "minimum_price", nullable = false)
    private Integer minimumPrice;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Temporal(TemporalType.DATE)
    @Column(name = "mfg_date")
    private Date mfgDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "exp_date")
    private Date expDate;

    // Quan hệ One-to-Many với VoucherCustomer
    @OneToMany(mappedBy = "voucher", cascade = CascadeType.ALL, orphanRemoval = true)
    @ToString.Exclude
    private List<VoucherCustomerEntity> voucherCustomerEntities ;
}
