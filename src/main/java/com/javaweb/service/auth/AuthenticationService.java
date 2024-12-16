package com.javaweb.service.auth;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.dto.LoginDTO;
import com.javaweb.dto.RegisterDTO;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.IRoleRepository;
import com.javaweb.repository.IUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class AuthenticationService {
    private final IUserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;

    public AuthenticationService(IUserRepository userRepository, BCryptPasswordEncoder bCryptPasswordEncoder, AuthenticationManager authenticationManager) {
        this.userRepository = userRepository;
        this.passwordEncoder = bCryptPasswordEncoder;
        this.authenticationManager = authenticationManager;
    }

    @Autowired
    private IRoleRepository roleRepository;

    public Boolean authenticate(String username, String password) {
        UserEntity user = userRepository.findByUsernameAndStatus(username, 1);
        return user != null && passwordEncoder.matches(password, user.getPassword());
    }

    public Boolean changePassword(String username, String currentPassword, String newPassword) {
        if (authenticate(username, currentPassword)) {
            UserEntity user = userRepository.findByUsernameAndStatus(username, 1);
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            return true;
        }
        return false;
    }
    public void signUp(RegisterDTO registerDTO) {
        UserEntity userEntity = new UserEntity();
        userEntity.setFullName(registerDTO.getFullName());
        userEntity.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        userEntity.setEmail(registerDTO.getEmail());
        userEntity.setUsername(registerDTO.getUsername());
        userEntity.setStatus(1);
        RoleEntity roleEntity = roleRepository.findByName("USER");
        userEntity.setRoles(Stream.of(roleEntity).collect(Collectors.toList()));
        userRepository.save(userEntity);
    }

    public UserInfoUserDetails authenticate(LoginDTO loginDTO) {
        Authentication auth = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginDTO.getUsername(), loginDTO.getPassword()));
        return (UserInfoUserDetails) auth.getPrincipal();
    }
}
