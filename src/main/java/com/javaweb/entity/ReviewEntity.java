package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="review")
public class ReviewEntity extends BaseEntity{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private ProductEntity product;
    
 // Thêm cột parent_id tham chiếu tới chính review này
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id", referencedColumnName = "id", nullable = true)
    private ReviewEntity parentReview;
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "storeid", nullable = false)
//    private StoreEntity store;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "orderId", nullable = false)
//    private OrderEntity order;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "rating", nullable = false)
    private int rating;

}
