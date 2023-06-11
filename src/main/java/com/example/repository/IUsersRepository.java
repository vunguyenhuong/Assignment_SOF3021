package com.example.repository;

import com.example.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IUsersRepository extends JpaRepository<Users, Integer> {
    Optional<Users> findByEmailAndMatKhau(String email, String matKhau);
    Optional<Users> findByEmail(String email);
}
