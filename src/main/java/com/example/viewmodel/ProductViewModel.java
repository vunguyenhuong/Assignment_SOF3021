package com.example.viewmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ProductViewModel {
    private Integer id;
    private String ten;
    private BigDecimal donGia;
    private Integer soLuong;
    private String hinhAnh;
    public BigDecimal tongTien(){
        return donGia.multiply(BigDecimal.valueOf(soLuong));
    }
}
