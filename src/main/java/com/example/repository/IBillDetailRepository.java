package com.example.repository;

import com.example.dto.ThongKeSanPham;
import com.example.model.Bill;
import com.example.model.BillDetail;
import com.example.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface IBillDetailRepository extends JpaRepository<BillDetail, Integer> {
    Boolean existsByBillAndProduct(Bill bill, Product product);

    List<BillDetail> findByBill(Bill bill);

    @Query("""
            SELECT new com.example.dto.ThongKeSanPham(b.product,sum(b.soLuong)) FROM BillDetail b
            WHERE (:year is null  or YEAR (b.bill.ngayTao) = :year)
            AND (:month is null  or MONTH (b.bill.ngayTao) = :month)
            AND (:day is null or DAY (b.bill.ngayTao) = :day)
            GROUP BY b.product
            ORDER BY sum(b.soLuong) DESC 
            """)
    Page<ThongKeSanPham> top10SanPhamBanChay(@Param("year") Integer year,
                                             @Param("month") Integer month,
                                             @Param("day") Integer day,
                                             Pageable pageable);

    @Query("""
            SELECT p FROM Product p WHERE p not in (SELECT b.product FROM BillDetail b)
            """)
    Page<Product> top10SanPhamTon(Pageable pageable);
}
