package com.example.viewmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class CartViewModel {
    private List<ProductViewModel> listProductInCart = new ArrayList<>();

    public BigDecimal tongTien() {
        Double result = 0.0;
        for (ProductViewModel x : listProductInCart) {
            result += x.tongTien().doubleValue();
        }
        return BigDecimal.valueOf(result);
    }
}
