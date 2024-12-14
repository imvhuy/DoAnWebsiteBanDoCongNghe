package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "notifications")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationEntity extends BaseEntity{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String message; // Nội dung thông báo

    @Column(name = "is_read", nullable = false)
    private Boolean isRead = false; // Trạng thái đã đọc

    @ManyToOne
    @JoinColumn(name = "user_id") // Người nhận thông báo
    private UserEntity user;
}
