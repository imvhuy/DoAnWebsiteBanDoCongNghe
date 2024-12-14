<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container mt-4">
    <c:choose>
        <c:when test="${fn:contains(pageContext.request.userPrincipal.authorities.toString(), 'ROLE_VENDOR')}">
            <h5>Manage Store</h5>
            <div class="row">
                <div class="col-md-3">
                    <!-- Sidebar -->
                    <div class="list-group" id="sidebarMenu">
                        <a href="${pageContext.request.contextPath}/vendor/manage-store"
                           class="list-group-item list-group-item-action">Trang Chủ Cửa
                            Hàng</a>
                        <a href="${pageContext.request.contextPath}/vendor/manage-product"
                           class="list-group-item list-group-item-action">Quản Lý Sản
                            Phẩm</a>
                        <a href="${pageContext.request.contextPath}/vendor/manage-order"
                           class="list-group-item list-group-item-action">Quản Lý Đơn
                            Hàng</a>
                        <a href="${pageContext.request.contextPath}/vendor/manage-discount"
                           class="list-group-item list-group-item-action">Chương
                            Trình Khuyến Mãi</a>
                        <a href="${pageContext.request.contextPath}/vendor/manage-revenue"
                           class="list-group-item list-group-item-action">Doanh
                            Thu</a>
                    </div>
                </div>

                <div class="col-md-9">
                    <div id="home" class="content-section">
                        <h5>Thông Tin Cửa Hàng</h5>
                        <p><strong>Tên Cửa Hàng:</strong> ${store.name}</p>
                        <p><strong>Địa Chỉ:</strong> ${store.address}</p>
                        <p><strong>Bio:</strong> ${store.bio}</p>
                        <p><strong>Trạng Thái:</strong> Đang hoạt động </p>
                        <img src="/admin/images/products/${store.avatar}" alt="Avatar cửa hàng" class="img-thumbnail" style="max-width: 200px;">
                        <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#editStoreModal">Chỉnh Sửa</button>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${store != null} ">
                    <h2>Thông Tin Cửa Hàng Đã Đăng Ký</h2>
                    <p>Tên Cửa Hàng: ${store.name}</p>
                    <p>Địa Chỉ: ${store.address}</p>
                    <p>Bio: ${store.bio}</p>
                    <p>Avatar:</p>
                    <img src="/admin/images/products/${store.avatar}" alt="Avatar của cửa hàng" class="img-thumbnail" style="max-width: 200px;">
                    <p><strong>Trạng Thái:</strong> Đang Chờ Duyệt</p>
                </c:when>
                <c:otherwise>
                    <h2>Register Store</h2>
                    <p>Vui lòng điền thông tin để đăng ký cửa hàng của bạn.</p>
                    <form action="${pageContext.request.contextPath}/vendor/saveOrUpdate" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="storeName" class="form-label">Tên Cửa Hàng</label>
                            <input type="text" class="form-control" id="storeName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa Chỉ</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        <div class="mb-3">
                            <label for="bio" class="form-label">Bio</label>
                            <textarea class="form-control" id="bio" name="bio" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="avatar" class="form-label">Avatar</label>
                            <input type="file" class="form-control" id="avatar" name="avatarStore" accept="image/*" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Đăng Ký</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</div>
