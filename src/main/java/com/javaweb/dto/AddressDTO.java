package com.javaweb.dto;

import com.javaweb.entity.UserEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddressDTO {
    private Long id;
    private String fullName;
    private String address;
    private String street;
    private String ward;
    private String district;
    private String phone;
    private String province;

    private Boolean isDefault = false;
    private UserEntity user;
}
