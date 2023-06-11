package com.example.service;

import com.example.model.Users;

import java.util.List;
import java.util.Optional;

public interface IUsersService {
    List<Users> getAll();
    Integer checkLogin(String email, String pasword);
    Users save(Users users);

    Integer logOut();

    Integer forgotPasword(String email);

    Integer updateUser(Users users);
}
