package com.javaweb.service;

import com.javaweb.entity.StoreLevelEntity;

public interface IStoreLevelService {

	StoreLevelEntity findByMinPoint(Long points);
}
