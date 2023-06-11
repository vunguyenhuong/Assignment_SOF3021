<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<fmt:setBundle basename="java.text.resources"/>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="/resources/vendor/boostrap/boostrap.min.css">
    <script src="/resources/vendor/sweetalert/sweetalert.min.js"></script>
    <script src="/resources/vendor/angular/angular.min.js"></script>
    <script src="/resources/vendor/angular/angular-route.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
</head>
<body>
<div class="container-fluid">
    <jsp:include page="layout/header.jsp"/>

    <main>
        <div class="row">
            <div class="d-flex align-items-center justify-content-between bg-light p-5">
                <h2 class="text-uppercase display-6 fw-semibold">Giỏ hàng</h2>
                <nav class="breadcrumb">
                    <a class="breadcrumb-item text-decoration-none text-black fw-bold" href="/home">Trang chủ</a>
                    <a class="breadcrumb-item text-decoration-none text-muted fw-bold" href="/cart">Giỏ hàng</a>
                </nav>
            </div>
            <div class="d-flex">
                <div class="p-2 flex-grow-1">
                    <h4 class="pt-4 pb-2 fw-semibold text-uppercase">Sản phẩm trong giỏ</h4>
                </div>
                <c:if test="${totalCart >= 1}">
                    <div class="p-2">
                        <button type="submit" class="btn btn-outline-dark rounded-0" form="updateCart"><i
                                class="fas fa-edit"></i> Cập nhật giỏ hàng
                        </button>
                    </div>
                    <div class="p-2">
                        <button class="btn btn-outline-dark rounded-0" type="button"
                                onclick="showConfirm('Xác nhận xóa toàn bộ giỏ hàng ?', '/cart/removeAll')"><i
                                class="fas fa-trash"></i> Xóa toàn bộ giỏ hàng
                        </button>
                    </div>
                </c:if>
            </div>
            <div class="col-xl-8">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered">
                        <thead class="table-light">
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Đơn giá</th>
                            <th class="w-25">Số lượng</th>
                            <th>Tổng tiền</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${not empty sessionScope.user}">
                            <form action="/cart/update" method="post" id="updateCart">
                                <c:forEach items="${listCart}" var="item">
                                    <input name="id" value="${item.id}" class="d-none"/>
                                    <tr class="">
                                        <td scope="row">
                                            <img src="/resources/images/products/${item.product.hinhAnh}" width="64px"/>
                                                ${item.product.ten}
                                        </td>
                                        <td><fmt:formatNumber value="${item.donGia}" type="currency"
                                                              currencySymbol=""/></td>
                                        <td>
                                            <input type="number" value="${item.soLuong}"
                                                   class="form-control rounded-0 p-1" name="soLuong" min="1" max="${item.product.soLuong}" required>
                                        </td>
                                        <td>
                                            <c:set var="tongTienFormat" value="${item.donGia*item.soLuong}"/>
                                            <fmt:formatNumber value="${tongTienFormat}" type="currency"
                                                              currencySymbol="VNĐ"/></td>
                                        </td>
                                        <td>
                                            <a href="/cart/remove/${item.id}" role="button"><i
                                                    class="text-black fas fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </form>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <form action="/cart/update" method="post" id="updateCart">
                                <c:forEach items="${listCart}" var="item">
                                    <input name="id" value="${item.id}" class="d-none"/>
                                    <tr class="">
                                        <td scope="row">
                                            <img src="/resources/images/products/${item.hinhAnh}" width="64px"/>
                                                ${item.ten}
                                        </td>
                                        <td><fmt:formatNumber value="${item.donGia}" type="currency"
                                                              currencySymbol=""/></td>
                                        <td>
                                            <input type="number" value="${item.soLuong}"
                                                   class="form-control rounded-0 p-1" name="soLuong" min="1" required>
                                        </td>
                                        <td><fmt:formatNumber value="${item.donGia*item.soLuong}" type="currency"
                                                              currencySymbol=""/></td>
                                        <td>
                                            <a href="/cart/remove/${item.id}" role="button"><i
                                                    class="text-black fas fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </form>
                        </c:if>

                        </tbody>
                    </table>
                    <div class="mt-2 bg-light d-flex align-items-center justify-content-between py-3 px-4">
                        <a href="/shop" class="text-black small"><i class="fas fa-long-arrow-alt-left me-1"></i> Trở lại
                            trang chủ</a>
                        <a href="/checkout" class="btn btn-outline-dark btn-sm rounded-0 px-4 py-2">Thanh toán <i
                                class="fas fa-long-arrow-alt-right ms-1"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 bg-light px-5 pb-4 mt-3 mt-xl-0">
                <h5 class="py-4 fw-bold text-uppercase">Thành tiền</h5>
                <ul class="list-unstyled">
                    <li class="d-flex align-items-center justify-content-between">
                        <strong class="text-uppercase small">Tổng</strong>
                        <span class="text-muted">
                            <fmt:formatNumber value="${tongTien}" type="currency"
                                              currencySymbol=""/>
                            <strong>VNĐ</strong></span>
                    </li>
                    <hr>
                    <li class="d-flex align-items-center justify-content-between">
                        <strong class="text-uppercase small">Phải trả</strong>
                        <span><fmt:formatNumber value="${tongTien}" type="currency"
                                                currencySymbol=""/> <strong>VNĐ</strong></span>
                    </li>
                </ul>
                <form action="" method="post">
                    <input type="text" class="form-control rounded-0 mb-2" placeholder="Nhập mã giảm giá">
                    <button type="submit" class="btn btn-dark text-uppercase w-100 rounded-0 fw-semibold">
                        <small><i class="fas fa-gift"></i> APPLY COUNPON</small></button>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp"/>
</div>
</body>
<c:if test="${not empty successMessage}">
    <script>
        swal('Good job!', "${successMessage}", 'success');
    </script>
</c:if>
<c:if test="${not empty errorMessage}">
    <script>
        swal('Oops!', "${errorMessage}", 'error');
    </script>
</c:if>
<script src="/resources/js/product.js"></script>
<script src="/resources/vendor/boostrap/boostrap.min.js"></script>
<script src="/resources/vendor/boostrap/popper.min.js"></script>
</html>