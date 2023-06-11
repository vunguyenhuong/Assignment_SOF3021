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
    <div class="d-flex justify-content-center align-items-center vh-100">
        <div class="row">
            <h3 class="text-center mb-3">ĐƠN HÀNG ĐÃ NHẬN</h3>
            <p class="text-center">Cảm ơn bạn đã đặt hàng!</p>
            <div class="table-responsive bg-">
                <table class="table table-borderless">
                    <thead>
                    <tr>
                        <th scope="col">Mã đơn hàng</th>
                        <th scope="col">Ngày</th>
                        <th scope="col">Người nhận</th>
                        <th scope="col">Số điện thoại</th>
                        <th scope="col">Phương thức thanh toán</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="">
                        <td scope="row">${bill.id}</td>
                        <td>${bill.ngayTao}</td>
                        <td>${bill.tenNguoiNhan}</td>
                        <td>${bill.sdt}</td>
                        <td>Thanh toán khi nhận hàng (COD)</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="">
                <p class="mt-3">Chi tiết đơn hàng</p>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Đơn giá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${listProduct}" var="item">
                            <tr class="">
                                <td scope="row">
                                    <img src="/resources/images/products/${item.product.hinhAnh}" width="70px">
                                        ${item.product.ten}
                                </td>
                                <td>${item.soLuong}</td>
                                <td><fmt:formatNumber value="${item.donGia}" type="currency"
                                                      currencySymbol="VNĐ"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <a href="/shop">Quay lại trang chủ</a>
            </div>
        </div>
    </div>
    <jsp:include page="layout/footer.jsp"/>
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
<script src="/resources/vendor/boostrap/boostrap.min.js"></script>
<script src="/resources/vendor/boostrap/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</html>