package com.javaweb.config;

import com.javaweb.repository.IUserRepository;
import com.javaweb.security.CustomSuccessHandler;
import com.javaweb.service.impl.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
public class SecurityConfig{
    private static final String[] WHITE_LIST_URL = {"/**", "/home", "/login",
            "/user/**",
            "/WEB-INF/**",
            "/common/**",
            "/web/**", "/error"};
    @Autowired
    IUserRepository userRepository;
    @Bean
    UserDetailsService userDetailsService() {
        return new UserInfoService(userRepository);
    }


    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Thêm HttpSessionEventPublisher để xử lý các sự kiện session khi hết hạn
    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Bean
    AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setUserDetailsService(userDetailsService());
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder());
        return daoAuthenticationProvider;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(WHITE_LIST_URL).permitAll()
                        .requestMatchers("/admin/**").permitAll()
                        .anyRequest().authenticated()
                ).formLogin(form -> form.loginPage("/login")
                        .successHandler(myAuthenticationSuccessHandler())
                        .failureUrl("/login?incorrectAccount").permitAll()
                );
        httpSecurity.logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/home").deleteCookies("JSESSIONID").permitAll());
        httpSecurity.exceptionHandling(ex -> ex.accessDeniedPage("/access-denied"));
        httpSecurity.sessionManagement(session -> session
                .sessionFixation().migrateSession() // Ngăn tái sử dụng session cũ
                .maximumSessions(1)
                .expiredUrl("/login?sessionTimeout")
        );
        return httpSecurity.build();
    }

    @Bean
    public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
        return new CustomSuccessHandler();
    }

    @Bean
    public SavedRequestAwareAuthenticationSuccessHandler savedRequestAwareAuthenticationSuccessHandler() {

        return new SavedRequestAwareAuthenticationSuccessHandler();
    }

    // Tùy chỉnh HttpFirewall để cho phép URL có dấu "//"
    @Bean
    public HttpFirewall allowUrlEncodedDoubleSlashHttpFirewall() {
        DefaultHttpFirewall firewall = new DefaultHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true); // Cho phép dấu "//" trong URL
        return firewall;
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer(HttpFirewall allowUrlEncodedDoubleSlashHttpFirewall) {
        return web -> web.httpFirewall(allowUrlEncodedDoubleSlashHttpFirewall); // Áp dụng HttpFirewall tùy chỉnh
    }


}
