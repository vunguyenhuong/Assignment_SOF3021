package com.example.service.impl;

import com.example.model.Bill;
import com.example.model.BillDetail;
import com.example.model.Product;
import com.example.repository.IBillDetailRepository;
import com.example.repository.IProductRepository;
import com.example.service.CartSessionSerivce;
import com.example.service.IBillDetailService;
import com.example.viewmodel.CartViewModel;
import com.example.viewmodel.ProductViewModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillDetailService implements IBillDetailService {
    @Autowired
    private IBillDetailRepository repository;
    @Autowired
    private IProductRepository productRepository;
    @Autowired
    private HttpSession session;
    @Autowired
    private CartSessionSerivce cartSessionSerivce;

    @Override
    public List<BillDetail> findByBill(Bill bill) {
        return repository.findByBill(bill);
    }

    @Override
    public BillDetail save(BillDetail billDetail) {
        return repository.save(billDetail);
    }

    @Override
    public void delete(Integer id) {
        repository.deleteById(id);
    }
}
