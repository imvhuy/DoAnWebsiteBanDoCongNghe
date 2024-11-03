package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "userlevel")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserLevelEntity extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nameUserLevel", columnDefinition = "nvarchar(255) not null")
    private String name;

    @Column(name = "minpoint", columnDefinition = "Double(10,2)")
    private Double minPoint;

    @Column(name = "discount", columnDefinition = "Double(10,2)")
    private Double discount;

    @Column(name = "is_deleted", columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean isDeleted = false;



}
