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
    public Page<StoreProductEntity> findByStoreIdAndProductNameAndCategoryId(Long storeId, String productName, Long categoryId, Pageable pageable) {
        return storeProductRepository.findByStoreIdAndProduct_NameContainingAndProduct_categoryEntity_id(storeId, productName, categoryId, pageable);
    }

    @Override
    public Page<StoreProductEntity> findByStoreIdAndCategoryId(Long storeId, Long categoryId, Pageable pageable) {
        return storeProductRepository.findByStoreIdAndProduct_categoryEntity_id(storeId, categoryId, pageable);
    }

    @Override
    public Optional<StoreProductEntity> findByStoreIdAndProductId(Long storeId, Long productId) {
        return storeProductRepository.findByStoreIdAndProductId(storeId, productId);
    }

    @Override
    public Long getTotalQuantityByProductId(Long productId) {
        return storeProductRepository.getTotalQuantityByProductId(productId);
    }

    @Override
    public Long getTotalSoldByProductId(Long productId) {
        return storeProductRepository.getTotalSoldByProductId(productId);
    }
    @Override
    public void save(StoreProductEntity storeProduct) {
        storeProductRepository.save(storeProduct);
    }

    @Override
    public void removeProductFromStore(Long storeId, Long productId) {
        StoreProductEntity storeProduct = storeProductRepository
                .findByStoreIdAndProductId(storeId, productId)
                .orElseThrow(() -> new RuntimeException("Product not found in the store"));
        storeProductRepository.delete(storeProduct);
    }
}
