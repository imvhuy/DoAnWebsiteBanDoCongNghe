package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.service.IStoreLevelService;
import com.javaweb.entity.StoreLevelEntity;
import com.javaweb.repository.IStoreLevelRepository;
@Service
public class StoreLevelServiceImpl implements IStoreLevelService {

	 @Autowired
	    private IStoreLevelRepository storeLevelRepository;

	    // Tìm cấp độ của cửa hàng dựa trên điểm (kiểu int)
	    public StoreLevelEntity findByMinPoint(int points) {
	        // Tìm cấp độ có minPoint nhỏ nhất nhưng không lớn hơn điểm của cửa hàng
	        return storeLevelRepository
	            .findTopByMinPointLessThanEqualOrderByMinPointDesc(points)
	            .orElseThrow(() -> new RuntimeException("Store level not found for points: " + points));
	    }
}
