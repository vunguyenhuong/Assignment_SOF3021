<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="/resources/vendor/angular/angular.min.js"></script>
    <script src="/resources/vendor/angular/angular-route.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
</head>
<body>
<div class="container-fluid" ng-app="myApp" ng-controller="myCtrl">
    <jsp:include page="layout/header.jsp"/>

    <main>
        <form action="/checkout" method="post" id="formThanhToan">
            <div class="row">
                <div class="d-flex align-items-center justify-content-between bg-light p-5">
                    <h2 class="text-uppercase display-6 fw-semibold">Thanh toán</h2>
                    <nav class="breadcrumb">
                        <a class="breadcrumb-item text-decoration-none text-black fw-bold" href="/home">Trang chủ</a>
                        <a class="breadcrumb-item text-decoration-none text-muted fw-bold" href="/cart">Giỏ hàng</a>
                        <a class="breadcrumb-item text-decoration-none text-muted fw-bold" href="/checkout">Thanh
                            toán</a>
                    </nav>
                </div>
                <div class="d-flex align-items-center justify-content-between">
                    <h4 class="pt-4 pb-2 fw-semibold text-uppercase">Chi tiết thanh toán</h4>
                </div>
                <div class="col-xl-7">
                    <div class="row">
                        <div class="mb-3 col-xl-6">
                            <label for="" class="form-label text-uppercase small fw-semibold">Tên</label>
                            <input name="tenNguoiNhan" type="text" class="form-control rounded-0"
                                   placeholder="Nhập tên của bạn" required>
                        </div>
                        <div class="mb-3 col-xl-6">
                            <label for="" class="form-label text-uppercase small fw-semibold">Email</label>
                            <input name="email" type="text" class="form-control rounded-0"
                                   placeholder="Ex: example@example.com">
                        </div>
                        <div class="mb-3 col-xl-6">
                            <label for="" class="form-label text-uppercase small fw-semibold">Số điện thoại</label>
                            <input name="sdt" type="text" class="form-control rounded-0" required placeholder="Ex: 0395080513">
                        </div>
                        <div class="mb-3 col-xl-6">
                            <label class="form-label">Tỉnh/Thành phố</label>
                            <select class="form-select form-select rounded-0" name="tinh" ng-change="getHuyen()"
                                    ng-model="tinh" required>
                                <option ng-repeat="t in listTinh" value="{{t.ProvinceID}}">{{t.ProvinceName}}</option>
                            </select>
                        </div>
                        <div class="mb-3 col-xl-6">
                            <label class="form-label">Quận/Huyện</label>
                            <select class="form-select form-select rounded-0" name="huyen" ng-change="getXa()"
                                    ng-model="huyen" required>
                                <option ng-repeat="h in listHuyen" value="{{h.DistrictID}}">{{h.DistrictName}}</option>
                            </select>
                        </div>

                        <div class="mb-3 col-xl-6">
                            <label class="form-label">Xã/Phường/Thị trấn</label>
                            <select class="form-select form-select rounded-0" name="xa" ng-model="wardCode"
                                    ng-change="tinhPhi()" required>
                                <option ng-repeat="x in listXa" value="{{x.WardCode}}">{{x.WardName}}</option>
                            </select>
                        </div>
                        <div class="mb-3 col-xl-12">
                            <label for="" class="form-label">Ghi chú</label>
                            <textarea class="form-control rounded-0" name="ghiChu" id="" rows="3"></textarea>
                        </div>
                    </div>
                    <button type="button" class="btn btn-dark rounded-0"
                            onclick="showConfirmSubmit('Xác nhận đặt hàng ?','formThanhToan')">Thanh toán
                    </button>
                </div>
                <div class="col-xl-5 border mt-3 mt-xl-0">
                    <h5 class="py-4 fw-bold text-uppercase">Đơn hàng của bạn</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Tên</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty sessionScope.user}">
                                <c:forEach items="${listCart}" var="item">
                                    <tr class="">
                                        <td>${item.ten}</td>
                                        <td>${item.soLuong}</td>
                                        <td><fmt:formatNumber value="${item.tongTien()}" type="currency"
                                                              currencySymbol=""/></td>
                                    </tr>
                                </c:forEach>
                                <tr class="">
                                    <td colspan="2"><strong>Phí ship</strong></td>
                                    <input type="text" value="{{shipMoney}}" name="phiShip" hidden>
                                    <td>{{shipMoney == null ? 0 : shipMoney | number}} <strong>VNĐ</strong></td>
                                </tr>
                                <tr class="">
                                    <td colspan="2" class="align-middle">Đơn vị vận chuyển</td>
                                    <td>
                                        <img src="/resources/images/logo-ghn.png" width="100px">
                                    </td>
                                </tr>
                                <tr class="">
                                    <td colspan="2"><strong>Tổng</strong></td>
                                    <td>{{tongTien + shipMoney | number}} <strong>VNĐ</strong></td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty sessionScope.user}">
                                <c:forEach items="${listCart}" var="item">
                                    <tr class="">
                                        <td>${item.product.ten}</td>
                                        <td>${item.soLuong}</td>
                                        <td><fmt:formatNumber value="${item.donGia*item.soLuong}" type="currency"
                                                              currencySymbol=""/></td>
                                    </tr>
                                </c:forEach>
                                <tr class="">
                                    <td colspan="2"><strong>Phí ship</strong></td>
                                    <input type="text" value="{{shipMoney}}" name="phiShip" hidden>
                                    <td>{{shipMoney == null ? 0 : shipMoney | number}} <strong>VNĐ</strong></td>
                                </tr>
                                <tr class="">
                                    <td colspan="2" class="align-middle">Đơn vị vận chuyển</td>
                                    <td>
                                        <img src="/resources/images/logo-ghn.png" width="100px">
                                    </td>
                                </tr>
                                <tr class="">
                                    <td colspan="2"><strong>Tổng</strong></td>
                                    <td>{{tongTien + shipMoney | number}} <strong>VNĐ</strong></td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </main>

    <jsp:include page="layout/footer.jsp"/>
</div>
</body>
<script>
    const app = angular.module('myApp', []);
    app.controller('myCtrl', function ($scope, $http) {
        $scope.tongTien = ${tongTien};
        $http({
            method: 'GET',
            url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province',
            headers: {
                "Token": "aef361b5-f26a-11ed-bc91-ba0234fcde32",
                "Content-Type": "application/json",
                "ShopId": 124173
            }
        }).then(function (response) {
            $scope.listTinh = response.data.data;
        })

        $scope.getHuyen = function () {
            const data = {
                "province_id": parseInt($scope.tinh)
            };
            $http({
                method: 'POST',
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district',
                data: data,
                headers: {
                    "Token": "aef361b5-f26a-11ed-bc91-ba0234fcde32",
                    "Content-Type": "application/json",
                    "ShopId": 124173
                }
            }).then(function (response) {
                $scope.listHuyen = response.data.data;
                console.log(response.data.data)
            })
        }

        $scope.getXa = function () {
            const data = {
                "district_id": parseInt($scope.huyen)
            };
            $http({
                method: 'POST',
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id',
                data: data,
                headers: {
                    "Token": "aef361b5-f26a-11ed-bc91-ba0234fcde32",
                    "Content-Type": "application/json"
                }
            }).then(function (response) {
                $scope.listXa = response.data.data;
                console.log(response.data.data)
            })
        }

        $scope.tinhPhi = function () {
            console.log($scope.wardCode)
            const data = {
                "service_id": 53320,
                "service_type_id": null,
                "to_district_id": parseInt($scope.huyen),
                "to_ward_code": $scope.wardCode,
                "height": 50,
                "length": 20,
                "weight": 200,
                "width": 20,
                "cod_failed_amount": 2000,
                "insurance_value": 10000,
                "coupon": null
            };
            console.log(data)
            $http({
                method: 'POST',
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
                data: data,
                headers: {
                    'Token': 'aef361b5-f26a-11ed-bc91-ba0234fcde32',
                    'Content-Type': 'application/json',
                    'ShopId': 124173
                }
            }).then(function (response) {
                $scope.shipMoney = response.data.data.total;
                console.log(response.data.data)
            }).catch(function (error) {
                console.log(error);
            })
        }
    })
</script>
<script src="/resources/js/product.js"></script>
<script src="/resources/vendor/boostrap/boostrap.min.js"></script>
<script src="/resources/vendor/boostrap/popper.min.js"></script>
</html>