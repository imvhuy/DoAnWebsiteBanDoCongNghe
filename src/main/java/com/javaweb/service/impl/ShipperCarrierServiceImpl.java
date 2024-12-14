package com.javaweb.service.impl;

import com.javaweb.entity.ShipperCarrierEntity;
import com.javaweb.repository.IShipperCarrierRepository;
import com.javaweb.service.IShipperCarrierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShipperCarrierServiceImpl implements IShipperCarrierService {
    @Autowired
    private IShipperCarrierRepository shipperCarrierRepository;

    @Override
    public ShipperCarrierEntity getShipperByUserId(Long userId) {
        return shipperCarrierRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy Carrier cho Shipper này."));
    }
}
