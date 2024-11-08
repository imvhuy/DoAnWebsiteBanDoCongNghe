package com.javaweb.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CarrierModel extends BaseModel{
    private Long id;

    private String name;

    private Long price;
}
