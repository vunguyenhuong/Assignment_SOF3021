package com.example.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "billdetail")
public class BillDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "soluong")
    private Integer soLuong;
    @Column(name = "dongia")
    private BigDecimal donGia;
    @Column(name = "trangthai")
    private Integer trangThai;
    @ManyToOne
    @JoinColumn(name = "idbill")
    private Bill bill;
    @ManyToOne
    @JoinColumn(name = "idproduct")
    private Product product;
}
