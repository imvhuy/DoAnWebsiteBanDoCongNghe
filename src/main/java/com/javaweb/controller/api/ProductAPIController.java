package com.javaweb.controller.api;

import com.javaweb.dto.FilterRequest;
import com.javaweb.entity.ProductEntity;
import com.javaweb.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/products")
public class ProductAPIController {
    @Autowired
    private IProductService productService;

    @PostMapping("/filter")
    public ResponseEntity<List<ProductEntity>> filterProducts(@RequestParam Map<String, List<String>> subcategoryMap) {
        // Giả sử bạn có một phương thức trong service để lọc sản phẩm theo danh sách các categoryValues
//        List<ProductEntity> filteredProducts = productService.filterProductsByCategoryValues(filterRequest.getCategoryValues());

        return ResponseEntity.ok(new ArrayList<ProductEntity>());
    }


}
