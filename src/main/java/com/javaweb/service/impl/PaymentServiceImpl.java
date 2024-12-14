package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.entity.PaymentEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.IPaymentRepository;
import com.javaweb.service.IPaymentService;

@Service
public class PaymentServiceImpl implements IPaymentService{
	@Autowired
	private IPaymentRepository paymentRepository;
	
	@Override
	public void save(PaymentEntity payment) {
		paymentRepository.save(payment);
	}
	
	@Override
	public PaymentEntity findPaymentEntityByUserAndMethod(UserEntity user, String method) {
		return paymentRepository.findPaymentEntityByUserAndMethod(user, method);
	}
}
