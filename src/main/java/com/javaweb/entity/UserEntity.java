package com.javaweb.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.security.core.userdetails.UserDetails;

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

    @Column(name = "fullname", columnDefinition = "nvarchar(255) not null")
    private String fullName;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "isemailactive")
    private Boolean isEmailActive;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<AddressEntity> addressEntities = new ArrayList<>();


    @Column(name = "avatar", columnDefinition =  "nvarchar(500)")
    private String avatar;

    @Column(name = "status", nullable = false)
    private Integer status;

    @OneToMany(mappedBy = "user")
    @ToString.Exclude
    private List<CartEntity> cartEntities;
    
    @OneToMany(mappedBy = "user")
    @ToString.Exclude
    private List<FavoriteProductEntity> favoriteProductEntities;

    @OneToMany(mappedBy = "owner")
    @ToString.Exclude
    private List<StoreEntity> storeEntities;


    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @ToString.Exclude
    private List<OrderEntity> orderEntities;

    @ToString.Exclude
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_role",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id", nullable = false)
    )
    private List<RoleEntity> roles = new ArrayList<>();
}