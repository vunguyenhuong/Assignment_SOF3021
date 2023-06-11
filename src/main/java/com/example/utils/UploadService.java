package com.example.utils;

import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@Service
public class UploadService {
    @Autowired
    ServletContext servletContext;

    public File save(String randomString,MultipartFile file, String folder) {
        File dir = new File(servletContext.getRealPath(folder));
        if (!dir.exists()) {
            dir.mkdirs();
        }
        try {
            File saveFile = new File(dir,randomString + file.getOriginalFilename());
            file.transferTo(saveFile);
            return saveFile;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(String fileName, String folder) {
        File deleteFile = new File(servletContext.getRealPath(folder) + fileName);
        if (deleteFile.exists()) {
            boolean checkDelete = deleteFile.delete();
            if (checkDelete) {
                System.out.println("Xóa thành công ảnh " + fileName);
            } else {
                System.out.println("Xóa thất bại");
            }
        } else {
            System.out.println("File không tồn tại!");
        }
    }
}
