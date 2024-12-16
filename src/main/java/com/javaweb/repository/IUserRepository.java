package com.javaweb.repository;

import com.javaweb.entity.UserEntity;
import org.apache.catalina.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
public interface IUserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findByUsernameAndStatus(String name, int status);
    UserEntity findByUsername(String userName);
    Boolean existsByUsername(String userName);
    // Tìm người dùng theo tên (username) với phân biệt chữ hoa chữ thường
    Page<UserEntity> findByUsernameContainingIgnoreCase(String username, Pageable pageable);
    Optional<UserEntity> findByEmail(String email);

    // Tìm tất cả người dùng
    Page<UserEntity> findAll(Pageable pageable);

    // Tìm người dùng theo id
    Optional<UserEntity> findById(Long id);

    // Xóa người dùng theo id
    void deleteById(Long id);
    List<UserEntity> findByEmailOrUsername(String username, String password);
    
    boolean existsByEmail(String email);
    boolean existsByEmailAndIdNot(String email, Long id);
    boolean existsByUsernameAndIdNot(String username, Long id);
    @Query("SELECT a.address FROM UserEntity u " +
            "JOIN u.addressEntities a " +
            "WHERE u.id = :id ")
    String getAddressOfShipper(@Param("id") Long id);



}
