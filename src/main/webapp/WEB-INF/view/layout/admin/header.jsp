<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header>
    <nav class="navbar navbar-expand-lg navbar-light fw-bold small py-3">
        <div class="container">
            <a class="navbar-brand" href="/dashboard">Admin Dashboard</a>
            <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapsibleNavId" aria-controls="collapsibleNavId"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="collapsibleNavId">
                <ul class="navbar-nav me-auto mt-2 mt-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/product"><i class="fa-solid fa-bicycle"></i> Xe đạp</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/thong-ke"><i class="fa-solid fa-chart-pie"></i> Thống kê</a>
                    </li>
                </ul>
                <c:if test="${not empty sessionScope.user}">
                    <nav class="navbar">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                   aria-expanded="false">
                                    <i class="fas fa-user"></i> <span class="ms-1"> Xin chào, <span
                                        class="text-danger">${sessionScope.user.ten}</span></span>
                                </a>
                                <ul class="dropdown-menu rounded-0">
                                    <li><a class="dropdown-item" href="#" type="button" data-bs-toggle="modal"
                                           data-bs-target="#infomationModal">Thông tin cá nhân</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li><a class="dropdown-item" href="/logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>

                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <button type="button" class="bg-white border-0 text-success fw-semibold" data-bs-toggle="modal"
                            data-bs-target="#login">
                        <i class="fas fa-user"></i> Đăng nhập
                    </button>
                </c:if>
            </div>
        </div>
    </nav>
</header>

<!-- Modal Login -->
<div class="modal fade" id="login" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-0">
            <div class="modal-header">
                <div class="d-flex justify-content-center w-100">
                    ĐĂNG NHẬP
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/login" method="post">
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-envelope me-1 text-muted"></i> Tên đăng nhập</label>
                        <input type="text" class="form-control rounded-0" name="email">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-key me-1 text-muted"></i> Mật khẩu</label>
                        <input type="password" class="form-control rounded-0" name="password">
                    </div>
                    <button type="submit" class="btn btn-dark w-100 rounded-0 my-2">Đăng nhập</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

<!-- Modal Infomation -->
<div class="modal fade" id="infomationModal" tabindex="-1" aria-labelledby="infomationModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content rounded-0">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Infomation</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" action="/update-user">
                    <input name="vaiTro" value="${sessionScope.user.vaiTro}" hidden>
                    <input name="id" value="${sessionScope.user.id}" hidden>
                    <div class="col-12 mb-3">
                        <label class="form-label">Tên</label>
                        <input type="text" class="form-control rounded-0" name="ten" value="${sessionScope.user.ten}">
                    </div>
                    <div class="col-12 mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control rounded-0"
                               value="${sessionScope.user.email}">
                    </div>
                    <div class="col-12 mb-3">
                        <label for="password">Mật khẩu</label>
                        <div class="input-group rounded-0">
                            <input type="password" id="password" class="form-control rounded-0" name="matKhau"
                                   value="${sessionScope.user.matKhau}">
                            <button class="btn btn-outline-secondary rounded-0" type="button" id="togglePassword">
                                <i class="fa-solid fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-12 mb-3">
                        <button type="submit" class="btn btn-dark rounded-0 w-100">Chỉnh sửa thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    const togglePasswordButton = document.querySelector("#togglePassword");
    const passwordInput = document.querySelector("#password");

    togglePasswordButton.addEventListener("click", function () {
        const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
        passwordInput.setAttribute("type", type);
        this.querySelector("i").classList.toggle("fa-eye");
        this.querySelector("i").classList.toggle("fa-eye-slash");
    });
</script>
<script src="/resources/vendor/boostrap/popper.min.js"></script>