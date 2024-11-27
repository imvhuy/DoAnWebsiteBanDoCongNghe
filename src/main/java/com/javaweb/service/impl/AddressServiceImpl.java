package com.javaweb.service.impl;

import com.javaweb.dto.AddressDTO;
import com.javaweb.entity.AddressEntity;
import com.javaweb.repository.IAddressRepository;
import com.javaweb.repository.IUserRepository;
import com.javaweb.service.IAddressService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
public class AddressServiceImpl implements IAddressService {
    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IAddressRepository addressRepository;

    // Lấy danh sách các địa chỉ của một user
    @Override
    public List<AddressEntity> getAddressesByUserId(Long userId) {
        return addressRepository.findByUserId(userId);
    }

    // Thêm một địa chỉ mới cho user


    @Override
    public <S extends AddressEntity> S save(S entity) {
        if(entity.getId() == null) {
            return addressRepository.save(entity);
        }
        else {
            Optional<AddressEntity> opt = findById(entity.getId());
            if (opt.isPresent()) {
                if(StringUtils.isEmpty(entity.getUser())) {
                    entity.setUser(opt.get().getUser());
                }
                else {
                    entity.setUser(entity.getUser());
                }
            }
        }
        return addressRepository.save(entity);
    }

    @Override
    public Optional<AddressEntity> findById(Long id) {
        return addressRepository.findById(id);
    }

    @Override
    public AddressDTO findAddressModelById(Long id) {
        Optional<AddressEntity> addressEntity = addressRepository.findById(id);
        if (addressEntity.isPresent()) {
            String[] parts = addressEntity.get().getAddress().split(", ");
            AddressDTO addressModel = new AddressDTO();
            BeanUtils.copyProperties(addressEntity.get(), addressModel);
            if (parts.length == 4) {
                addressModel.setStreet(parts[0].trim());
                addressModel.setWard(parts[1].trim());
                addressModel.setDistrict(parts[2].trim());
                addressModel.setProvince(parts[3].trim());
            } else {
                addressModel.setStreet("Unknown Street");
                addressModel.setWard("Unknown Ward");
                addressModel.setDistrict("Unknown District");
                addressModel.setProvince("Unknown Province");
            }

            return addressModel;
        } else {
            return null;
        }
    }


    // Cập nhật địa chỉ mặc định
    @Override
    public AddressEntity setDefaultAddress(Long userId, Long addressId) {
        List<AddressEntity> addresses = addressRepository.findByUserId(userId);

        // Đặt tất cả các địa chỉ khác không phải là mặc định
        for (AddressEntity address : addresses) {
            address.setIsDefault(false);
            addressRepository.save(address);
        }

        // Đặt địa chỉ được chọn là mặc định
        AddressEntity defaultAddress = addressRepository.findById(addressId)
                .orElseThrow(() -> new RuntimeException("Address không tồn tại"));
        defaultAddress.setIsDefault(true);
        return addressRepository.save(defaultAddress);
    }

    @Override
    public Optional<AddressEntity> getDefaultAddress(Long userId) {
        return addressRepository.findByUserIdAndIsDefaultTrue(userId);
    }

    @Override
    public void deleteAddressById(Long addressId) {
        addressRepository.deleteById(addressId);
    }
}
