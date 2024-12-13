package com.javaweb.service;

import com.javaweb.entity.StoreLevelEntity;

public interface IStoreLevelService {

	public StoreLevelEntity findByMinPoint(int points);
}
