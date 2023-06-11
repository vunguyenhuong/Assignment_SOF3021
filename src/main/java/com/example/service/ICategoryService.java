package com.example.service;

import com.example.model.Category;

import java.util.List;
import java.util.Optional;

public interface ICategoryService {
    List<Category> getAll();
    Optional<Category> getOne(Integer id);
}
