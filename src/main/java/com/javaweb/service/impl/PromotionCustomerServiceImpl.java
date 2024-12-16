package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.entity.VoucherCustomerEntity;
import com.javaweb.repository.IPromotionCustomerRepository;
import com.javaweb.service.IPromotionCustomerService;

@Service
public class PromotionCustomerServiceImpl implements IPromotionCustomerService{

	@Autowired
	IPromotionCustomerRepository promotionCustomerRepository;
	@Override
	public void save(VoucherCustomerEntity voucherCustomer) {
		promotionCustomerRepository.save(voucherCustomer);
	}
}
