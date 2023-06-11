package com.example.viewmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BillViewModel {
    private String tenNguoiNhan;
    private String tinh;
    private String huyen;
    private String xa;
    private String email;
    private String sdt;
    private BigDecimal phiShip;
    private String ghiChu;
    private Integer trangThai;
}
