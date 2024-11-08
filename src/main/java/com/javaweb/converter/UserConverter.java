package com.javaweb.converter;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.UserModel;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserConverter {

    public UserModel convertToModel (UserEntity entity){
        UserModel result = new UserModel();
        BeanUtils.copyProperties(entity, result);
        return result;
    }

    public UserEntity convertToEntity (UserModel userModel){
        UserEntity result = new UserEntity();
        BeanUtils.copyProperties(userModel, result);
        return result;
    }
}
