package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="commission")
public class CommissionEntity extends BaseEntity{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String name;
    private Double cost;

    @Column(columnDefinition = "LONGTEXT")
    @Lob
    private String description;

    private Boolean isDeleted;

    @OneToOne(mappedBy = "commission")
    private StoreEntity store;

}
