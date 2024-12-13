package com.javaweb.dto;

import com.javaweb.entity.AddressEntity;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String fullName;
    private String username;
    private String password;
    private String email;
    private Boolean isEmailActive;
    private String avatar;
    private Integer status;

    @ToString.Exclude
    private List<RoleEntity> roles = new ArrayList<>();
    private String roleName;
    @ToString.Exclude
    private List<AddressEntity> addresses = new ArrayList<>();
}
