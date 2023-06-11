<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
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
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
</head>
<body>
<div class="container-fluid">
    <div class="d-flex justify-content-center align-items-center vh-100">
        <div class="row">
            <h5 class="text-center mb-3">QUÊN MẬT KHẨU</h5>
            <div class="mb-3">
                <form method="post">
                    <label class="form-label">Email tài khoản khôi phục:</label>
                    <input type="text" class="form-control rounded-0" name="email" placeholder="example@example.com">
                    <label class="form-label mt-3">Nhập mã xác nhận: <span
                            class="text-danger fw-semibold">${maXacNhan}</span></label>
                    <input type="text" class="form-control rounded-0" name="ma">
                    <button type="submit" class="btn btn-dark rounded-0 w-100 mt-3">Submit</button>
                </form>
            </div>
        </div>
    </div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</html>