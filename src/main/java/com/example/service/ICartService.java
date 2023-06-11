package com.example.service;

import com.example.model.Cart;
import com.example.model.Product;
import com.example.model.Users;

import java.util.List;

public interface ICartService {
    String addProductToCart(Integer id, Integer soLuong);
    List<Cart> findCartByUser(Users users);
    String removeProductInCart(Integer idProduct);
    String removeAllProduct(Users users);

    String updateProductInCart(Integer[] idCart, Integer[] soLuong);
}
