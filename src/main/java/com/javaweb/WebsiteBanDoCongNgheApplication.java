package com.javaweb;

import com.javaweb.config.CustomSiteMeshFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
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
}
