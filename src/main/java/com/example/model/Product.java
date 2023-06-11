package com.example.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter

@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma")
    @NotEmpty(message = "Ma null")
    private String ma;

    @Column(name = "ten")
    @NotEmpty(message = "ten null")
    private String ten;

    @Column(name = "vanhxe")
    private String vanhXe;

    @Column(name = "phanhxe")
    private String phanhXe;

    @Column(name = "bandap")
    private String banDap;

    @Column(name = "soluong")
    @Min(1)
    private Integer soLuong;

    @Column(name = "dongia")
    @DecimalMin(value = "0", message = "don gia null")
    private BigDecimal donGia;
    @Column(name = "dongiakhigiam")
    @DecimalMin(value = "0", message = "don gia null")
    private BigDecimal donGiaKhiGiam;

    @Column(name = "hinhanh")
    private String hinhAnh;

    @Column(name = "mota")
    private String moTa;

    @ManyToOne
    @JoinColumn(name = "idcate")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "idbrand")
    private Brand brand;
}
