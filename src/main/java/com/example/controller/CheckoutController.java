package com.example.controller;

import com.example.model.Bill;
import com.example.model.Cart;
import com.example.model.Product;
import com.example.model.Users;
import com.example.service.CartSessionSerivce;
import com.example.service.IBillDetailService;
import com.example.service.IBillService;
import com.example.service.impl.CartService;
import com.example.viewmodel.BillViewModel;
import com.example.viewmodel.CartViewModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {
    @Autowired
    private HttpSession session;
    @Autowired
    private CartSessionSerivce cartSessionSerivce;
    @Autowired
    private CartService cartService;
    @Autowired
    private IBillService billService;
    @Autowired
    private IBillDetailService billDetailService;

    @GetMapping
    public String checkout(Model model, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            CartViewModel cartViewModel = cartSessionSerivce.viewAllCart();
            if (cartViewModel.getListProductInCart().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể thanh toán khi giỏ hàng trống!");
                return "redirect:/shop";
            }
            model.addAttribute("listCart", cartViewModel.getListProductInCart());
            model.addAttribute("tongTien", cartViewModel.tongTien());
        } else {
            List<Cart> list = cartService.findCartByUser((Users) session.getAttribute("user"));
            if (list.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể thanh toán khi giỏ hàng trống!");
                return "redirect:/shop";
            }
            Double tongTien = 0.0;
            for (Cart x : list) {
                Product product = x.getProduct();
                tongTien += (product.getDonGiaKhiGiam().intValue() != 0 ? product.getDonGiaKhiGiam().doubleValue() : product.getDonGia().doubleValue() * x.getSoLuong());
            }
            model.addAttribute("listCart", list);
            model.addAttribute("tongTien", tongTien);
        }
        return "checkout";
    }

    @GetMapping("/thank-you/{idBill}")
    public String hoaDon(@PathVariable Integer idBill, Model model) {
        Bill bill = billService.getOne(idBill);
        model.addAttribute("bill", bill);
        model.addAttribute("listProduct", billDetailService.findByBill(bill));
        return "bill";
    }

    @PostMapping
    public String payment(Model model, RedirectAttributes redirectAttributes,
                          @ModelAttribute("bill") BillViewModel billViewModel) {
        Bill bill = billService.add(billViewModel);
        redirectAttributes.addFlashAttribute("successMessage", "Đơn hàng đã được đặt!");
        return "redirect:/checkout/thank-you/" + bill.getId();
    }
}
