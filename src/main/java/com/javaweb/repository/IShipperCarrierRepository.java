package com.javaweb.repository;

import com.javaweb.entity.ShipperCarrierEntity;
import com.javaweb.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface IShipperCarrierRepository extends JpaRepository<ShipperCarrierEntity, Long> {
    Optional<ShipperCarrierEntity> findByUserId(Long userId);

    @Query("SELECT u FROM ShipperCarrierEntity s " +
            "JOIN s.user u " +
            "WHERE s.carrier.id = :id ")
    List<UserEntity> getListOfShipperByCarrierId(@Param("id") Long id);
    List<ShipperCarrierEntity> findAllByUserId(Long userId);
}
