package com.javaweb.service;

import com.javaweb.dto.UserDTO;
import com.javaweb.entity.UserEntity;

import org.apache.catalina.User;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public interface IUserService {
    UserDTO findByUserNameAndStatus(String name, int status);
    UserDTO findByUserName(String username);

    UserDTO findUserById(long id);
    UserDTO insert(UserDTO userModel);
    UserDTO update(Long id, UserEntity userEntity);
    void delete(long[] ids);
    Boolean authenticate(String username, String password);
	UserEntity findByUserNameEntity(String userName);
 
    
 // vũ làm   
    // Tìm người dùng theo tên (username) với phân biệt chữ hoa chữ thường
    Page<UserEntity> findByUsernameContainingIgnoreCase(String username, Pageable pageable);

    // Tìm tất cả người dùng
    Page<UserEntity> findAll(Pageable pageable);

    // Tìm người dùng theo id
    Optional<UserEntity> findById(Long id);

    // Lưu hoặc cập nhật người dùng
    void save(UserEntity userEntity);

    // Xóa người dùng theo id
    void deleteById(Long id);
	UserEntity findByIdNotOptional(Long id);
}
