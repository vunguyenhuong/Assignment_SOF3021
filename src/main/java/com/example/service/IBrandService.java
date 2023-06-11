package com.example.service;

import com.example.model.Brand;

import java.util.List;
import java.util.Optional;

public interface IBrandService {
    List<Brand> getAll();
    Optional<Brand> getOne(Integer id);
}
