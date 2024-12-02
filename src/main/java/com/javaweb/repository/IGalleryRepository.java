package com.javaweb.repository;

import com.javaweb.entity.GalleryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IGalleryRepository extends JpaRepository<GalleryEntity, Long> {
    List<GalleryEntity> findByProductEntityId(Long productId);
    Optional<GalleryEntity> findByProductEntityIdAndType(Long productId, String type);
}
