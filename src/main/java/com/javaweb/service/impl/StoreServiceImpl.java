package com.javaweb.service.impl;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.javaweb.entity.StoreEntity;
import com.javaweb.repository.*;
import com.javaweb.service.IStoreService;
@Service
public class StoreServiceImpl implements IStoreService {

	  @Autowired
	    private IStoreRepository storeRepository;
	
	 // Tìm cửa hàng theo tên và phân trang
    public Page<StoreEntity> findByStoreName(String storeName, Pageable pageable) {
        // Sử dụng phương thức tìm kiếm theo tên (like query) trong repository
        return storeRepository.findByStoreNameContaining(storeName, pageable);
    }

    // Lấy tất cả các cửa hàng với phân trang
    public Page<StoreEntity> findAll(Pageable pageable) {
        // Lấy tất cả cửa hàng với phân trang
        return storeRepository.findAll(pageable);
    }
 // Phương thức tìm cửa hàng theo ID
    public Optional<StoreEntity> findById(Long storeId) {
        return storeRepository.findById(storeId);
    }
    // Phương thức lưu hoặc cập nhật cửa hàng
    public StoreEntity save(StoreEntity storeEntity) {
        return storeRepository.save(storeEntity); // Lưu lại cửa hàng (cập nhật nếu đã có ID)
    }
    public void deleteById(Long id)
    {
    	storeRepository.deleteById(id);
    }

	@Override
	public List<StoreEntity> findAll() {
		return storeRepository.findAll();
	}
}
