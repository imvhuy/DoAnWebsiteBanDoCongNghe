package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GalleryDTO {
    private Long id;


    private String image;

    private String type;

}
