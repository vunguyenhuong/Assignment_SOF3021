package com.example.service;

import com.example.dto.CartDto;
import com.example.model.Product;
import com.example.repository.IProductRepository;
import com.example.viewmodel.CartViewModel;
import com.example.viewmodel.ProductViewModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import java.math.BigDecimal;
import java.util.Map;

@Service
@SessionScope
public class CartSessionSerivce {
    @Autowired
    private IProductRepository productRepository;
    @Autowired
    private HttpSession session;
    private CartDto cart = new CartDto();

    public String addProductToCart(Integer id, Integer soLuong) {
        Map<Integer, Integer> listCart = cart.getListCart();
        Product product = productRepository.findById(id).get();
        if (listCart.get(id) != null) {
            if (listCart.get(id) >= product.getSoLuong() - 1) {
                return "Bạn chỉ được mua tối đa " + (product.getSoLuong() - 1) + " sản phẩm cho mặt hàng " + product.getTen();
            }
        }
        if (listCart.containsKey(id)) {
            listCart.put(id, listCart.get(id) + soLuong);
        } else {
            listCart.put(id, soLuong);
        }
        session.setAttribute("totalCart", cart.getListCart().size());
        return "Đã thêm vào giỏ hàng!";
    }

    public String updateProductInCart(Integer[] id, Integer[] soLuong) {
        Map<Integer, Integer> listCart = cart.getListCart();
        for (int i = 0; i < id.length; i++) {
            Product product = productRepository.findById(id[i]).get();
            if (soLuong[i] >= product.getSoLuong() - 1) {
                return "Bạn chỉ được mua tối đa " + (product.getSoLuong() - 1) + " sản phẩm cho mặt hàng " + product.getTen();
            }
            listCart.put(id[i], soLuong[i]);
        }
        session.setAttribute("totalCart", cart.getListCart().size());
        return "Cập nhật thành công!";
    }

    public CartViewModel viewAllCart() {
        CartViewModel cartViewModel = new CartViewModel();
        for (Map.Entry<Integer, Integer> x : cart.getListCart().entrySet()) {
            Product product = productRepository.findById(x.getKey()).get();
            cartViewModel.getListProductInCart().add(new ProductViewModel(product.getId(),
                    product.getTen(),
                    product.getDonGiaKhiGiam().intValue() != 0 ? product.getDonGiaKhiGiam() : product.getDonGia(),
                    x.getValue(),
                    product.getHinhAnh()));
        }
        session.setAttribute("totalCart", cart.getListCart().size());
        return cartViewModel;
    }

    public void removeCart(Integer id) {
        cart.getListCart().remove(id);
        session.setAttribute("totalCart", cart.getListCart().size());
    }

    public void removeAllCart() {
        cart.getListCart().clear();
        session.setAttribute("totalCart", cart.getListCart().size());
    }
}
