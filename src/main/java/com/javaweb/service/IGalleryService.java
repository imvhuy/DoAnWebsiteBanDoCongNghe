package com.javaweb.service;

import com.javaweb.entity.GalleryEntity;
import com.javaweb.repository.IGalleryRepository;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

public interface IGalleryService {


    // Thêm ảnh vào sản phẩm

    void saveAll(List<GalleryEntity> galleryEntities); // Method to save multiple Gallery entities
    //
    // Xóa ảnh khỏi sản phẩm
    void deleteGalleryImage(Long id);


    void saveGalleryImage(MultipartFile file, String type, Long productId);
    List<GalleryEntity> getGalleryByProductId(Long productId);

    Optional<GalleryEntity> findByImage(String imageName);

    List<GalleryEntity> findByProductId(Long id);

    void delete(GalleryEntity gallery);
}
