package com.javaweb.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {
    @Override


    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
                .addDecoratorPath("/*", "/web.jsp")
                .addDecoratorPath("/admin/*", "/admin.jsp")
                .addDecoratorPath("/api/admin/*", "/admin.jsp")
                .addDecoratorPath("/shipper/*", "/shipper.jsp")

                .addExcludedPath("/login*").addExcludedPath("/login/*")
                .addExcludedPath("/api/**").addExcludedPath("/api/**");
    }
}
