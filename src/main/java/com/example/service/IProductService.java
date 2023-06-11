package com.example.service;

import com.example.model.Category;
import com.example.model.Brand;
import com.example.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface IProductService {
    List<Product> getAll();
    Optional<Product> getOne(Integer id);

    Boolean save(Product product);

    Boolean delete(Integer id);

    Page<Product> filterProduct(String name, BigDecimal minPrice, BigDecimal maxPrice, Category category, Brand brand, String vanhXe, Pageable pageable);
}
