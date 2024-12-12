package com.javaweb.service.impl;

import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.IGalleryRepository;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements IProductService {
    @Autowired
    private IProductRepository IProductRepository;

    @Autowired
    private IGalleryRepository IGalleryRepository;

    public List<GalleryEntity> getGalleryByProductId(Long productId) {
        return IGalleryRepository.findByProductEntityId(productId);  // Tìm tất cả ảnh của sản phẩm
    }
    @Override
    public void delete(ProductEntity entity) {
        IProductRepository.delete(entity);
    }

    @Override
    public void deleteById(Long id) {
        IProductRepository.deleteById(id);
    }

    @Override
    public long count() {
        return IProductRepository.count();
    }

    @Override
    public List<ProductEntity> findAll() {
        return IProductRepository.findAll();
    }

    @Override
    public ProductEntity getProductById(Long id) {
        Optional<ProductEntity> product = IProductRepository.findById(id);
        return product.orElseThrow(() -> new RuntimeException("Product not found"));
    }
    @Override
    public <S extends ProductEntity> S save(S entity) {
        if (entity.getId() == null || entity.getId() == 0) {
            // Thêm mới
            return IProductRepository.save(entity);
        } else {
            // Cập nhật
            Optional<ProductEntity> existingProduct = findById(entity.getId());
            if (existingProduct.isPresent()) {
                ProductEntity existing = existingProduct.get();
                
                // Cập nhật tất cả các trường
                existing.setName(entity.getName());
                existing.setDescription(entity.getDescription());
                existing.setPrice(entity.getPrice());
                existing.setColor(entity.getColor());
                existing.setConfiguration(entity.getConfiguration());
                existing.setPromotionalPrice(entity.getPromotionalPrice());
                existing.setIsActive(entity.getIsActive());
                existing.setIsSelling(entity.getIsSelling());
                existing.setVideo(entity.getVideo());
                existing.setCategoryEntity(entity.getCategoryEntity());
                
                // Lưu xuống database
                return (S) IProductRepository.save(existing);
            }
        }
        return IProductRepository.save(entity);
    }

    @Override
    public Optional<ProductEntity> findById(Long id) {
        return IProductRepository.findById(id);
    }

    @Override
    public List<ProductEntity> findByNameContaining(String Name) {
        return IProductRepository.findByNameContaining(Name);
    }

    @Override
    public Page<ProductEntity> findByNameContaining(String Name, Pageable pageable) {
        return IProductRepository.findByNameContaining(Name, pageable);
    }

    @Override
    public Page<ProductEntity> findAll(Pageable pageable) {
        return IProductRepository.findAll(pageable);
    }

    @Override
    public List<ProductEntity> findAll(Sort sort) {
        return IProductRepository.findAll(sort);
    }

    @Override
    public List<ProductEntity> findAllById(Iterable<Long> id) {
        return IProductRepository.findAllById(id);
    }

    @Override
    public void deleteAll() {
        IProductRepository.deleteAll();
    }

    @Override
    public ProductEntity findByIdProductID(Long productId) {
        return IProductRepository.findById(productId).orElse(null);
    }
    @Override
    public Page<ProductEntity> findByNameContainingIgnoreCase(String name, Pageable pageable) {
        return IProductRepository.findByNameContainingIgnoreCase(name, pageable);
    }
}
