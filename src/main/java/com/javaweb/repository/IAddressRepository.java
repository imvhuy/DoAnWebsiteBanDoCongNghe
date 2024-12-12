package com.javaweb.repository;

import com.javaweb.entity.AddressEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IAddressRepository extends JpaRepository<AddressEntity, Long> {
    List<AddressEntity> findByUserId(Long userId);
    Optional<AddressEntity> findByUserIdAndIsDefaultTrue(Long userId);
}
