package com.javaweb.service;

import com.javaweb.entity.GalleryEntity;

import java.util.List;

public interface IGalleryService {


    // Thêm ảnh vào sản phẩm

    void saveAll(List<GalleryEntity> galleryEntities); // Method to save multiple Gallery entities
    //
    // Xóa ảnh khỏi sản phẩm
    void deleteGalleryImage(Long id);
    void addGalleryImage(GalleryEntity galleryEntity);
}
