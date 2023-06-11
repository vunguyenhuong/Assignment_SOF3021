package com.example.service.impl;

import com.example.model.Cart;
import com.example.model.Product;
import com.example.model.Users;
import com.example.repository.ICartRepository;
import com.example.repository.IProductRepository;
import com.example.service.ICartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class CartService implements ICartService {
    @Autowired
    private ICartRepository cartRepository;
    @Autowired
    private IProductRepository productRepository;
    @Autowired
    private HttpSession session;

    @Override
    public String addProductToCart(Integer id, Integer soLuong) {
        Users users = (Users) session.getAttribute("user");
        Product product = productRepository.findById(id).get();
        Cart cart = null;
        if (cartRepository.existsByUsersAndProduct(users, product)) {
            cart = cartRepository.findByUsersAndProduct(users, product);
            cart.setSoLuong(cart.getSoLuong() + soLuong);
            if(cart.getSoLuong() >= product.getSoLuong()){
                return "Bạn chỉ được mua tối đa " + (product.getSoLuong() - 1) + " sản phẩm cho mặt hàng " + product.getTen();
            }
            cartRepository.save(cart);
            session.setAttribute("totalCart", cartRepository.findByUsers(users).size());
            return "Sản phẩm tồn tại trong giỏ hàng, đã cập nhật số lượng!";
        } else {
            cart = new Cart();
            cart.setUsers(users);
            cart.setProduct(product);
            cart.setDonGia(product.getDonGiaKhiGiam().intValue() != 0 ? product.getDonGiaKhiGiam() : product.getDonGia());
            cart.setSoLuong(soLuong);
            cart.setNgayTao(Date.valueOf(LocalDate.now()));
            if(cart.getSoLuong() >= product.getSoLuong()){
                return "Bạn chỉ được mua tối đa " + (product.getSoLuong() - 1) + " sản phẩm cho mặt hàng " + product.getTen();
            }
            cartRepository.save(cart);
            session.setAttribute("totalCart", cartRepository.findByUsers(users).size());
            return "Đã thêm " + product.getTen() + " vào giỏ hàng!";
        }
    }

    @Override
    public List<Cart> findCartByUser(Users users) {
        session.setAttribute("totalCart", cartRepository.findByUsers(users).size());
        return cartRepository.findByUsers(users);
    }

    @Override
    public String removeProductInCart(Integer idCart) {
        cartRepository.deleteById(idCart);
        return "";
    }

    @Override
    public String removeAllProduct(Users users) {
        List<Cart> list = cartRepository.findByUsers(users);
        if(!list.isEmpty()){
            for (Cart x: list) {
                cartRepository.deleteById(x.getId());
            }
            return "Xóa thành công!";
        }
        return "Giỏ hàng trống!";
    }

    @Override
    public String updateProductInCart(Integer[] idCart, Integer[] soLuong) {
        for (int i = 0; i < idCart.length; i++) {
            Cart cart = cartRepository.findById(idCart[i]).get();
            Product product = cart.getProduct();
            if(soLuong[i] >= product.getSoLuong()){
                return "Bạn chỉ được mua tối đa " + (product.getSoLuong() - 1) + " sản phẩm cho mặt hàng " + product.getTen();
            }
            cart.setSoLuong(soLuong[i]);
            cart.setSoLuong(soLuong[i]);
            cartRepository.save(cart);
        }
        return "Cập nhật thành công!";
    }
}
