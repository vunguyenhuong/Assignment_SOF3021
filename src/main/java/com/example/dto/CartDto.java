package com.example.dto;

import com.example.model.Product;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class CartDto {
    private Map<Integer, Integer> listCart = new HashMap<>();
}
