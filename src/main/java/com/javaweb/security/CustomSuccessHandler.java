package com.javaweb.security;

import com.javaweb.constant.SystemConstant;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Setter
@Getter
@Component
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String targetUrl = determineTargetUrl(authentication);
        if (response.isCommitted()) {
            System.out.println("Can't redirect");
            return;
        }
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    private String determineTargetUrl(Authentication authentication) {
        List<String> roles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .toList();

        if (isAdmin(roles)) {
            return SystemConstant.ADMIN_HOME; // Chuyển hướng đến trang admin
        } else if (isUser(roles)) {
            return SystemConstant.HOME; // Chuyển hướng đến trang người dùng
        }
        else if (isVendor(roles)) {
            return SystemConstant.VENDOR_HOME;
        }
        else if (isShipper(roles)) {
            return SystemConstant.SHIPPER_HOME;
        }
        return SystemConstant.DEFAULT_PAGE; // Trang mặc định nếu không có vai trò phù hợp
    }

    private boolean isAdmin(List<String> roles) {
        return roles.contains(SystemConstant.ADMIN_ROLE);
//                roles.contains(SystemConstant.MANAGER_ROLE) ||
//                roles.contains(SystemConstant.STAFF_ROLE);
    }
    private boolean isVendor(List<String> roles) {
        return roles.contains(SystemConstant.VENDOR_ROLE);
    }

    private boolean isUser(List<String> roles) {
        return roles.contains(SystemConstant.USER_ROLE);
    }

    private boolean isShipper(List<String> roles) {
        return roles.contains(SystemConstant.SHIPPER_ROLE);
    }

}
