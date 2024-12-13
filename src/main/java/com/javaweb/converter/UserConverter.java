package com.javaweb.converter;

import com.javaweb.dto.UserDTO;
import com.javaweb.entity.UserEntity;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class UserConverter {

    public UserDTO convertToModel (UserEntity entity){
        UserDTO result = new UserDTO();
        BeanUtils.copyProperties(entity, result);
        return result;
    }

    public UserEntity convertToEntity (UserDTO userModel){
        UserEntity result = new UserEntity();
        BeanUtils.copyProperties(userModel, result);
        return result;
    }
}
