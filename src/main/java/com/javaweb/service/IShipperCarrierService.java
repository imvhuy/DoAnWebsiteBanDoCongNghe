package com.javaweb.service;

import com.javaweb.entity.ShipperCarrierEntity;
import com.javaweb.entity.UserEntity;

import java.util.List;

public interface IShipperCarrierService {
    ShipperCarrierEntity getShipperByUserId(Long id);

    List<UserEntity> getListOfShipperByCarrierId(Long carrierId);

    void save(ShipperCarrierEntity shipperCarrier);
}
