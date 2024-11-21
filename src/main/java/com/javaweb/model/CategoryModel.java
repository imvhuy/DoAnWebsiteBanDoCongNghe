package com.javaweb.model;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CategoryModel extends BaseModel{
    private Long id;
    private String name;
    private String slug;
    private String image;
    private Boolean isDeleted;
}
