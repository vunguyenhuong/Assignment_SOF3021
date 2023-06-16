package com.example.service.impl;

import com.example.model.Brand;
import com.example.model.Category;
import com.example.model.Product;
import com.example.repository.IProductRepository;
import com.example.service.IProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService implements IProductService {
    @Autowired
    private IProductRepository repository;


    @Override
    public List<Product> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<Product> getOne(Integer id) {
        return repository.findById(id);
    }

    @Override
    public Boolean save(@Valid Product product) {
        try {
            repository.save(product);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Boolean delete(Integer id) {
        try {
            repository.deleteById(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public String saleOffProduct(List<Product> list, Integer percent) {
        if (percent > 50 || percent < 0) {
            return "Phần trăm giảm không hợp lệ!";
        }
        if (percent == 0) {
            for (Product x : list) {
                x.setDonGiaKhiGiam(BigDecimal.ZERO);
                repository.save(x);
            }
            return "Đã hủy giảm giá!";
        } else {
            for (Product x : list) {
                x.setDonGiaKhiGiam(BigDecimal.valueOf(x.getDonGia().doubleValue() / 100 * (100 - percent)));
                repository.save(x);
            }
            return "Giảm giá thành công!";
        }
    }

    @Override
    public Page<Product> filterProduct(String name, BigDecimal minPrice, BigDecimal maxPrice, Category category, Brand brand, String vanhXe, Pageable pageable) {
        return repository.filterProduct(name, minPrice, maxPrice, category, brand, vanhXe, pageable);
    }
}
