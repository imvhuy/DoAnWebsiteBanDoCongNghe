package com.javaweb.dto;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ReviewEntity;
import com.javaweb.entity.StoreEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDetailDTO {
    private Long id;
    private String name;
    private String description;
    private Long price;
    private String color;
    private String configuration;
    private Long promotionalPrice;
    private Long sold;
    private Boolean isActive;
    private Boolean isSelling;
    private String video;

    private CategoryEntity category;

    private List<GalleryEntity> galleryEntities;

    private Long categoryId;
    private String categoryName; // Trường để lưu tên danh mục (category name)
    private String frontImage;
    private String behindImage;
    private String rightImage;
    private String leftImage;
    // Phương thức này sẽ lấy tên của danh mục

    private Map<String, String> gallery; // Thêm field này để lưu đường dẫn ảnh

    // Getter và setter cho gallery
    public Map<String, String> getGallery() {
        if (gallery == null) {
            gallery = new HashMap<>();
        }
        return gallery;
    }

    private Long totalQuantity; // Thêm trường này
}
