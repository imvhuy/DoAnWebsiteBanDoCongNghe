package com.javaweb.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.StoreProductEntity;
import com.javaweb.repository.IStoreProductRepository;
import com.javaweb.service.IStoreProductService;

@Service
public class StoreProductServiceImpl implements IStoreProductService {

	@Autowired
    private IStoreProductRepository storeProductRepository;
	
	@Override
	public Page<StoreProductEntity> findByStoreIdAndProductName(Long storeId, String name, Pageable pageable) {
		return storeProductRepository.findByStoreIdAndProduct_NameContaining(storeId, name, pageable);
	}

	@Override
	public Page<StoreProductEntity> findByStoreId(Long storeId, Pageable pageable) {
		return storeProductRepository.findByStoreId(storeId, pageable);
	}
	@Override
	
	public List<ProductEntity> getProductsByStore(Long storeId) {
	    List<StoreProductEntity> storeProducts = storeProductRepository.findByStoreId(storeId);
	    List<ProductEntity> products = new ArrayList<>();
	    
	    for (StoreProductEntity storeProduct : storeProducts) {
	        products.add(storeProduct.getProduct());  // Lấy thông tin sản phẩm từ StoreProductEntity
	    }

	    return products;
	}
//	@Override
//	public Page<ProductEntity> findProductsByStoreAndPage(Long storeId, Pageable pageable) {
//	    return storeProductRepository.findProductsByStore(storeId, pageable);
//	}
	
	public StoreProductEntity findById(Long storeproductID) {
        // Tìm sản phẩm theo ID, trả về Optional
        Optional<StoreProductEntity> storeProductOptional = storeProductRepository.findById(storeproductID);

        // Kiểm tra xem sản phẩm có tồn tại hay không
        if (storeProductOptional.isPresent()) {
            return storeProductOptional.get();  // Nếu có, trả về sản phẩm
        } else {
            throw new RuntimeException("StoreProduct with ID " + storeproductID + " not found");
            // Hoặc bạn có thể trả về null, hoặc ném một ngoại lệ khác tùy nhu cầu
        }
    }

    @Override
    public Long getTotalQuantityByProductId(Long productId) {
        return storeProductRepository.getTotalQuantityByProductId(productId);
    }

    @Override
    public Long getTotalSoldByProductId(Long productId) {
        return storeProductRepository.getTotalSoldByProductId(productId);
    }

}
