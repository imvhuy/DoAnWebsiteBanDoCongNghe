package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.javaweb.entity.CommissionEntity;
import com.javaweb.repository.ICommissionRepository;
import com.javaweb.service.ICommissionService;
import org.springframework.util.StringUtils;

@Service
public class CommissionServiceImpl implements ICommissionService {

	@Autowired
    private ICommissionRepository commissionRepository;
	
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

	@Override
	public <S extends CommissionEntity> S save(S entity) {
		 if(entity.getId() == null) {
	            return commissionRepository.save(entity);
	        }
	        else {
	            Optional<CommissionEntity> opt = findById(entity.getId());
	            if (opt.isPresent()) {
	                if(StringUtils.isEmpty(entity.getName())) {
	                    entity.setName(opt.get().getName());
	                }
	                else {
	                    entity.setName(entity.getName());
	                }
	            }
	        }
	        return commissionRepository.save(entity);
	}

    @Override
    public List<CommissionEntity> findAllById(Iterable<Long> ids) {
        return commissionRepository.findAllById(ids);
    }
    @Override
    public List<CommissionEntity> findAll(Sort sort) {
        return commissionRepository.findAll();
    }
}
