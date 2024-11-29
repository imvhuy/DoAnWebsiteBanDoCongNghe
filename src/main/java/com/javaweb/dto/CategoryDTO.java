package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CategoryDTO extends BaseDTO {
    private Long id;
    private String name;
    private String slug;
    private String image;
    private Boolean isDeleted;
}
