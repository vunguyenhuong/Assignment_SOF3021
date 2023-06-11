package com.example.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "bill")
public class Bill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "tennguoinhan")
    private String tenNguoiNhan;
    @Column(name = "ngaytao")
    @Temporal(TemporalType.DATE)
    private Date ngayTao;
    @Column(name = "diachi")
    private String diaChi;
    @Column(name = "email")
    private String email;
    @Column(name = "sdt")
    private String sdt;
    @Column(name = "ghichu")
    private String ghiChu;
    @Column(name = "phiship")
    private BigDecimal phiShip;
    @Column(name = "trangthai")
    private Integer trangThai;
    @ManyToOne
    @JoinColumn(name = "iduser")
    private Users users;
}
