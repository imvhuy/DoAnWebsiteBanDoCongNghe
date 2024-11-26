package com.javaweb.model;

import com.javaweb.entity.AddressEntity;
import com.javaweb.entity.RoleEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserModel implements Serializable {

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
