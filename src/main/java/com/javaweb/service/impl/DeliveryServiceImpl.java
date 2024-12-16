package com.javaweb.service.impl;

import com.javaweb.entity.DeliveryEntity;
import com.javaweb.repository.IDeliveryRepository;
import com.javaweb.service.IDeliveryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeliveryServiceImpl implements IDeliveryService {
    @Autowired
    private IDeliveryRepository deliveryRepository;
    @Override
    public void save(DeliveryEntity delivery) {
        deliveryRepository.save(delivery);
    }
}
