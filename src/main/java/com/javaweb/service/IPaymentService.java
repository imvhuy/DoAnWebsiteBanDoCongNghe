package com.javaweb.service;

import com.javaweb.entity.PaymentEntity;
import com.javaweb.entity.UserEntity;

public interface IPaymentService {

	PaymentEntity findPaymentEntityByUserAndMethod(UserEntity user, String method);

	void save(PaymentEntity payment);

}
