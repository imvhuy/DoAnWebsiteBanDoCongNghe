package com.javaweb.controller;


import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.File;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class DownloadFileController {
    private final String UPLOAD_DIR = "C:\\upload";

    @GetMapping("/download/{fileName}")
    public ResponseEntity<Resource> downloadFile(@PathVariable("fileName") String fileName) {
        try {
            // Đường dẫn đầy đủ tới file
            Path filePath = Paths.get(UPLOAD_DIR).resolve(fileName).normalize();

            // Kiểm tra xem file có tồn tại không
            File file = filePath.toFile();
            if (!file.exists()) {
                return ResponseEntity.notFound().build();
            }

            // Load file như một resource
            Resource resource = new UrlResource(filePath.toUri());

            // Trả về file dưới dạng ResponseEntity
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);

        } catch (MalformedURLException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
}
