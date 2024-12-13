package com.javaweb.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.javaweb.entity.VoucherEntity;
import com.javaweb.repository.IPromotionRepository;
import com.javaweb.service.IPromotionService;
@Service

public class PromotionServiceImpl implements IPromotionService {
	private final IPromotionRepository promotionRepository;
	@Autowired
	public PromotionServiceImpl(IPromotionRepository promotionRepository) {
	    this.promotionRepository = promotionRepository;
	}

	    @Override
	    public void delete(VoucherEntity entity) {
	        promotionRepository.delete(entity);
	    }

	    @Override
	    public void deleteById(Long id) {
	        promotionRepository.deleteById(id);
	    }

	    @Override
	    public long count() {
	        return promotionRepository.count();
	    }

	    @Override
	    public List<VoucherEntity> findAll() {
	        return promotionRepository.findAll();
	    }

public VoucherEntity save(VoucherEntity entity) {
    if (entity.getId() == null) {
        // Đây là một bản ghi mới, chỉ cần lưu
        return promotionRepository.save(entity);
    } else {
        // Đối tượng cần cập nhật
        Optional<VoucherEntity> opt = findById(entity.getId());
        if (opt.isPresent()) {
            VoucherEntity existingEntity = opt.get();

            // Cập nhật tất cả các trường của existingEntity từ entity
            existingEntity.setDescription(entity.getDescription() != null ? entity.getDescription() : existingEntity.getDescription());
            existingEntity.setDiscount(entity.getDiscount() != null ? entity.getDiscount() : existingEntity.getDiscount());
            existingEntity.setMinimumPrice(entity.getMinimumPrice() != null ? entity.getMinimumPrice() : existingEntity.getMinimumPrice());
            existingEntity.setQuantity(entity.getQuantity() != null ? entity.getQuantity() : existingEntity.getQuantity());
            existingEntity.setMfgDate(entity.getMfgDate() != null ? entity.getMfgDate() : existingEntity.getMfgDate());
            existingEntity.setExpDate(entity.getExpDate() != null ? entity.getExpDate() : existingEntity.getExpDate());
            // Cập nhật thêm các trường khác tương tự như vậy nếu có

            // Lưu đối tượng đã được cập nhật
            return promotionRepository.save(existingEntity);
        } else {
            // Không tìm thấy đối tượng, có thể ném ngoại lệ hoặc lưu như bản ghi mới
            return promotionRepository.save(entity);
        }
    }
}

	    @Override
	    public Optional<VoucherEntity> findById(Long id) {
	        return promotionRepository.findById(id);
	    }

	    @Override
	    public List<VoucherEntity> findByDescriptionContainingIgnoreCase(String description) {
	        return promotionRepository.findByDescriptionContainingIgnoreCase(description);
	    }

	    @Override
	    public Page<VoucherEntity> findByDescriptionContainingIgnoreCase(String description, Pageable pageable) {
	        return promotionRepository.findByDescriptionContainingIgnoreCase(description, pageable);
	    }

	    @Override
	    public Page<VoucherEntity> findAll(Pageable pageable) {
	        return promotionRepository.findAll(pageable);
	    }

	    @Override
	    public List<VoucherEntity> findAll(Sort sort) {
	        return promotionRepository.findAll(sort);
	    }

	    @Override
	    public List<VoucherEntity> findAllById(Iterable<Long> ids) {
	        return promotionRepository.findAllById(ids);
	    }

	    @Override
	    public void deleteAll() {
	        promotionRepository.deleteAll();
	    }
	    

	
	
}
