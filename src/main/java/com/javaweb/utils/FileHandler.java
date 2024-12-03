package com.javaweb.utils;
import java.io.File;

import java.io.IOException;

import java.nio.file.Files;

import java.nio.file.Path;

import java.nio.file.Paths;

import java.nio.file.StandardCopyOption;


import org.springframework.core.io.ClassPathResource;

import org.springframework.web.multipart.MultipartFile;

public class FileHandler {
    public static String save(MultipartFile file) {
        try {
            // Lấy tên tệp gốc
            String imageName = file.getOriginalFilename();

            // Lấy đường dẫn tới thư mục static của ứng dụng
            File saveFile = new ClassPathResource("static/").getFile();

            // Cập nhật đường dẫn để lưu ảnh vào thư mục static/admin/images/products
            String uploadPath = saveFile.getAbsolutePath() + File.separator + "admin" + File.separator + "images" + File.separator + "products";

            // Tạo thư mục nếu chưa tồn tại
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();  // Dùng mkdirs() để tạo tất cả thư mục cần thiết
            }

            // Lưu tệp vào thư mục đã chỉ định
            Path path = Paths.get(uploadPath + File.separator + imageName);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING); // Lưu tệp hình ảnh

            return imageName; // Trả về tên tệp đã lưu
        } catch (IOException e) {
            e.printStackTrace(); // In lỗi nếu có
            return null; // Trả về null nếu gặp lỗi
        }
    }



    public static void delete(String fileName) throws IOException {

        File saveFile = new ClassPathResource("static/").getFile();

        String filePath = saveFile.getAbsolutePath() + File.separator + "img" + File.separator + fileName;


        File file = new File(filePath);

        if (file.exists()) {

            file.delete();

        }

    }
}
