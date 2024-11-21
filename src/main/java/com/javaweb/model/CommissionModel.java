package com.javaweb.model;

import com.javaweb.entity.StoreEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class CommissionModel  extends BaseModel{

    private Long id;
    private String name;
    private Double cost;
    private String description;
    private Boolean isDeleted;
    private StoreEntity store;

}
