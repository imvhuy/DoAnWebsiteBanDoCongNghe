package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductConfigurationDTO extends BaseDTO{
	private String categoryName;
	private String manufacturer;
	
}
