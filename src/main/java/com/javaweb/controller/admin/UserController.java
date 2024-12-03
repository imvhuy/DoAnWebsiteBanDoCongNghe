package com.javaweb.controller.admin;

import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.service.IRoleService;
import com.javaweb.service.ITransactionService;
import com.javaweb.service.IUserService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/admin/users")
public class UserController {

	@Autowired
	private IUserService userService;
	@Autowired
	private final IRoleService roleService;
	@Autowired
	private ITransactionService transactionService;
	
	
	public UserController(IRoleService roleService) {
		this.roleService = roleService;
	}

	// Hiển thị danh sách người dùng
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping
	public String list(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int size,
			@RequestParam(value = "username", required = false) String username, ModelMap model) {
		if (page < 1) {
			page = 1;
		}

		Pageable pageable = PageRequest.of(page - 1, size);
		Page<UserEntity> userPage;

		if (username != null && !username.isEmpty()) {
			userPage = userService.findByUsernameContainingIgnoreCase(username, pageable);
			model.addAttribute("username", username);
		} else {
			userPage = userService.findAll(pageable);
		}

		model.addAttribute("userPage", userPage);
		model.addAttribute("users", userPage.getContent());
		model.addAttribute("totalPages", userPage.getTotalPages());
		model.addAttribute("totalElements", userPage.getTotalElements());
		model.addAttribute("currentPage", page);
		model.addAttribute("size", size);

		return "admin/users/user-list";
	}

	// Hiển thị trang chỉnh sửa người dùng
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("edit/{id}")
	public ModelAndView editUser(@PathVariable("id") Long userId,
			@RequestParam(value = "view", required = false) String view, ModelMap model) {
		// Tìm người dùng theo ID
		UserEntity userEntity = userService.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));

		// Lấy danh sách roles từ service (hoặc từ repository tùy thuộc vào cách bạn xử
		// lý roles)
		List<RoleEntity> roles = roleService.findAll(); // Giả sử bạn có roleService để lấy danh sách roles

		// Thêm người dùng và roles vào model
		model.addAttribute("view", view); // Thêm tham số 'view' vào model
		model.addAttribute("user", userEntity);
		model.addAttribute("roles", roles); // Truyền roles vào model
		model.addAttribute("editMode", true); // Đánh dấu chế độ chỉnh sửa

		return new ModelAndView("admin/users/addOrEdit", model); // Trả về View
	}

	// Lưu hoặc cập nhật người dùng
//	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
//	@PostMapping("saveOrUpdate")
//	public ModelAndView saveOrUpdate(@ModelAttribute("user") UserEntity userEntity, RedirectAttributes model) {
////        if (userEntity.getPassword().isEmpty()) {
////            // Xử lý trường hợp không thay đổi mật khẩu (nếu editMode)
////        }
//
//		userService.save(userEntity);
//		return new ModelAndView("redirect:/admin/users");
//	}
	
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(@ModelAttribute("user") UserEntity userEntity, 
	                                 @RequestParam("role") Long roleId, 
	                                 RedirectAttributes model) {
		
		
	    // Tìm kiếm vai trò từ ID
	    Optional<RoleEntity> roleOptional = roleService.findById(roleId);
	    if (roleOptional.isPresent()) {
	        RoleEntity role = roleOptional.get();
	        
	        // Gán vai trò vào userEntity
	        userEntity.setRoles(new ArrayList<>(Collections.singleton(role)));  // Chuyển Set thành List

	        // Nếu là bản ghi mới hoặc bản ghi cũ
	        userService.save(userEntity);
	    } else {
	        model.addFlashAttribute("error", "Role không hợp lệ!");
	    }

	    return new ModelAndView("redirect:/admin/users");
	}


	// Xử lý xóa người dùng
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id, RedirectAttributes model) {
		Optional<UserEntity> optionalUser = userService.findById(id);
		if (optionalUser.isEmpty()) {
			return new ModelAndView("redirect:/admin/users");
		}
		userService.deleteById(id);
		return new ModelAndView("redirect:/admin/users");
	}

	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("checkHistory/{id}")
	public String checkTransactionHistory(@PathVariable("id") Long userId,
	                                      @RequestParam(defaultValue = "1") int page,
	                                      @RequestParam(defaultValue = "5") int size,
	                                      @RequestParam(required = false) String startDate,
	                                      @RequestParam(required = false) String endDate,
	                                      Model model) {
	    // Kiểm tra nếu page < 1 thì đặt lại về 1
	    if (page < 1) {
	        page = 1;
	    }
	   

	    // Kiểm tra nếu size quá lớn, giới hạn lại để bảo vệ hệ thống
	    if (size > 100) {
	        size = 100;  // Bạn có thể điều chỉnh số này theo nhu cầu của mình
	    }

	    // Tạo đối tượng Pageable từ các tham số page và size
	    Pageable pageable = PageRequest.of(page - 1, size);  // PageRequest expects 0-based index

	    // Chuyển đổi startDate và endDate từ String sang LocalDate nếu có
	    LocalDate startLocalDate = null;
	    LocalDate endLocalDate = null;
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");  // Định dạng ISO chuẩn

	    // Kiểm tra và chuyển đổi startDate nếu có
	    try {
	        if (startDate != null && !startDate.isEmpty()) {
	            startLocalDate = LocalDate.parse(startDate, formatter);  // Chuyển đổi startDate thành LocalDate
	        }

	    } catch (DateTimeParseException e) {
	        model.addAttribute("errorMessage", "Ngày bắt đầu không hợp lệ.");
	        return "admin/users/HistoryCommit";
	    }

	    // Kiểm tra và chuyển đổi endDate nếu có
	    try {
	        if (endDate != null && !endDate.isEmpty()) {
	            endLocalDate = LocalDate.parse(endDate, formatter);  // Chuyển đổi endDate thành LocalDate
	        }
	    } catch (DateTimeParseException e) {
	        model.addAttribute("errorMessage", "Ngày kết thúc không hợp lệ.");
	        return "admin/users/HistoryCommit";
	    }

	    // Gọi service để lấy danh sách giao dịch của người dùng theo userId, phân trang
	    Page<TransactionEntity> transactionsPage;
	    if (startLocalDate != null && endLocalDate != null) {
	        // Nếu có startDate và endDate thì filter theo ngày
	        transactionsPage = transactionService.getTransactionsByUserIdAndDateRange(userId, startLocalDate, endLocalDate, pageable);
	    } else {
	        // Nếu không có ngày, chỉ lấy các giao dịch theo userId
	        transactionsPage = transactionService.getTransactionsByUserId(userId, pageable);
	    }

	    // Kiểm tra xem có giao dịch nào không
	    if (transactionsPage.isEmpty()) {
	        model.addAttribute("message", "Không có giao dịch nào trong khoảng thời gian này.");
	    }
	    UserEntity userEntity = userService.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
	    
	    // Thêm dữ liệu vào model
	    model.addAttribute("userName", userEntity.getFullName());
	    model.addAttribute("transactions", transactionsPage.getContent());
	    model.addAttribute("currentPage", page);  // Trang hiện tại (1-based)
	    model.addAttribute("totalPages", transactionsPage.getTotalPages());
	    model.addAttribute("totalElements", transactionsPage.getTotalElements());
	    model.addAttribute("size", size);
	    model.addAttribute("userId", userId);
	    model.addAttribute("startDate", startDate);  // Thêm startDate vào model
	    model.addAttribute("endDate", endDate);    // Thêm endDate vào model

	    // Trả về view JSP để hiển thị lịch sử giao dịch
	    return "admin/users/HistoryCommit";  // Đảm bảo rằng bạn có view 'HistoryCommit.jsp'
	}




}
