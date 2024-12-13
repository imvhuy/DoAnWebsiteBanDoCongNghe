package com.javaweb.service.impl;

import com.javaweb.converter.UserConverter;
import com.javaweb.dto.UserDTO;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.IRoleRepository;
import com.javaweb.repository.IUserRepository;
import com.javaweb.service.IUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import com.javaweb.exception.UserAlreadyExistsException;


@Service
public class UserServiceImpl implements IUserService {
    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IRoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserConverter userConverter;

    @Override
    public Boolean authenticate(String username, String password) {
        UserEntity user = userRepository.findByUsernameAndStatus(username, 1);
        return user != null && passwordEncoder.matches(password, user.getPassword());
    }

    @Override
    @Transactional
    public UserDTO findByUserNameAndStatus(String name, int status) {
        UserDTO result = new UserDTO();
        UserEntity user = userRepository.findByUsernameAndStatus(name, status);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    public UserDTO findByUserName(String userName) {
        UserDTO result = new UserDTO();
        Optional<UserEntity> user = userRepository.findByUsername(userName);
        if(user != null) {
            UserEntity userEntity = user.get();
            BeanUtils.copyProperties(userEntity, result);
        }
        return result;
    }

    @Override
    public UserDTO findUserById(long id) {
        UserDTO result = new UserDTO();
        Optional<UserEntity> user = userRepository.findById(id);
        if(user != null) {
            BeanUtils.copyProperties(user, result);
        }
        return result;
    }

    @Override
    @Transactional
    public UserDTO insert(UserDTO userModel) {
        RoleEntity roleEntity = roleRepository.findByName(userModel.getRoleName());
        UserEntity userEntity = userConverter.convertToEntity(userModel);
        userEntity.setRoles(Stream.of(roleEntity).collect(Collectors.toList()));
        userEntity.setStatus(1);
        userEntity.setPassword(passwordEncoder.encode(userModel.getPassword()));
        UserDTO result = userConverter.convertToModel(userRepository.save(userEntity));
        return result;
    }

    @Override
    public UserDTO update(Long id, UserEntity userEntity) {
        return null;
    }

    @Override
    public void delete(long[] ids) {

    }
// vũ làm
    @Override
    public Page<UserEntity> findByUsernameContainingIgnoreCase(String username, Pageable pageable) {
        return userRepository.findByUsernameContainingIgnoreCase(username, pageable);
    }

    @Override
    public Page<UserEntity> findAll(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @Override
    public Optional<UserEntity> findById(Long id) {
        return userRepository.findById(id);
    }

//    @Override
//    public void save(UserEntity userEntity) {
//        if (userEntity.getId() == null) {
//            // Nếu không có ID, lưu như một bản ghi mới
//            userRepository.save(userEntity);
//        } else {
//            // Đối tượng cần cập nhật
//            Optional<UserEntity> existingUserOpt = userRepository.findById(userEntity.getId());
//            if (existingUserOpt.isPresent()) {
//                UserEntity existingUser = existingUserOpt.get();
//
//                // Cập nhật các trường của đối tượng hiện tại từ đối tượng userEntity
//                existingUser.setFullName(userEntity.getFullName() != null ? userEntity.getFullName() : existingUser.getFullName());
//                existingUser.setUsername(userEntity.getUsername() != null ? userEntity.getUsername() : existingUser.getUsername());
//                existingUser.setPassword(userEntity.getPassword() != null ? userEntity.getPassword() : existingUser.getPassword());
//                existingUser.setEmail(userEntity.getEmail() != null ? userEntity.getEmail() : existingUser.getEmail());
//                existingUser.setIsEmailActive(userEntity.getIsEmailActive() != null ? userEntity.getIsEmailActive() : existingUser.getIsEmailActive());
//                existingUser.setStatus(userEntity.getStatus() != null ? userEntity.getStatus() : existingUser.getStatus());
//                existingUser.setRoles(userEntity.getRoles() != null ? userEntity.getRoles() : existingUser.getRoles());
//
//                // Lưu đối tượng đã được cập nhật
//                userRepository.save(existingUser);
//            } else {
//                // Nếu không tìm thấy đối tượng, lưu như bản ghi mới
//                userRepository.save(userEntity);
//            }
//        }
//    }

    @Override
    public void save(UserEntity userEntity) {
        if (userEntity.getId() == null) {
            // Nếu không có ID, kiểm tra email và username đã tồn tại chưa
            if (userRepository.existsByEmail(userEntity.getEmail())) {
                throw new UserAlreadyExistsException("Email đã tồn tại: " + userEntity.getEmail());
            }

            if (userRepository.existsByUsername(userEntity.getUsername())) {
                throw new UserAlreadyExistsException("Username đã tồn tại: " + userEntity.getUsername());
            }

            // Lưu như một bản ghi mới nếu không có lỗi
            userRepository.save(userEntity);

        } else {
            // Đối tượng cần cập nhật
            Optional<UserEntity> existingUserOpt = userRepository.findById(userEntity.getId());
            if (existingUserOpt.isPresent()) {
                UserEntity existingUser = existingUserOpt.get();

                // Kiểm tra nếu email hoặc username đã tồn tại (ngoại trừ bản ghi hiện tại)
                if (!existingUser.getEmail().equals(userEntity.getEmail()) &&
                    userRepository.existsByEmail(userEntity.getEmail())) {
                    throw new UserAlreadyExistsException("Email đã tồn tại: " + userEntity.getEmail());
                }

                if (!existingUser.getUsername().equals(userEntity.getUsername()) &&
                    userRepository.existsByUsername(userEntity.getUsername())) {
                    throw new UserAlreadyExistsException("Username đã tồn tại: " + userEntity.getUsername());
                }

                // Cập nhật các trường của đối tượng hiện tại từ đối tượng userEntity
                existingUser.setFullName(userEntity.getFullName() != null ? userEntity.getFullName() : existingUser.getFullName());
                existingUser.setUsername(userEntity.getUsername() != null ? userEntity.getUsername() : existingUser.getUsername());
                existingUser.setPassword(userEntity.getPassword() != null ? userEntity.getPassword() : existingUser.getPassword());
                existingUser.setEmail(userEntity.getEmail() != null ? userEntity.getEmail() : existingUser.getEmail());
                existingUser.setIsEmailActive(userEntity.getIsEmailActive() != null ? userEntity.getIsEmailActive() : existingUser.getIsEmailActive());
                existingUser.setStatus(userEntity.getStatus() != null ? userEntity.getStatus() : existingUser.getStatus());
                existingUser.setRoles(userEntity.getRoles() != null ? userEntity.getRoles() : existingUser.getRoles());

                // Lưu đối tượng đã được cập nhật
                userRepository.save(existingUser);
            } else {
                // Nếu không tìm thấy đối tượng, lưu như bản ghi mới
                userRepository.save(userEntity);
            }
        }
    }


    // Phương thức kiểm tra xem email hoặc username đã tồn tại trong cơ sở dữ liệu hay chưa
    public boolean isEmailOrUsernameExists(String email, String username, Long id) {
        // Kiểm tra email trùng
        if (email != null && userRepository.existsByEmail(email)) {
            return true;
        }
        // Kiểm tra username trùng
        if (username != null && userRepository.existsByUsername(username)) {
            return true;
        }
        // Kiểm tra nếu ID khác với bản ghi hiện tại
        if (id != null) {
            // Kiểm tra email/username trong các bản ghi khác, bỏ qua bản ghi hiện tại (so với `id`)
            if (userRepository.existsByEmailAndIdNot(email, id) || userRepository.existsByUsernameAndIdNot(username, id)) {
                return true;
            }
        }
        return false;
    }



    @Override
    public void deleteById(Long id) {
        userRepository.deleteById(id);  // Xóa người dùng theo id
    }
}
