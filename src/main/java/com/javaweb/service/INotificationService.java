package com.javaweb.service;

import com.javaweb.entity.NotificationEntity;

import java.util.List;

public interface INotificationService {
    void createNotification(String message, Long userId);

    List<NotificationEntity> getUnreadNotifications(Long userId);

    void markAsRead(Long notificationId);

}
