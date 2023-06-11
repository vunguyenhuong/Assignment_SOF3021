package com.example.repository;

import com.example.model.Cart;
import com.example.model.Product;
import com.example.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ICartRepository extends JpaRepository<Cart, Integer> {
    Cart findByUsersAndProduct(Users users, Product product);
    Boolean existsByUsersAndProduct(Users users,Product product);
    List<Cart> findByUsers(Users users);
}
