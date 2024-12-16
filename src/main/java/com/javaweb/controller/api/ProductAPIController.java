package com.javaweb.controller.api;

import com.javaweb.dto.GalleryDTO;
import com.javaweb.dto.ProductDTO;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.service.IProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductAPIController {
    @Autowired
    private IProductService productService;

    @GetMapping()
    public ResponseEntity<?> search(@RequestParam String query) {
        // Tìm sản phẩm theo tên
        List<ProductEntity> products = productService.findByNameContainingIgnoreCase(query);
        List<ProductDTO> productDTO = new ArrayList<>();
        for (ProductEntity productEntity : products) {
            ProductDTO productDTO1 = new ProductDTO();
            BeanUtils.copyProperties(productEntity, productDTO1);
            productDTO.add(productDTO1);
        }
        // Trả về kết quả là danh sách sản phẩm dưới dạng JSON
        return new ResponseEntity<>(productDTO, HttpStatus.OK);
    }
}
