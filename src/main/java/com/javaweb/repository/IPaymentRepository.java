package com.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.javaweb.entity.PaymentEntity;
import com.javaweb.entity.UserEntity;
import java.util.List;

@Repository
public interface IPaymentRepository extends JpaRepository<PaymentEntity, Long>{
	PaymentEntity findPaymentEntityByUserAndMethod(UserEntity user, String method);
}
