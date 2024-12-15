package com.javaweb.service.impl;

import com.javaweb.entity.ShipperCarrierEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.IShipperCarrierRepository;
import com.javaweb.service.IShipperCarrierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShipperCarrierServiceImpl implements IShipperCarrierService {
    @Autowired
    private IShipperCarrierRepository shipperCarrierRepository;

    @Override
    public ShipperCarrierEntity getShipperByUserId(Long userId) {
        return shipperCarrierRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy Carrier cho Shipper này."));
    }

    @Override
    public List<UserEntity> getListOfShipperByCarrierId(Long carrierId) {
        return shipperCarrierRepository.getListOfShipperByCarrierId(carrierId);
    }

    @Override
    public void save(ShipperCarrierEntity shipperCarrier) {
        shipperCarrierRepository.save(shipperCarrier);
    }
}
