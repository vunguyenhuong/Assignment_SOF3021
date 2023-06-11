package com.example.repository;

import com.example.model.Brand;
import com.example.model.Category;
import com.example.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer> {
    @Query("SELECT p FROM Product p WHERE (:name is null or p.ten LIKE %:name%) " +
            "and (:minPrice is null or p.donGia >= :minPrice)" +
            "and (:maxPrice is null or p.donGia <= :maxPrice)" +
            "and (:category is null or p.category = :category)" +
            "and (:brand is null or p.brand = :brand)" +
            "and (:vanhXe is null or p.vanhXe = :vanhXe or :vanhXe = '')")
    Page<Product> filterProduct(@Param("name") String name,
                                @Param("minPrice") BigDecimal minPrice,
                                @Param("maxPrice") BigDecimal maxPrice,
                                @Param("category") Category category,
                                @Param("brand") Brand brand,
                                @Param("vanhXe") String vanhXe, Pageable pageable);
}
