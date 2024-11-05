package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "user")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserEntity extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "firstname", columnDefinition = "nvarchar(255) not null")
    private String firstName;

    @Column(name = "lastname", columnDefinition = "nvarchar(255) not null")
    private String lastName;

    @Column(name = "username", nullable = false, unique = true)
    private String userName;

    @Column(name = "password")
    private String password;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "isemailactive")
    private Boolean isEmailActive;

    @Column(name = "address", columnDefinition = "nvarchar(255) not null")
    private String address;

    @Column(name = "avatar", columnDefinition =  "nvarchar(500)")
    private String avatar;

    @Column(name = "status", nullable = false)
    private Integer status;

    @OneToMany(mappedBy = "user")
    private List<CartEntity> cartEntities;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<OrderEntity> orderEntities;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_role",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id", nullable = false)
    )
    private List<RoleEntity> roles = new ArrayList<>();
}