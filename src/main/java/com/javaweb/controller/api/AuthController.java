package com.javaweb.controller.api;

import com.javaweb.config.UserInfoUserDetails;
import com.javaweb.dto.LoginDTO;
import com.javaweb.dto.LoginResponseDTO;
import com.javaweb.dto.RegisterDTO;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.IUserService;
import com.javaweb.service.auth.AuthenticationService;
import com.javaweb.service.auth.EmailService;
import com.javaweb.service.auth.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Random;


@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private IUserService userService;
    @Autowired
    private EmailService emailService;
    @Autowired
    private AuthenticationService authenticationService;
    @Autowired
    private JwtService jwtService;

    @PostMapping("/send-otp")
    public ResponseEntity<String> sendOtp(@RequestBody RegisterDTO registerDTO, HttpSession session) {
        List<UserEntity> user = userService.findByEmailOrUsername(registerDTO.getEmail(), registerDTO.getUsername());
        if (!user.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email hoặc Username đã tồn tại.");
        }

        // Tạo OTP ngẫu nhiên
        String otp = generateOtp();
        // Lưu OTP vào session
        session.setAttribute("otp", otp);
        session.setAttribute("registerDTO", registerDTO);
        // Gửi OTP qua email cho người dùng
        emailService.sendOtpEmail(registerDTO.getEmail(), otp);
        return ResponseEntity.ok("OTP đã được gửi đến email của bạn.");
    }
    @PostMapping("/verifyOtp")
    public ResponseEntity<String> verifyOtp(String otp, HttpSession session) {
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp == null) {
            return ResponseEntity.badRequest().body("OTP không hợp lệ hoặc đã hết hạn.");
        }

        if (!otp.equals(sessionOtp)) {
            return ResponseEntity.badRequest().body("OTP không đúng. Vui lòng thử lại.");
        }
        RegisterDTO registerDTO = (RegisterDTO) session.getAttribute("registerDTO");
        try {
            authenticationService.signUp(registerDTO);
            return ResponseEntity.ok("Đăng ký thành công.");
        }
        catch (Exception e)
            {e.printStackTrace();}
        return ResponseEntity.ok("Username hoặc email đã tồn tại");
    }


    // Hàm tạo OTP ngẫu nhiên
    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);  // OTP có 6 chữ số
        return String.valueOf(otp);
    }

    @PostMapping("/login")
    @Transactional
    public ResponseEntity<?> login(LoginDTO loginDTO) {
        UserInfoUserDetails authenticatedUser = authenticationService.authenticate(loginDTO);
        String jwtToken = jwtService.generateToken(authenticatedUser);
        LoginResponseDTO loginResponseDTO = new LoginResponseDTO();
        loginResponseDTO.setToken(jwtToken);
        loginResponseDTO.setExpiresIn(jwtService.getExpirationTime());
        return ResponseEntity.ok(loginResponseDTO);
    }

    // API để kiểm tra và xác thực JWT
    @GetMapping("/authenticate")
    public ResponseEntity<?> authenticate(HttpServletRequest req) {
        // Lấy thông tin người dùng đã được xác thực từ SecurityContextHolder
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Không có quyền truy cập hoặc token không hợp lệ");
        }

        // Lấy thông tin người dùng đã xác thực
        String username = authentication.getName();
        HttpSession session = req.getSession();
        if (username != null) {
            // Trả về thông tin người dùng
            return ResponseEntity.ok(authentication.getPrincipal());
        } else {
            session.invalidate();
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Không thể lấy thông tin người dùng");
        }
    }
}
