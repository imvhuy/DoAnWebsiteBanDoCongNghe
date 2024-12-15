package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class PaymentDTO {
    private String totalPrice;
    private String voucher;
    private String address;
    private String paymentMethod;
    private String carrierId;
}
