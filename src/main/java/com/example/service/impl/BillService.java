package com.example.service.impl;

import com.example.model.Bill;
import com.example.model.BillDetail;
import com.example.model.Cart;
import com.example.model.Product;
import com.example.model.Users;
import com.example.repository.IBillDetailRepository;
import com.example.repository.IBillRepository;
import com.example.repository.ICartRepository;
import com.example.repository.IProductRepository;
import com.example.service.CartSessionSerivce;
import com.example.service.IBillService;
import com.example.service.ICartService;
import com.example.viewmodel.BillViewModel;
import com.example.viewmodel.ProductViewModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class BillService implements IBillService {
    @Autowired
    private IBillRepository billRepository;
    @Autowired
    private HttpSession session;
    @Autowired
    private CartSessionSerivce cartSessionSerivce;
    @Autowired
    private IProductRepository productRepository;
    @Autowired
    private IBillDetailRepository billDetailRepository;
    @Autowired
    private ICartService cartService;

    @Override
    public List<Bill> getAll() {
        return billRepository.findAll();
    }

    @Override
    public Bill getOne(Integer id) {
        return billRepository.findById(id).orElse(null);
    }

    @Override
    public Bill add(BillViewModel x) {
        Users users = null;
        if (session.getAttribute("user") != null) {
            users = (Users) session.getAttribute("user");
        }
        Bill bill = new Bill();
        bill.setUsers(users);
        bill.setNgayTao(Date.valueOf(LocalDate.now()));
        bill.setTrangThai(0);
        bill.setDiaChi(x.getXa() + ", " + x.getHuyen() + ", " + x.getTinh());
        BeanUtils.copyProperties(x, bill);
        billRepository.save(bill);
        if (users == null) {
            List<ProductViewModel> list = cartSessionSerivce.viewAllCart().getListProductInCart();
            for (int i = 0; i < list.size(); i++) {
                BillDetail billDetail = new BillDetail();
                Product product = productRepository.findById(list.get(i).getId()).get();
                billDetail.setBill(bill);
                billDetail.setProduct(product);
                billDetail.setSoLuong(list.get(i).getSoLuong());
                billDetail.setDonGia(list.get(i).getDonGia());
                billDetail.setTrangThai(0);
                billDetailRepository.save(billDetail);
                product.setSoLuong(product.getSoLuong() - list.get(i).getSoLuong());
                productRepository.save(product);
            }
            cartSessionSerivce.removeAllCart();
            session.setAttribute("totalCart", cartSessionSerivce.viewAllCart().getListProductInCart().size());
        } else {
            List<Cart> listCart = cartService.findCartByUser(users);
            for (Cart cart : listCart) {
                BillDetail billDetail = new BillDetail();
                Product product = cart.getProduct();
                billDetail.setBill(bill);
                billDetail.setProduct(product);
                billDetail.setSoLuong(cart.getSoLuong());
                billDetail.setDonGia(product.getDonGiaKhiGiam().intValue() != 0 ? product.getDonGiaKhiGiam() : product.getDonGia());
                billDetail.setTrangThai(0);
                billDetailRepository.save(billDetail);
                product.setSoLuong(product.getSoLuong() - cart.getSoLuong());
                productRepository.save(product);
            }
            cartService.removeAllProduct(users);
            session.setAttribute("totalCart", listCart.size());
        }
        return bill;
    }
}
