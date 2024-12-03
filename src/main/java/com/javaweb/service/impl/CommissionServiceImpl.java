package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.javaweb.entity.CommissionEntity;
import com.javaweb.repository.CommissionRepository;
import com.javaweb.service.ICommissionService;
@Service
public class CommissionServiceImpl implements ICommissionService {

	@Autowired
    private CommissionRepository commissionRepository;
	
	public CommissionEntity saveCommission(CommissionEntity commissionEntity) {
	    // Kiểm tra nếu commissionEntity đã có ID thì sẽ cập nhật, nếu không thì tạo mới
	    if (commissionEntity.getId() != null) {
	        // Nếu có ID, tức là bản ghi đã tồn tại và chúng ta cần cập nhật
	        return commissionRepository.save(commissionEntity);  // Trả về bản ghi đã lưu
	    } else {
	        // Nếu không có ID, tức là bản ghi mới và cần thêm vào cơ sở dữ liệu
	        return commissionRepository.save(commissionEntity);  // Trả về bản ghi đã lưu
	    }
	}

	@Override
	public List<CommissionEntity> findAll() {
		return commissionRepository.findAll();
	}

	@Override
	public Optional<CommissionEntity> findById(Long ID) {
	   
	    return commissionRepository.findById(ID);
	    
	}
	@Override
	public Page<CommissionEntity> findAll(Pageable pageable) {
	    return commissionRepository.findAll(pageable);
	}

	@Override
	public void deleteById(Long id) {
		
		commissionRepository.deleteById(id);
	}
	
}
