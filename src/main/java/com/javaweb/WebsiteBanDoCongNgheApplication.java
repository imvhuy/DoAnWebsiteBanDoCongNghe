package com.javaweb;

import com.javaweb.config.CustomSiteMeshFilter;
//import com.javaweb.config.StorageProperties;
//import com.javaweb.service.StorageService;

import java.util.Optional;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
//@EnableConfigurationProperties(StorageProperties.class)
public class WebsiteBanDoCongNgheApplication {

    public static void main(String[] args) {
        SpringApplication.run(WebsiteBanDoCongNgheApplication.class, args);
    }
    @Bean
    public FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<CustomSiteMeshFilter> filterRegistrationBean = new FilterRegistrationBean<CustomSiteMeshFilter>();
        filterRegistrationBean.setFilter(new CustomSiteMeshFilter()); // adding sitemesh filter ??
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }

    // thêm cấu hình storage
//    @Bean
//    CommandLineRunner init(StorageService storageService) {
//        return (args -> {
//            storageService.init();
//        });
//    }
    

    
    
}
