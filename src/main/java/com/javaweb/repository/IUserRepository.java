package com.javaweb.repository;

import com.javaweb.entity.UserEntity;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IUserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findByUsernameAndStatus(String name, int status);
//    Page<UserEntity> findByUsernameContainingIgnoreCaseAndStatusNot(String userName, String fullName, int status, Pageable pageable);
    List<UserEntity> findByStatusAndRoles_Name(Integer status, String roleName);
    Page<UserEntity> findByStatusNot(int status, Pageable pageable);
//    long countByUsernameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatusNot(String userName, String fullName, int status);
    long countByStatusNot(int status);
    UserEntity findByUsername(String userName);
    List<UserEntity> findByIdIn(List<Long> id);
    Boolean existsByUsername(String userName);

}
