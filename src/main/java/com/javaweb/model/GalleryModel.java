package com.javaweb.model;

import com.javaweb.entity.ProductEntity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GalleryModel extends BaseModel{
    private Long id;


    private String image;

    private String type;

}
