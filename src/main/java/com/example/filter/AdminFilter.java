package com.example.filter;

import com.example.model.Users;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AdminFilter", value = {
        "/admin/*",
})
public class AdminFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
        Filter.super.init(config);
        System.out.println("Filter init");
    }

    public void destroy() {
        Filter.super.destroy();
        System.out.println("Filter Destroy");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        Users users = (Users) session.getAttribute("user");
        if (users == null) {
            res.sendRedirect("/login");
        } else if (users != null && users.getVaiTro() == 1) {
            res.sendRedirect("/shop");
        } else if (users != null && users.getVaiTro() == 0) {
            chain.doFilter(request, response);
        }
    }
}
