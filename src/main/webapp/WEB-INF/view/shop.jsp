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
            <div class="col-xl-3 d-none d-xl-block">
                <div class="list-group rounded-0">
                    <a href="?category=&brand=${param.brand}&page=${param.page}"
                       class="list-group-item list-group-item-action bg-dark text-white text-uppercase fw-semibold">Danh
                        mục sản phẩm</a>
                    <c:forEach items="${listCategory}" var="category">
                        <a href="?category=${category.id}&brand=${param.brand}&page=${param.page}"
                           class="list-group-item list-group-item-action ${param.category == category.id ? 'active' : ''}">
                            Xe Đạp ${category.ten}
                        </a>
                    </c:forEach>
                </div>
                <div class="list-group rounded-0 mt-3">
                    <a href="?category=${param.category}&brand=&page=${param.page}"
                       class="list-group-item list-group-item-action bg-dark text-white text-uppercase fw-semibold">Hãng
                        sản xuất</a>
                    <c:forEach items="${listBrand}" var="brand">
                        <a href="?category=${param.category}&brand=${brand.id}&page=${param.page}"
                           class="list-group-item list-group-item-action ${param.brand == brand.id ? 'active' : ''}">
                                ${brand.ten}
                        </a>
                    </c:forEach>
                </div>
                </button>
            </div>
            <div class="col-xl-9">
                <c:if test="${page.isEmpty()}">
                    <div class="d-flex justify-content-center align-items-center fw-semibold fs-5">
                        <p>Chờ đợi không đáng sợ, đáng sợ là biết rõ sẽ <span class="text-danger fw-bold">không có kết quả</span>
                            mà vẫn cứ chờ!</p>
                    </div>
                </c:if>

                <c:if test="${!page.isEmpty()}">
                    <div class="row">
                        <c:forEach items="${page.getContent()}" var="product">
                            <fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol=""
                                              var="donGiaFormat"/>
                            <fmt:formatNumber value="${product.donGiaKhiGiam}" type="currency" currencySymbol=""
                                              var="donGiaKhiGiamFormat"/>
                            <div class="col-xl-6 col-md-6 mb-md-3 mb-sm-3 text-center">
                                <div class="__product-item card rounded-0 border-0">
                                    <div class="__product-item-img">
                                        <img class="card-img rounded-0 "
                                             src="/resources/images/products/${product.hinhAnh}"
                                             width="100%">
                                    </div>
                                    <div class="__hover-item row">
                                        <c:if test="${product.soLuong > 1}">
                                            <div class="col-6 p-0 m-0">
                                                <button type="button" class="btn btn-outline-dark rounded-0"
                                                        onclick="showInfo('${product.id}', '${product.ten}','${product.hinhAnh}', '${product.donGiaKhiGiam.intValue() != 0 ? donGiaKhiGiamFormat : donGiaFormat}', '${product.soLuong}')">
                                                    <i class="fas fa-info"></i></button>
                                            </div>
                                            <form action="/cart/add/${product.id}" method="post" class="col-6 p-0 m-0">
                                                <button type="submit" class="btn btn-dark rounded-0"><i
                                                        class="fas fa-cart-arrow-down"></i>
                                                </button>
                                            </form>
                                            <a class="" href="/shop"></a>
                                        </c:if>
                                        <c:if test="${product.soLuong <= 1}">
                                            <button class="btn btn-outline-dark fw-semibold rounded-0">HẾT HÀNG</button>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="my-3">
                                    <strong>
                                            ${product.ten}
                                        <c:if test="${product.donGiaKhiGiam.intValue() != 0}">
                                            <fmt:formatNumber value="${(product.donGia.doubleValue()-product.donGiaKhiGiam.doubleValue())/product.donGia.doubleValue()*100}" var="giamGia" type="currency" currencySymbol="%"/>
                                            <span class="badge text-bg-danger">- ${giamGia}</span>
                                        </c:if>
                                    </strong>
                                    <c:if test="${product.donGiaKhiGiam.intValue() == 0}">
                                        <p>${donGiaFormat} <strong class="text-danger">VNĐ</strong></p>
                                    </c:if>
                                    <c:if test="${product.donGiaKhiGiam.intValue() != 0}">
                                        <p><del>${donGiaFormat}</del>
                                            ${donGiaKhiGiamFormat}
                                            <strong class="text-danger">VNĐ</strong></p>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <ul class="pagination justify-content-end">
                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=1&category=${param.category}&brand=${param.brand}" aria-label="First">
                            <span aria-hidden="true"><i class="fa-solid fa-angles-left"></i></span>
                        </a>
                    </li>
                    <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${currentPage - 1}&category=${param.category}&brand=${param.brand}"
                           aria-label="Previous">
                            <span aria-hidden="true"><i class="fa-solid fa-caret-left"></i></span>
                        </a>
                    </li>
                    <c:if test="${totalPages >= 1}">
                        <c:forEach begin="0" end="${totalPages - 1}" varStatus="status">
                            <c:choose>
                                <c:when test="${status.index == currentPage}">
                                    <li class="page-item active" aria-current="page">
                                        <span class="page-link">${status.index + 1}</span>
                                    </li>
                                </c:when>
                                <c:when test="${status.index >= currentPage - 2 && status.index <= currentPage + 2}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="?page=${status.index+1}&category=${param.category}&brand=${param.brand}">${status.index + 1}</a>
                                    </li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${currentPage + 1}&category=${param.category}&brand=${param.brand}"
                           aria-label="Next">
                            <span aria-hidden="true"><i class="fa-solid fa-caret-right"></i></span>
                        </a>
                    </li>
                    <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?page=${totalPages - 1}&category=${param.category}&brand=${param.brand}"
                           aria-label="Last">
                            <span aria-hidden="true"><i class="fa-solid fa-angles-right"></i></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp"/>

    <!-- Modal Detail Product -->
    <div class="modal fade" id="detail-product" tabindex="-1" role="dialog" aria-labelledby="modalTitleId"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg" role="document">
            <div class="modal-content rounded-0">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitleId">Thông tin sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/cart/add" method="post" id="formBuyNow">
                        <div class="row">
                            <div class="col-xl-6">
                                <img src="" width="100%" id="productImage">
                            </div>
                            <div class="col-xl-6">
                                <ul class="list-unstyled">
                                    <li><h4 class="fw-bold" id="productName"></h4></li>
                                    <li class="fs-4 my-2"><span id="productPrice">Giá: </span><strong
                                            class="text-danger">
                                        VNĐ</strong></li>
                                    <li class="mb-2">Số lượng hiện có: <strong id="soLuongHienco"></strong></li>
                                    <li style="text-align: justify;">
                                        🔥 Vận Chuyển Toàn Quốc<br>
                                        🔥 Thanh Toán Tại Nhà Sau Khi Nhận Hàng, Quẹt Thẻ Trả Góp<br>
                                        🔥 Được Kiểm Tra Hàng Trước Khi Thanh Toán<br><br>
                                        ------------------<br>
                                        ☎️ Mua hàng: 0395.080.513<br>
                                        📞 Hotline: 0395.080.513<br>
                                        📞 Mua sỉ: 0395.080.513<br>
                                        ⏰ Thời gian làm việc : 8:30 - 19:00 cả tuần<br>
                                        🚘 #SHIP_COD_TOÀN_QUỐC<br>
                                        🏡 Nhổn - Nam Từ Liên - Hà Nội
                                    </li>
                                    <li class="my-3">
                                        <div class="d-flex flex-row">
                                            <div class="flex-fill pr-2 me-2">
                                                <input type="number" id="productQuantity"
                                                       class="form-control rounded-0 w-100 px-0 text-center" min="1"
                                                       value="1" name="soLuong">
                                            </div>
                                            <div class="">
                                                <button type="submit" class="btn btn-outline-dark rounded-0"><i
                                                        class="fas fa-cart-arrow-down"></i> Thêm vào giỏ hàng
                                                </button>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var showInfo = (id, name, image, price, quantity) => {
        $('#productName').text(name);
        $('#productPrice').text(price);
        $('#productQuantity').attr('max',quantity);
        $('#soLuongHienco').text(quantity);
        $('#productImage').attr('src', '/resources/images/products/' + image);
        $('#formAddToCart').attr('action', '/cart/add/' + id);
        $('#formBuyNow').attr('action', '/cart/add/' + id);
        $('#detail-product').modal('show');
    }
</script>
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