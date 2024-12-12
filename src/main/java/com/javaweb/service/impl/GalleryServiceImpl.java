package com.javaweb.service.impl;

import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.IGalleryRepository;
import com.javaweb.repository.IProductRepository;
import com.javaweb.service.IGalleryService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class GalleryServiceImpl implements IGalleryService {

    @Autowired
    private IGalleryRepository galleryRepository;
    @Autowired
    private IProductRepository productRepository;

    public Optional<GalleryEntity> findByProductAndType(Long productId, String type) {
        return  galleryRepository.findByProductEntityIdAndType(productId, type);
    }

    public GalleryEntity save(GalleryEntity gallery) {
        return  galleryRepository.save(gallery);
    }


    @Override
    public void saveAll(List<GalleryEntity> galleryEntities) {
        galleryRepository.saveAll(galleryEntities);
    }

    // Xóa ảnh khỏi sản phẩm
    @Override
    public void deleteGalleryImage(Long id) {
        galleryRepository.deleteById(id);
    }

    @Override
    public void saveGalleryImage(MultipartFile file, String type, Long productId) {
        // Lấy tên file và tạo tên file duy nhất để tránh trùng lặp
        String fileName = file.getOriginalFilename();  // Hoặc bạn có thể tạo một tên duy nhất bằng UUID
        if (fileName == null || fileName.isEmpty()) {
            throw new RuntimeException("No file selected for upload");
        }

        // Lưu tên ảnh vào cơ sở dữ liệu, không cần phải chuyển file vào thư mục
        // Lấy sản phẩm từ ID
        ProductEntity product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Tạo và lưu đối tượng GalleryEntity
        GalleryEntity gallery = new GalleryEntity();
        gallery.setImage(fileName);  // Lưu tên ảnh vào database
        gallery.setType(type);  // Loại ảnh: "main", "additional"
        gallery.setProductEntity(product);

        galleryRepository.save(gallery);  // Lưu vào database

    }


    @Override
    public List<GalleryEntity> getGalleryByProductId(Long productId) {
        return  galleryRepository.findByProductEntityId(productId);
    }

    @Override
    public Optional<GalleryEntity> findByImage(String imageName) {
        return Optional.empty();
    }

    @Override
    public List<GalleryEntity> findByProductId(Long id) {
        return List.of();
    }

    @Override
    public void delete(GalleryEntity gallery) {
        galleryRepository.delete(gallery);
    }
}
