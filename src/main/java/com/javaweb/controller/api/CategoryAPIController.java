package com.javaweb.controller.api;

import com.javaweb.entity.SubcategoryEntity;
import com.javaweb.entity.SubcategoryValueEntity;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.service.ISubCategoryService;
import com.javaweb.service.ICategoryService;
import com.javaweb.service.ISubCategoryValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController(value = "CategoryOfWeb")
@RequestMapping("/api")
public class CategoryAPIController {
    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private ISubCategoryService subCategoryService;

    @Autowired
    private ISubCategoryValueService subcategoryValueService;


    // Endpoint lấy danh sách danh mục
    @GetMapping("/categories")
    public ResponseEntity<List<CategoryEntity>> getCategories() {
        List<CategoryEntity> categories = categoryService.getAllCategories();
        return ResponseEntity.ok(categories);
    }

    @GetMapping("/categories/{categoryId}/subcategories")
    public ResponseEntity<List<SubcategoryEntity>> getSubcategoryByCategoryId(@PathVariable Long categoryId) {
        List<SubcategoryEntity> subcategoryEntities = subCategoryService.getSubcategoryByCategoryId(categoryId);
        return ResponseEntity.ok(subcategoryEntities);
    }

    @GetMapping("/subcategories/{subcategoryId}/subcategory-values")
    public ResponseEntity<List<SubcategoryValueEntity>> getSubcategoryValuesBySubcategoryId(@PathVariable Long subcategoryId) {
        List<SubcategoryValueEntity> subcategoryValueEntities = subcategoryValueService.getSubcategoryValueBySubcategoryId(subcategoryId);
        return ResponseEntity.ok(subcategoryValueEntities);
    }
    
    @GetMapping("/subcategories/{categoryName}")
    public ResponseEntity<List<SubcategoryValueEntity>> getSubcategoryValuesBySubcategoryName(@PathVariable String categoryName) {
        Optional<CategoryEntity> category = categoryService.findByName(categoryName);
        List<SubcategoryValueEntity> subcategoryValueEntities = null;
        if (category.isPresent()) {
            CategoryEntity categoryEntity = category.get();
            subcategoryValueEntities = subcategoryValueService.findByCategoryEntity_Id(categoryEntity.getId());
        }
        return ResponseEntity.ok(subcategoryValueEntities);
    }
}
