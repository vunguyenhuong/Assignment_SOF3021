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
        <div class="d-flex">
            <div class="p-2 flex-grow-1">

            </div>
            <div class="p-2">
                <button type="button" class="btn btn-outline-dark rounded-0" data-bs-toggle="modal"
                        data-bs-target="#addProduct">
                    <i class="fas fa-circle-plus"></i> Thêm sản phẩm
                </button>
            </div>
        </div>
        <form method="get">
            <div class="d-flex">
                <div class="order-0 pe-1">
                    <label class="form-label">Tên sản phẩm</label>
                    <input type="text" name="name" class="form-control rounded-0" value="${param.name}">
                </div>
                <div class="order-1 pe-1">
                    <label class="form-label">Giá</label>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control rounded-0" name="minPrice" placeholder="Giá tối thiểu"
                               value="${param.minPrice}">
                        <span class="input-group-text">to</span>
                        <input type="text" class="form-control rounded-0" name="maxPrice" placeholder="Giá tối đa"
                               value="${param.maxPrice}">
                    </div>
                </div>
                <div class="order-2 pe-1">
                    <p class="form-label">Danh mục</p>
                    <select class="form-select form-select rounded-0" name="category">
                        <option value="">--Lựa chọn--</option>
                        <c:forEach items="${listCategory}" var="category">
                            <option value="${category.id}" ${param.category == category.id ? 'selected' : ''}>${category.ten}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="order-3 pe-1">
                    <label class="form-label">Hãng</label>
                    <select class="form-select form-select rounded-0" name="brand">
                        <option value="">--Lựa chọn--</option>
                        <c:forEach items="${listBrand}" var="brand">
                            <option value="${brand.id}" ${param.brand == brand.id ? 'selected' : ''}>${brand.ten}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="order-1 pe-1">
                    <label class="form-label">Vành</label>
                    <select class="form-select form-select rounded-0" name="vanhXe">
                        <option value="">--Lựa chọn--</option>
                        <option value="24" ${param.vanhXe == '24' ? 'selected' : ''}>24 inch</option>
                        <option value="25" ${param.vanhXe == '25' ? 'selected' : ''}>25 inch</option>
                        <option value="26" ${param.vanhXe == '26' ? 'selected' : ''}>26 inch</option>
                        <option value="27" ${param.vanhXe == '27' ? 'selected' : ''}>27 inch</option>
                    </select>
                </div>
                <div class="order-5">
                    <p class="form-label">Action</p>
                    <div class="btn-group" role="group" aria-label="Basic example">
                        <button type="submit" class="btn btn-dark rounded-0"><i class="fas fa-filter"></i> Lọc</button>
                        <a href="/admin/product" class="btn btn-danger rounded-0"><i class="fa-solid fa-xmark"></i></a>
                    </div>
                </div>
            </div>
        </form>
        <div class="table-responsive table text-nowrap">
            <table class="table table-light table-hover table-bordered">
                <thead>
                <tr>
                    <th class="p-1">#</th>
                    <th class="p-1">Tên</th>
                    <th class="p-1">Vành</th>
                    <th class="p-1">Phanh</th>
                    <th class="p-1">Bàn đạp</th>
                    <th class="p-1">Số lượng</th>
                    <th class="p-1">Đơn giá</th>
                    <th class="p-1">Category</th>
                    <th class="p-1">Ảnh</th>
                    <th class="p-1">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${page.isEmpty()}">
                    <tr>
                        <td colspan="11" class="fw-semibold text-center">Không có bản ghi nào!</td>
                    </tr>
                </c:if>
                <c:if test="${!page.isEmpty()}">
                    <c:forEach items="${page.getContent()}" var="product" varStatus="i">
                        <tr>
                            <td class="p-1">${i.index + 1}</td>
                            <td class="p-1">${product.ten}</td>
                            <td class="p-1">${product.vanhXe}</td>
                            <td class="p-1">${product.phanhXe}</td>
                            <td class="p-1">${product.banDap}</td>
                            <td class="p-1">${product.soLuong}</td>
                            <td class="p-1"><fmt:formatNumber value="${product.donGia}" type="currency"
                                                              currencySymbol=""/></td>
                            <td class="p-1">${product.category.ten}</td>
                            <td class="p-1">
                                <button type="button" class="btn text-info"
                                        onclick="showImage('${product.hinhAnh}')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </td>
                            <td class="p-1">
                                <a class="btn text-warning" href="/admin/product/${product.id}">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <button class="btn text-danger" onclick="showConfirm('Xác nhận xóa ?','/admin/product/delete/${product.id}')"><i
                                        class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
        <ul class="pagination justify-content-end">
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link"
                   href="?page=1&size=${param.size}&name=${param.name}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&category=${param.category}&brand=${param.brand}&vanhXe=${param.vanhXe}"
                   aria-label="First">
                    <span aria-hidden="true"><i class="fa-solid fa-angles-left"></i></span>
                </a>
            </li>
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link"
                   href="?page=${currentPage - 1}&size=${param.size}&name=${param.name}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&category=${param.category}&brand=${param.brand}&vanhXe=${param.vanhXe}"
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
                                   href="?page=${status.index+1}&size=${param.size}&name=${param.name}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&category=${param.category}&brand=${param.brand}&vanhXe=${param.vanhXe}">${status.index + 1}</a>
                            </li>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </c:if>
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link"
                   href="?page=${currentPage + 1}&size=${param.size}&name=${param.name}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&category=${param.category}&brand=${param.brand}&vanhXe=${param.vanhXe}"
                   aria-label="Next">
                    <span aria-hidden="true"><i class="fa-solid fa-caret-right"></i></span>
                </a>
            </li>
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link"
                   href="?page=${totalPages - 1}&size=${param.size}&name=${param.name}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&category=${param.category}&brand=${param.brand}&vanhXe=${param.vanhXe}"
                   aria-label="Last">
                    <span aria-hidden="true"><i class="fa-solid fa-angles-right"></i></span>
                </a>
            </li>
        </ul>
    </main>

    <jsp:include page="../layout/footer.jsp"/>
</div>
</body>

<!-- Modal -->
<div class="modal fade" id="addProduct" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content rounded-0">
            <div class="modal-header">
                <h5 class="modal-title fs-5" id="exampleModalLabel">Thêm sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" action="/admin/product" enctype="multipart/form-data" id="formAddProduct"
                      onsubmit="checkFormSubmit(event)">
                    <div class="row">
                        <div class="col-xl-8">
                            <div class="row">
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Mã</label>
                                    <input name="ma" class="form-control rounded-0" id="ma"/>
                                    <small class="form-text text-danger error"></small>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Tên</label>
                                    <input name="ten" class="form-control rounded-0" id="ten"/>
                                    <small class="form-text text-danger error"></small>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Vành</label>
                                    <select class="form-select form-select rounded-0" name="vanhXe">
                                        <option value="24" selected>24 inch</option>
                                        <option value="25">25 inch</option>
                                        <option value="26">26 inch</option>
                                        <option value="27">27 inch</option>
                                    </select>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Phanh</label>
                                    <select class="form-select form-select rounded-0" name="phanhXe">
                                        <option value="Phanh đĩa" selected>Phanh đĩa</option>
                                        <option value="Phanh dầu">Phanh dầu</option>
                                        <option value="Phanh dây">Phanh dây</option>
                                    </select>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Bàn đạp</label>
                                    <select class="form-select form-select rounded-0" name="banDap">
                                        <option value="Wellgo" selected>Wellgo</option>
                                        <option value="Pacific">Pacific</option>
                                        <option value="Promend">Promend</option>
                                    </select>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Số lượng</label>
                                    <input type="number" min="1" name="soLuong" id="soLuong"
                                           class="form-control rounded-0"/>
                                    <small class="form-text text-danger error"></small>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Đơn giá</label>
                                    <input name="donGia" class="form-control rounded-0" id="donGia"/>
                                    <small class="form-text text-danger error"></small>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Hình ảnh</label>
                                    <input type="file" name="hinhAnh" class="form-control rounded-0" id="imgInp"
                                           accept="image/*"/>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Danh mục</label>
                                    <select class="form-select form-select rounded-0" name="id_cate">
                                        <c:forEach items="${listCategory}" var="category">
                                            <option value="${category.id}">${category.ten}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Hãng</label>
                                    <select class="form-select form-select rounded-0" name="id_brand">
                                        <c:forEach items="${listBrand}" var="brand">
                                            <option value="${brand.id}">${brand.ten}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-xl-4 mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <textarea class="form-control rounded-0" name="moTa" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4">
                            <div class="__product-item-img">
                                <img class="card-img-top" id="blah" src="#"
                                     onerror="this.onerror=null; this.src='/resources/images/products/default.jpg'"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-0" data-bs-dismiss="modal">Đóng</button>
                <button class="btn btn-dark rounded-0" type="submit" form="formAddProduct">Thêm sản phẩm</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content rounded-0">
            <div class="modal-body">
                <img src="" alt="" id="imageDetail" width="100%">
            </div>
        </div>
    </div>
</div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</html>