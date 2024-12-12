package com.javaweb.service;

import com.javaweb.dto.UserDTO;
import com.javaweb.entity.UserEntity;

import org.apache.catalina.User;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

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
}
