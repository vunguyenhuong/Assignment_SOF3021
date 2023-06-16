package com.example.controller.auth;

import com.example.model.Users;
import com.example.service.IUsersService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller
public class AuthController {
    @Autowired
    private IUsersService usersService;
    @Autowired
    private HttpSession session;

    @ModelAttribute("user")
    private Users getUser() {
        return new Users();
    }

    @GetMapping("/login")
    public String viewLogin() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(RedirectAttributes redirectAttributes,
                        @RequestParam("email") String email,
                        @RequestParam("password") String password) {
        Integer check = usersService.checkLogin(email, password);
        redirectAttributes.addFlashAttribute(check == 404 ? "errorMessage" : "successMessage", check == 404 ? "Thông tin tài khoản hoặc mật khẩu không chính xác!" : "Đăng nhập thành công!");
        return check == 0 ? "redirect:/admin/product" : "redirect:/shop";
    }

    @PostMapping("/register")
    public String register(RedirectAttributes redirectAttributes,
                           @ModelAttribute("users") Users users) {
        users.setVaiTro(1);
        if (usersService.save(users) != null) {
            redirectAttributes.addFlashAttribute("successMessage", "Đăng ký thành công!");
        }
        return "redirect:/shop";
    }

    @GetMapping("/logout")
    public String logOut(RedirectAttributes redirectAttributes) {
        Integer check = usersService.logOut();
        redirectAttributes.addFlashAttribute("successMessage", "Đăng xuất thành công!");
        return check == 0 ? "redirect:/admin/product" : "redirect:/shop";
    }

    @GetMapping("/forgot")
    public String viewForgot() {
        String randomString = UUID.randomUUID().toString().substring(0, 8);
        session.setAttribute("maXacNhan", randomString);
        return "auth/forgot";
    }

    @PostMapping("/forgot")
    public String forgot(RedirectAttributes redirectAttributes,
                         @RequestParam String email,
                         @RequestParam String ma) {
        Integer checkSuccess = -1;
        if (ma.equals(session.getAttribute("maXacNhan"))) {
            checkSuccess = usersService.forgotPasword(email);
        }
        if (checkSuccess == 1) {
            redirectAttributes.addFlashAttribute("successMessage", "Mật khẩu mới đã được gửi tới hòm thư, vui lòng kiểm tra!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", checkSuccess == 0 ? "Thông tin tài khoản không chính xác!" : "Mã xác nhận không chính xác!");
        }
        return checkSuccess == -1 || checkSuccess == 0 ? "redirect:/forgot" : "redirect:/login";
    }

    @PostMapping("/update-user")
    public String updateUser(@ModelAttribute("user") Users users, RedirectAttributes redirectAttributes) {
        Integer check = usersService.updateUser(users);
        if (check == -1) {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật thông tin thất bại!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thông tin thành công!");
        }
        return check == 0 ? "redirect:/admin/product" : "redirect:/shop";
    }
}
