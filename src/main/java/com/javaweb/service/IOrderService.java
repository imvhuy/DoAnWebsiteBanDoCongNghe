package com.javaweb.service;

import com.javaweb.entity.UserEntity;

public interface IOrderService {

	Boolean createOrderForStore(UserEntity user, Long userAddressId);

	void createOrders(Long userId,Long carrierId,Long address,String method);

}
