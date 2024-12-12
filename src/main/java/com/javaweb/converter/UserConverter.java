package com.javaweb.converter;

import com.javaweb.entity.UserEntity;
import com.javaweb.dto.UserDTO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class UserConverter {

    public UserDTO convertToDTO (UserEntity entity){
        UserDTO result = new UserDTO();
        BeanUtils.copyProperties(entity, result);
        return result;
    }

    public UserEntity convertToEntity (UserDTO userDTO){
        UserEntity result = new UserEntity();
        BeanUtils.copyProperties(userDTO, result);
        return result;
    }
}
