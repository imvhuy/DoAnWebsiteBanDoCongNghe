package com.javaweb.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.dto.ProductDTO;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IProductService;

import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.IGalleryRepository;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@Service
public class ProductServiceImpl implements IProductService{
	@Autowired
    private IProductRepository productRepository;
	@Override
	public List<ProductDetailDTO> findLatestProductInThisMonth(Date date){
		return productRepository.findLatestProductInThisMonth(date);
	}
	
	 @Override
	public List<ProductDetailDTO> findTopSellingProducts(Pageable pageable){
		 return productRepository.findTopSellingProducts(pageable);
	 }
	 
	 @Override
	public List<ProductDetailDTO> findTopTotalRatingProducts(Pageable pageable){
		 return productRepository.findTopTotalRatingProducts(pageable);
	 }


	 @Autowired
	    private IGalleryRepository galleryRepository;

	    public List<GalleryEntity> getGalleryByProductId(Long productId) {
	        return galleryRepository.findByProductEntityId(productId);  // Tìm tất cả ảnh của sản phẩm
	    }
		
	    @Override
	    public void delete(ProductEntity entity) {
	        productRepository.delete(entity);
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
	    public ProductDTO convertToDTO(ProductEntity entity) {
	        ProductDTO model = new ProductDTO();
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
		public Long countTotalAvailableQuantityOfProduct(Long id) {
	    	return productRepository.countTotalAvailableQuantityOfProduct(id);
	    }

    

    @Override
    public ProductEntity findByIdProductID(Long productId) {
        return IProductRepository.findById(productId).orElse(null);
    }

