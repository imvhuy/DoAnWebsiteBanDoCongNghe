package com.javaweb.dto;

import lombok.Data;

@Data
public class OrderStatisticsDTO {
    private String status;
    private Long totalOrders;
    private Double totalMoney;
}
