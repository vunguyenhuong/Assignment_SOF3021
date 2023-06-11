package com.example.controller;

import com.example.dto.ThongKeSanPham;
import com.example.repository.IBillDetailRepository;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/thong-ke")
public class ThongKeController {
    @Autowired
    private IBillDetailRepository billDetailRepository;

    @GetMapping
    public String top10SanPhamBanChay(Model model,
                                      @RequestParam(value = "year", required = false) Integer year,
                                      @RequestParam(value = "month", required = false) Integer month,
                                      @RequestParam(value = "day", required = false) Integer day
    ) {
        Pageable pageable = PageRequest.of(0, 10);
        Page<ThongKeSanPham> top10BanChay = billDetailRepository.top10SanPhamBanChay(year, month, day, pageable);
        List<String> labelTop10 = new ArrayList<>();
        List<Long> valueTop10 = new ArrayList<>();
        for (ThongKeSanPham x: top10BanChay) {
            labelTop10.add(x.getProduct().getTen());
            valueTop10.add(x.getSoLuong());
        }
        model.addAttribute("labelTop10", labelTop10);
        model.addAttribute("valueTop10", valueTop10);
        model.addAttribute("pageTop10Ton", billDetailRepository.top10SanPhamTon(pageable));
        model.addAttribute("pageTop10BanChay", top10BanChay);
        return "admin/thongke";
    }
}
