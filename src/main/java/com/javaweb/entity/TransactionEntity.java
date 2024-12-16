package com.javaweb.entity;
import java.io.Serializable;
import com.javaweb.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "transactions")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class TransactionEntity extends BaseEntity {

    private static final long serialVersionUID = 1;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    @ToString.Exclude
    private OrderEntity order;

    @ManyToOne
    @JoinColumn(name = "payment_id")
    @ToString.Exclude
    private PaymentEntity payment;

    @Column(name = "ispaid")
    private Boolean isPaid;

    @Column(name = "amount", columnDefinition = "Decimal(15, 2)")
    private Double amount;
}