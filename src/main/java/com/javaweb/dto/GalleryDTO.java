package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GalleryDTO extends BaseDTO {
    private Long id;


    private String image;

    private String type;


    public GalleryDTO( String image, String type) {
        this.image = image;
        this.type = type;
    }
}
