package com.example.dto;

import com.example.model.Product;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ThongKeSanPham {
    private Product product;
    private Long soLuong;

}
