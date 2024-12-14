package com.javaweb.repository;

import com.javaweb.entity.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
public interface IUserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findByUsernameAndStatus(String name, int status);
//    Page<UserEntity> findByUsernameContainingIgnoreCaseAndStatusNot(String userName, String fullName, int status, Pageable pageable);
    List<UserEntity> findByStatusAndRoles_Name(Integer status, String roleName);
    Page<UserEntity> findByStatusNot(int status, Pageable pageable);
//    long countByUsernameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatusNot(String userName, String fullName, int status);
    long countByStatusNot(int status);
    UserEntity findByUsername(String userName);
    List<UserEntity> findByIdIn(List<Long> id);
    Boolean existsByUsername(String userName);
    
    
    //vũ làm
    List<UserEntity> findByStatus(int status);
    Page<UserEntity> findByUsernameContainingIgnoreCaseAndEmailContainingIgnoreCaseAndStatus(String name, String email, Integer status, Pageable pageable);

    Page<UserEntity> findByEmailContainingIgnoreCaseAndStatus(String email, Integer status, Pageable pageable);
    Page<UserEntity> findByStatus(Integer status, Pageable pageable);
    
    
    // Tìm người dùng theo tên (username) với phân biệt chữ hoa chữ thường
    Page<UserEntity> findByUsernameContainingIgnoreCase(String username, Pageable pageable);

    // Tìm tất cả người dùng
    Page<UserEntity> findAll(Pageable pageable);

    // Tìm người dùng theo id
    Optional<UserEntity> findById(Long id);

    // Xóa người dùng theo id
    void deleteById(Long id);
    
    boolean existsByEmail(String email);
    boolean existsByEmailAndIdNot(String email, Long id);
    boolean existsByUsernameAndIdNot(String username, Long id);


}
