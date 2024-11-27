package com.javaweb.controller.web;

import com.javaweb.entity.SubcategoryEntity;
import com.javaweb.entity.SubcategoryValueEntity;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.service.ISubCategoryService;
import com.javaweb.service.ISubcategoryValueService;
import com.javaweb.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController(value = "CategoryOfWeb")
@RequestMapping("/api")
public class CategoryController {
    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private ISubCategoryService attributeService;

    @Autowired
    private ISubcategoryValueService attributeValueService;


    // Endpoint lấy danh sách danh mục
    @GetMapping("/categories")
    public ResponseEntity<List<CategoryEntity>> getCategories() {
        List<CategoryEntity> categories = categoryService.getAllCategories();
        return ResponseEntity.ok(categories);
    }

    // Endpoint lấy các kiểu (Style) theo ID danh mục
    @GetMapping("/categories/{categoryId}/attributes")
    public ResponseEntity<List<SubcategoryEntity>> getAttributeByCategoryId(@PathVariable Long categoryId) {

        List<SubcategoryEntity> styles = attributeService.getAttributeByCategoryId(categoryId);
        return ResponseEntity.ok(styles);
    }

    // Endpoint lấy các giá trị kiểu (StyleValue) theo ID kiểu
    @GetMapping("/attributes/{attributeId}/attribute-values")
    public ResponseEntity<List<SubcategoryValueEntity>> getStyleValuesByStyleId(@PathVariable Long attributeId) {
        List<SubcategoryValueEntity> styleValues = attributeValueService.getAttributeValuesByAttributeId(attributeId);
        return ResponseEntity.ok(styleValues);
    }
}
