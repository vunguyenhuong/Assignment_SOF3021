package com.example.controller;

import com.example.model.Cart;
import com.example.model.Product;
import com.example.model.Users;
import com.example.service.CartSessionSerivce;
import com.example.service.ICartService;
import com.example.viewmodel.CartViewModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private HttpSession session;
    @Autowired
    private CartSessionSerivce cartSessionSerivce;
    @Autowired
    private ICartService cartService;

    @PostMapping("/add/{idProduct}")
    public String addProductToCart(RedirectAttributes redirectAttributes,
                                   @PathVariable(name = "idProduct") Integer id,
                                   @RequestParam(name = "soLuong", required = false, defaultValue = "1") Integer soLuong) {
        String message = "";
        if (session.getAttribute("user") == null) {
            message = cartSessionSerivce.addProductToCart(id, soLuong);
        } else {
            message = cartService.addProductToCart(id, soLuong);
        }
        redirectAttributes.addFlashAttribute(message.contains("Bạn chỉ được mua") ? "errorMessage" : "successMessage", message);
        return "redirect:/shop";
    }

    @PostMapping("/update")
    public String updateProductInCart(RedirectAttributes redirectAttributes,
                                      @RequestParam(value = "id") Integer[] id,
                                      @RequestParam("soLuong") Integer[] soLuong) {
        String message = "";
        if (session.getAttribute("user") == null) {
            message = cartSessionSerivce.updateProductInCart(id, soLuong);
        } else {
            message = cartService.updateProductInCart(id, soLuong);
        }
        redirectAttributes.addFlashAttribute(message.contains("Bạn chỉ được mua") ? "errorMessage" : "successMessage", message);
        return "redirect:/cart";
    }

    @GetMapping
    public String home(Model model) {
        if (session.getAttribute("user") == null) {
            CartViewModel cartViewModel = cartSessionSerivce.viewAllCart();
            model.addAttribute("listCart", cartViewModel.getListProductInCart());
            model.addAttribute("tongTien", cartViewModel.tongTien());
        } else {
            List<Cart> list = cartService.findCartByUser((Users) session.getAttribute("user"));
            Double tongTien = 0.0;
            if (!list.isEmpty()) {
                for (Cart x : list) {
                    Product product = x.getProduct();
                    tongTien += (product.getDonGiaKhiGiam().intValue() != 0 ? product.getDonGiaKhiGiam().doubleValue() : product.getDonGia().doubleValue() * x.getSoLuong());
                }
            }
            model.addAttribute("listCart", list);
            model.addAttribute("tongTien", tongTien);
        }
        return "cart";
    }

    @GetMapping("/remove/{id}")
    public String removeCart(RedirectAttributes redirectAttributes,
                             @PathVariable Integer id) {
        if (session.getAttribute("user") == null) {
            cartSessionSerivce.removeCart(id);
        } else {
            cartService.removeProductInCart(id);
        }
        redirectAttributes.addFlashAttribute("successMessage", "Xóa thành công!");
        return "redirect:/cart";
    }

    @GetMapping("/removeAll")
    public String removeAllCart(RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            cartSessionSerivce.removeAllCart();
        } else {
            cartService.removeAllProduct((Users) session.getAttribute("user"));
        }
        redirectAttributes.addFlashAttribute("successMessage", "Xóa thành công!");
        return "redirect:/cart";
    }
}
