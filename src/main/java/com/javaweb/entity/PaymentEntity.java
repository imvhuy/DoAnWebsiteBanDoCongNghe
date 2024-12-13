package com.javaweb.entity;
import java.io.Serializable;
import java.util.List;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="Payment")

public class PaymentEntity extends BaseEntity {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    private String method;
    
    @OneToMany(mappedBy = "payment", orphanRemoval = false)
    private List<TransactionEntity> transactions;
    @PreRemove
    private void preRemove() {
        // Hủy liên kết với tất cả các transactions trước khi xóa payment
        for (TransactionEntity transaction : transactions) {
        	transaction.setPayment(null);
        }
    }
}
