package com.javaweb.repository;

import com.javaweb.entity.NotificationEntity;
import com.javaweb.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface INotificationRepository extends JpaRepository<NotificationEntity, Long> {
    List<NotificationEntity> findByUserAndIsReadOrderByCreatedDateDesc(UserEntity user, Boolean isRead);

}
