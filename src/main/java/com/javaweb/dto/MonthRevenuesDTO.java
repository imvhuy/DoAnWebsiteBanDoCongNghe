package com.javaweb.dto;

import java.util.Date;

import com.javaweb.entity.UserEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MonthRevenuesDTO extends BaseDTO{
	private Integer month;
	private Double total;
	
	
}
