package com.example.service;

import com.example.model.Bill;
import com.example.model.BillDetail;

import java.util.List;

public interface IBillDetailService {
    List<BillDetail> findByBill(Bill bill);
    BillDetail save(BillDetail billDetail);
    void delete(Integer id);
}
