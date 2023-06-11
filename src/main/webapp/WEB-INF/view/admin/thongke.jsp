<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<fmt:setBundle basename="java.text.resources"/>
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
    <jsp:include page="../layout/admin/header.jsp"/>
    <main>
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-7">
                    <canvas id="myChart"></canvas>
                </div>
                <div class="col-xl-5">
                    <form method="get">
                        <div class="row mb-3">
                            <div class="col-xl-3">
                                <label class="form-label">Ngày</label>
                                <input type="text" class="form-control rounded-0" name="day" value="${param.day}">
                            </div>
                            <div class="col-xl-3">
                                <label class="form-label">Tháng</label>
                                <input type="text" class="form-control rounded-0" name="month" value="${param.month}">
                            </div>
                            <div class="col-xl-3">
                                <label class="form-label">Năm</label>
                                <input type="text" class="form-control rounded-0" name="year" value="${param.year}">
                            </div>
                            <div class="col-xl-3">
                                <label class="form-label">Action</label>
                                <div>
                                    <button type="submit" class="btn btn-dark rounded-0">
                                        <i class="fas fa-filter"></i>
                                        Lọc</button>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="table-responsive">
                        <table class="table table-bordered table-sm text-white">
                            <thead>
                            <tr class="bg-dark">
                                <th scope="col">#</th>
                                <th scope="col">Tên sản phẩm</th>
                                <th scope="col">SL bán ra</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageTop10BanChay.getContent()}" var="item" varStatus="i">
                                <c:if test="${i.index < 3}">
                                    <tr class="bg-success">
                                        <td>${i.index+1}</td>
                                        <td>${item.product.ten}</td>
                                        <td>${item.soLuong}</td>
                                    </tr>
                                </c:if>
                                <c:if test="${i.index >= 3 && i.index < 6}">
                                    <tr class="bg-warning">
                                        <td>${i.index+1}</td>
                                        <td>${item.product.ten}</td>
                                        <td>${item.soLuong}</td>
                                    </tr>
                                </c:if>
                                <c:if test="${i.index >= 6}">
                                    <tr class="bg-danger">
                                        <td>${i.index+1}</td>
                                        <td>${item.product.ten}</td>
                                        <td>${item.soLuong}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-xl-12">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <th scope="col">Tên sản phẩm</th>
                                <th scope="col">Đơn giá</th>
                                <th scope="col">Số lượng tồn</th>
                                <th scope="col">Ảnh</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageTop10Ton.getContent()}" var="item">
                                <tr class="">
                                    <td>${item.ten}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="VNĐ"/>
                                    </td>
                                    <td>${item.soLuong}</td>
                                    <td>
                                        <img src="/resources/images/products/${item.hinhAnh}" width="64px">
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="../layout/footer.jsp"/>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    var labels = [<c:forEach items="${labelTop10}" var="item">"${item}", </c:forEach>];
    var values = [<c:forEach items="${valueTop10}" var="item">"${item}", </c:forEach>];

    // Tạo biểu đồ cột
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Số lượng bán ra',
                data: values,
                backgroundColor: 'rgba(54, 162, 235, 0.8)', // Màu nền cột
                borderColor: 'rgba(54, 162, 235, 1)', // Màu viền cột
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: 'Top 10 sản phẩm bán chạy nhất'
                },
                subtitle: {
                    display: true,
                    text: '(Dữ liệu được cập nhật bởi Vũ Nguyên Hướng)'
                }
            }
        }
    });
</script>

<script src="/resources/js/product.js"></script>
<script src="/resources/vendor/boostrap/boostrap.min.js"></script>
<script src="/resources/vendor/boostrap/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</html>