package com.javaweb.service;

import com.javaweb.entity.AddressEntity;
import com.javaweb.dto.AddressDTO;

import java.util.List;
import java.util.Optional;

public interface IAddressService {
    // Lấy danh sách các địa chỉ của một user
    List<AddressEntity> getAddressesByUserId(Long userId);

    // Thêm một địa chỉ mới cho user
    <S extends AddressEntity> S save(S entity);

    // Cập nhật địa chỉ mặc định
    AddressEntity setDefaultAddress(Long userId, Long addressId);

    // Lấy địa chỉ mặc định
    Optional<AddressEntity> getDefaultAddress(Long userId);
    Optional<AddressEntity> findById(Long id);
    AddressDTO findAddressModelById(Long id);

    void deleteAddressById(Long addressId);
}
