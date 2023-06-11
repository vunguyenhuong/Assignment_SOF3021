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
    <jsp:include page="../layout/admin/header.jsp"/>
    <main>
        <form method="post" action="/admin/product/update/${product.id}" enctype="multipart/form-data" id="formUpdateProduct">
            <h4 class="text-uppercase my-3">Cập nhật sản phẩm</h4>
            <div class="row">
                <div class="col-xl-8">
                    <div class="row">
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Mã</label>
                            <input name="ma" class="form-control rounded-0" value="${product.ma}"/>
                            <small class="form-text text-danger error"></small>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Tên</label>
                            <input name="ten" class="form-control rounded-0" value="${product.ten}" />
                            <small class=" form-text text-danger error"></small>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Vành</label>
                            <select class="form-select form-select rounded-0" name="vanhXe">
                                <option value="24" ${product.vanhXe == '24' ? 'selected' : ''}>24 inch</option>
                                <option value="25" ${product.vanhXe == '25' ? 'selected' : ''}>25 inch</option>
                                <option value="26" ${product.vanhXe == '26' ? 'selected' : ''}>26 inch</option>
                                <option value="27" ${product.vanhXe == '27' ? 'selected' : ''}>27 inch</option>
                            </select>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Phanh</label>
                            <select class="form-select form-select rounded-0" name="phanhXe">
                                <option value="Phanh đĩa" ${product.phanhXe == 'Phanh đĩa' ? 'selected' : ''}>Phanh
                                    đĩa
                                </option>
                                <option value="Phanh dầu" ${product.phanhXe == 'Phanh dầu' ? 'selected' : ''}>Phanh
                                    dầu
                                </option>
                                <option value="Phanh dây" ${product.phanhXe == 'Phanh dây' ? 'selected' : ''}>Phanh
                                    dây
                                </option>
                            </select>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Bàn đạp</label>
                            <select class="form-select form-select rounded-0" name="banDap">
                                <option value="Wellgo" ${product.banDap == 'Wellgo' ? 'selected' : ''}>Wellgo</option>
                                <option value="Pacific" ${product.banDap == 'Pacific' ? 'selected' : ''}>Pacific
                                </option>
                                <option value="Promend" ${product.banDap == 'Promend' ? 'selected' : ''}>Promend
                                </option>
                            </select>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" min="1" name="soLuong" class="form-control rounded-0"
                                   value="${product.soLuong}"/>
                            <small class="form-text text-danger error"></small>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Đơn giá</label>
                            <input name="donGia" class="form-control rounded-0" value="${product.donGia}"/>
                            <small class="form-text text-danger error"></small>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Hình ảnh</label>
                            <input type="file" name="hinhAnh" class="form-control rounded-0" id="imgInp"
                                   accept="image/*" value="${product.hinhAnh}"/>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Danh mục</label>
                            <select class="form-select form-select rounded-0" name="id_cate">
                                <c:forEach items="${listCategory}" var="category">
                                    <option value="${category.id}" ${product.category.id == category.id ? 'selected' : ''}>${category.ten}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Hãng</label>
                            <select class="form-select form-select rounded-0" name="id_brand">
                                <c:forEach items="${listBrand}" var="brand">
                                    <option value="${brand.id}" ${product.brand.id == brand.id ? 'selected' : ''}>${brand.ten}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-xl-4 mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control rounded-0" name="moTa" rows="3">${product.moTa}</textarea>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4">
                    <div class="__product-item-img">
                        <img class="card-img-top" id="blah" src="#"
                             onerror="this.onerror=null; this.src='/resources/images/products/${product.hinhAnh}'"/>
                    </div>
                </div>
                <button type="button" class="btn btn-dark rounded-0" onclick="showConfirmSubmit('Xác nhận cập nhật ?','formUpdateProduct')">Cập nhật</button>
            </div>
        </form>
    </main>

    <jsp:include page="../layout/footer.jsp"/>
</div>
</body>

<c:if test="${not empty successMessage}">
    <script>
        swal('Good job!', "${successMessage}", 'success');
    </script>
</c:if>
<script src="/resources/js/product.js"></script>
<script src="/resources/vendor/boostrap/boostrap.min.js"></script>
<script src="/resources/vendor/boostrap/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</html>