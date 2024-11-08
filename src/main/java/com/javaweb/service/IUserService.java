package com.javaweb.service;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.UserModel;
import org.apache.catalina.User;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface IUserService {
    UserModel findByUserNameAndStatus(String name, int status);
    UserModel findByUserName(String userName);

    UserModel findUserById(long id);
    @Transactional
    UserModel insert(UserModel userModel);
    UserModel update(Long id, UserEntity userEntity);
    void delete(long[] ids);
    Boolean authenticate(String username, String password);
}
