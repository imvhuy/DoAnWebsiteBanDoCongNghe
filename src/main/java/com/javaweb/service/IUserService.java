package com.javaweb.service;

import com.javaweb.entity.UserEntity;
import com.javaweb.dto.UserDTO;
import org.springframework.stereotype.Service;

public interface IUserService {
    Boolean changePassword(String username, String currentPassword, String newPassword);

    UserDTO findByUserNameAndStatus(String name, int status);
    UserDTO findByUserName(String username);

    UserDTO findUserById(long id);
    UserDTO insert(UserDTO userDTO);
    UserDTO update(Long id, UserEntity userEntity);
    void delete(long[] ids);
    Boolean authenticate(String username, String password);
}
