<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container mt-4">
    <c:choose>

        <c:when test="${fn:contains(pageContext.request.userPrincipal.authorities.toString(), 'ROLE_VENDOR')}">
            <h2>Manage Store</h2>
            <div class="row">
                <div class="col-md-3">
                    <!-- Sidebar -->
                    <div class="list-group" id="sidebarMenu">
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('home')">Trang Chủ Cửa Hàng</a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('products')">Quản Lý Sản Phẩm</a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('orders')">Quản Lý Đơn Hàng</a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('promotions')">Chương Trình Khuyến Mãi</a>
                        <a href="#" class="list-group-item list-group-item-action" onclick="showSection('revenue')">Doanh Thu</a>
                    </div>
                </div>

                <div class="col-md-9">
                    <div id="home" class="content-section">
                        <h2>Thông Tin Cửa Hàng</h2>
                        <p><strong>Tên Cửa Hàng:</strong> ${store.name}</p>
                        <p><strong>Địa Chỉ:</strong> ${store.address}</p>
                        <p><strong>Bio:</strong> ${store.bio}</p>
                        <p><strong>Trạng Thái:</strong> Đang hoạt động </p>
                        <img src="/admin/images/products/${store.avatar}" alt="Avatar cửa hàng" class="img-thumbnail" style="max-width: 200px;">
                        <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#editStoreModal">Chỉnh Sửa</button>
                    </div>

                    <div id="products" class="content-section d-none">
                        <h3>Quản Lý Sản Phẩm</h3>
                        <button class="btn btn-success">Thêm Sản Phẩm</button>
                        <table class="table mt-3">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>001</td>
                                <td>Điện Thoại XYZ</td>
                                <td>10,000,000 VNĐ</td>
                                <td>Còn Hàng</td>
                                <td>
                                    <button class="btn btn-warning">Chỉnh Sửa</button>
                                    <button class="btn btn-danger">Xóa</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="orders" class="content-section d-none">
                        <h3>Quản Lý Đơn Hàng</h3>
                        <p>Hiển thị thông tin đơn hàng...</p>
                    </div>

                    <div id="promotions" class="content-section d-none">
                        <h3>Chương Trình Khuyến Mãi</h3>
                        <button class="btn btn-primary">Tạo Chương Trình Khuyến Mãi</button>
                    </div>

                    <div id="revenue" class="content-section d-none">
                        <h3>Doanh Thu</h3>
                        <p><strong>Doanh Thu Tháng Này:</strong> 20,000,000 VNĐ</p>
                        <p><strong>Tổng Doanh Thu:</strong> 200,000,000 VNĐ</p>
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


<div class="modal fade" id="editStoreModal" tabindex="-1" aria-labelledby="editStoreModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/vendor/saveOrUpdate" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${store.id}">
            <input type="hidden" name="isActive" value="${store.isActive}">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editStoreModalLabel">Chỉnh Sửa Thông Tin Cửa Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="storeNameEdit" class="form-label">Tên Cửa Hàng</label>
                        <input type="text" class="form-control" id="storeNameEdit" name="name" value="${store.name}" required>
                    </div>
                    <div class="mb-3">
                        <label for="addressEdit" class="form-label">Địa Chỉ</label>
                        <input type="text" class="form-control" id="addressEdit" name="address" value="${store.address}" required>
                    </div>
                    <div class="mb-3">
                        <label for="bioEdit" class="form-label">Bio</label>
                        <textarea class="form-control" id="bioEdit" name="bio" rows="3" required>${store.bio}</textarea>
                    </div>
                    <div class="mb-3">
                        <label for="avatarEdit" class="form-label">Avatar</label>
                        <input type="file" class="form-control" id="avatarEdit" name="avatarStore" accept="image/*">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function showSection(sectionId) {
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.add('d-none');
        });
        document.getElementById(sectionId).classList.remove('d-none');
    }
</script>
