package com.javaweb.service;

import com.javaweb.entity.UserEntity;
import com.javaweb.dto.UserDTO;
import org.springframework.stereotype.Service;

@Service
public interface IUserService {
    UserDTO findByUserNameAndStatus(String name, int status);
    UserDTO findByUserName(String username);

    UserDTO findUserById(long id);
    UserDTO insert(UserDTO userDTO);
    UserDTO update(Long id, UserEntity userEntity);
    void delete(long[] ids);
    Boolean authenticate(String username, String password);
}
