package com.javaweb.repository;

import com.javaweb.entity.ShipperCarrierEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface IShipperCarrierRepository extends JpaRepository<ShipperCarrierEntity, Long> {
    Optional<ShipperCarrierEntity> findByUserId(Long userId);
}
