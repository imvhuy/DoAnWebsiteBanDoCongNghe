package com.javaweb.service.impl;

import com.javaweb.entity.GalleryEntity;
import com.javaweb.repository.IGalleryRepository;
import com.javaweb.service.IGalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class GalleryServiceImpl implements IGalleryService {

    @Autowired
    private IGalleryRepository IGalleryRepository;

    public Optional<GalleryEntity> findByProductAndType(Long productId, String type) {
        return IGalleryRepository.findByProductEntityIdAndType(productId, type);
    }

    public GalleryEntity save(GalleryEntity gallery) {
        return IGalleryRepository.save(gallery);
    }

    // Thêm ảnh vào sản phẩm
    @Override
    public void addGalleryImage(GalleryEntity galleryEntity) {
        IGalleryRepository.save(galleryEntity); // Save a single gallery image
    }


    @Override
    public void saveAll(List<GalleryEntity> galleryEntities) {
        IGalleryRepository.saveAll(galleryEntities);
    }

    // Xóa ảnh khỏi sản phẩm
    @Override
    public void deleteGalleryImage(Long id) {
        IGalleryRepository.deleteById(id);
    }
}
