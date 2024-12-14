package com.javaweb.repository;

import com.javaweb.entity.AddressEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IAddressRepository extends JpaRepository<AddressEntity, Long> {
    List<AddressEntity> findByUserId(Long userId);
    Optional<AddressEntity> findByUserIdAndIsDefaultTrue(Long userId);
    
    @Query("SELECT  a FROM AddressEntity a JOIN a.user where a.id = :id")
    AddressEntity findByIdNotOptional(@Param("id") Long id);
}
