package com.javaweb.service.impl;

import com.javaweb.converter.UserConverter;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.dto.UserDTO;
import com.javaweb.repository.IRoleRepository;
import com.javaweb.repository.IUserRepository;
import com.javaweb.service.IUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class UserServiceImpl implements IUserService {
    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IRoleRepository roleRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private UserConverter userConverter;

    @Override
    public Boolean authenticate(String username, String password) {
        UserEntity user = userRepository.findByUsernameAndStatus(username, 1);
        return user != null && passwordEncoder.matches(password, user.getPassword());
    }

    @Override
    public Boolean changePassword(String username, String currentPassword, String newPassword) {
        if (authenticate(username, currentPassword)) {
            UserEntity user = userRepository.findByUsernameAndStatus(username, 1);
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            return true;
        }
        return false;
    }

    @Override
    @Transactional
    public UserDTO findByUserNameAndStatus(String name, int status) {
        UserDTO result = new UserDTO();
        UserEntity user = userRepository.findByUsernameAndStatus(name, status);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    public UserDTO findByUserName(String userName) {
        UserDTO result = new UserDTO();
        UserEntity user = userRepository.findByUsername(userName);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    public UserDTO findUserById(long id) {
        UserDTO result = new UserDTO();
        Optional<UserEntity> user = userRepository.findById(id);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    @Transactional
    public UserDTO insert(UserDTO userDTO) {
        RoleEntity roleEntity = roleRepository.findByName(userDTO.getRoleName());
        UserEntity userEntity = userConverter.convertToEntity(userDTO);
        userEntity.setFullName(userDTO.getFullName());
        userEntity.setRoles(Stream.of(roleEntity).collect(Collectors.toList()));
        userEntity.setStatus(1);
        userEntity.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        UserDTO result = userConverter.convertToModel(userRepository.save(userEntity));
        return result;
    }

    @Override
    public UserDTO update(Long id, UserEntity userEntity) {
        return null;
    }

    @Override
    public void delete(long[] ids) {

    }
}
