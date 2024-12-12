package com.javaweb.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.javaweb.entity.*;

public interface IStoreRepository  extends JpaRepository<StoreEntity, Long>{

	
	 // Tìm cửa hàng theo tên (sử dụng 'Containing' để tìm theo chuỗi có trong tên)
    Page<StoreEntity> findByStoreNameContaining(String storeName, Pageable pageable);
}
