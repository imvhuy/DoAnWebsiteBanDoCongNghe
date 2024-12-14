package com.javaweb.service;

import com.javaweb.entity.ShipperCarrierEntity;

public interface IShipperCarrierService {
    ShipperCarrierEntity getShipperByUserId(Long id);
}
