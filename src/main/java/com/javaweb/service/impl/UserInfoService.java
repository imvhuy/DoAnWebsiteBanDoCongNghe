package com.javaweb.service.impl;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.converter.UserConverter;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.UserModel;
import com.javaweb.repository.IUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserInfoService implements UserDetailsService {
    @Autowired
    IUserRepository userRepository;
    @Autowired
    private UserConverter userConverter;

    public UserInfoService(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity userEntity = userRepository.findByUsernameAndStatus(username, 1);
        if(userEntity == null){
            throw new UsernameNotFoundException("Username not found");
        }
        UserModel userModel = userConverter.convertToModel(userEntity);
        List<GrantedAuthority> authorities = new ArrayList<>();
        for(RoleEntity role: userModel.getRoles()){
            authorities.add(new SimpleGrantedAuthority("ROLE_"+role.getName()));
        }
        UserInfoUserDetails myUserDetail = new UserInfoUserDetails(username, userModel.getPassword(), authorities);
        return myUserDetail;
    }
}
