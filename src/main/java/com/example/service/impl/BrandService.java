package com.example.service.impl;

import com.example.model.Brand;
import com.example.repository.IBrandRepository;
import com.example.service.IBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BrandService implements IBrandService {
    @Autowired
    private IBrandRepository repository;

    @Override
    public List<Brand> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<Brand> getOne(Integer id) {
        return repository.findById(id);
    }
}
