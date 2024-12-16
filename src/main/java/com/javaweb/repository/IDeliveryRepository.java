package com.javaweb.repository;


import com.javaweb.entity.DeliveryEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IDeliveryRepository extends JpaRepository<DeliveryEntity, Long> {
}
