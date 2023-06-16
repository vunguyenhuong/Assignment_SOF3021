package com.example.service.impl;

import com.example.model.Users;
import com.example.repository.IUsersRepository;
import com.example.service.IUsersService;
import com.example.utils.MailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class UsersService implements IUsersService {
    @Autowired
    private IUsersRepository repository;
    @Autowired
    private HttpSession session;
    @Autowired
    private MailService mailService;

    @Override
    public List<Users> getAll() {
        return repository.findAll();
    }

    @Override
    public Integer checkLogin(String email, String pasword) {
        Users users = repository.findByEmailAndMatKhau(email, pasword).orElse(null);
        if (users == null) return 404;
        session.setAttribute("user", users);
        if (users.getVaiTro() == 0) return 0;
        else return 1;
    }

    @Override
    public Users save(Users users) {
        return repository.save(users);
    }

    @Override
    public Integer logOut() {
        Users users = (Users) session.getAttribute("user");
        if (users != null) {
            session.removeAttribute("user");
            if (users.getVaiTro() == 0) return 0;
        }
        return 1;
    }

    @Override
    public Integer forgotPasword(String email) {
        String randomPassword = UUID.randomUUID().toString().substring(0, 6);
        Users users = repository.findByEmail(email).orElse(null);
        if (users != null) {
            users.setMatKhau(randomPassword);
            repository.save(users);
            mailService.sendEmail(email, "Mật khẩu cùa bạn đã được đặt lại!",
                    "Xin chào, mật khẩu mới của bạn là: " + randomPassword);
            return 1;
        }
        return 0;
    }

    @Override
    public Integer updateUser(Users users) {
        if(users.getTen().isEmpty() || users.getEmail().isEmpty() || users.getMatKhau().isEmpty()){
            return -1;
        }
        Users users1 = (Users) session.getAttribute("user");
        BeanUtils.copyProperties(users, users1);
        repository.save(users1);
        if(users1.getVaiTro() ==0) return 0;
        return 1;
    }
}
