package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CarrierDTO extends BaseDTO{
    private Long id;

    private String name;

    private Long price;
}
