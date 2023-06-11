package com.example.service;

import com.example.model.Bill;
import com.example.viewmodel.BillViewModel;

import java.util.List;

public interface IBillService {
    List<Bill> getAll();
    Bill getOne(Integer id);
    Bill add(BillViewModel billViewModel);
}
