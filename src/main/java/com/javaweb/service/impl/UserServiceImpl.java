package com.javaweb.service.impl;

import com.javaweb.converter.UserConverter;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.UserModel;
import com.javaweb.repository.IRoleRepository;
import com.javaweb.repository.IUserRepository;
import com.javaweb.service.IUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
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
    @Transactional
    public UserModel findByUserNameAndStatus(String name, int status) {
        UserModel result = new UserModel();
        UserEntity user = userRepository.findByUsernameAndStatus(name, status);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    public UserModel findByUserName(String userName) {
        UserModel result = new UserModel();
        UserEntity user = userRepository.findByUsername(userName);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    public UserModel findUserById(long id) {
        UserModel result = new UserModel();
        Optional<UserEntity> user = userRepository.findById(id);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    @Transactional
    public UserModel insert(UserModel userModel) {
        RoleEntity roleEntity = roleRepository.findByName(userModel.getRoleName());
        UserEntity userEntity = userConverter.convertToEntity(userModel);
        userEntity.setRoles(Stream.of(roleEntity).collect(Collectors.toList()));
        userEntity.setStatus(1);
        userEntity.setPassword(passwordEncoder.encode(userModel.getPassword()));
        UserModel result = userConverter.convertToModel(userRepository.save(userEntity));
        return result;
    }

    @Override
    public UserModel update(Long id, UserEntity userEntity) {
        return null;
    }

    @Override
    public void delete(long[] ids) {

    }
}
