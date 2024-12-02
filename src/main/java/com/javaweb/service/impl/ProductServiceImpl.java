package com.javaweb.service.impl;

import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.IGalleryRepository;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ProductServiceImpl implements IProductService {
    @Autowired
    private IProductRepository productRepository;

    @Autowired
    private IGalleryRepository IGalleryRepository;

    public List<GalleryEntity> getGalleryByProductId(Long productId) {
        return IGalleryRepository.findByProductEntityId(productId);  // Tìm tất cả ảnh của sản phẩm
    }
    @Override
    public void delete(ProductEntity entity) {
        productRepository.delete(entity);
    }

    @Override
    public Page<ProductEntity> findByCategoryEntity_IdAndIsActive(Long categoryId, boolean IsActive, Pageable pageable) {
        return productRepository.findByCategoryEntity_IdAndIsActive(categoryId, IsActive, pageable);
    }

    @Override
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public long count() {
        return productRepository.count();
    }

    @Override
    public List<ProductEntity> findAll() {
        return productRepository.findAll();
    }

    @Override
    public ProductEntity getProductById(Long id) {
        Optional<ProductEntity> product = productRepository.findById(id);
        return product.orElseThrow(() -> new RuntimeException("Product not found"));
    }
    @Override
    public <S extends ProductEntity> S save(S entity) {
        if (entity.getId() == null) {
            // Thêm mới
            return productRepository.save(entity);
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
                existing.setSold(entity.getSold());
                existing.setIsActive(entity.getIsActive());
                existing.setIsSelling(entity.getIsSelling());
                existing.setVideo(entity.getVideo());
                existing.setCategoryEntity(entity.getCategoryEntity());
                
                // Lưu xuống database
                return (S) productRepository.save(existing);
            }
        }
        return productRepository.save(entity);
    }

    @Override
    public Optional<ProductEntity> findById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    public List<ProductEntity> findByNameContaining(String Name) {
        return productRepository.findByNameContaining(Name);
    }

    @Override
    public Page<ProductEntity> findByNameContaining(String Name, Pageable pageable) {
        return productRepository.findByNameContaining(Name, pageable);
    }

    @Override
    public Page<ProductEntity> findAll(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Override
    public List<ProductEntity> findAll(Sort sort) {
        return productRepository.findAll(sort);
    }

    @Override
    public List<ProductEntity> findAllById(Iterable<Long> id) {
        return productRepository.findAllById(id);
    }

    @Override
    public void deleteAll() {
        productRepository.deleteAll();
    }

    @Override
    public com.javaweb.model.ProductDTO convertToModel(ProductEntity entity) {
        com.javaweb.model.ProductDTO model = new com.javaweb.model.ProductDTO();
        BeanUtils.copyProperties(entity, model);
        
        // Map gallery images
        Map<String, String> gallery = new HashMap<>();
        if (entity.getGalleryEntities() != null) {
            for (GalleryEntity galleryEntity : entity.getGalleryEntities()) {
                gallery.put(galleryEntity.getType(), galleryEntity.getImage());
            }
        }
        model.setGallery(gallery);
        
        return model;
    }
    @Override
    public List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long categoryId, Boolean isActive) {
        return productRepository.findAllByCategoryEntity_IdAndIsActive(categoryId, isActive);
    }
}
