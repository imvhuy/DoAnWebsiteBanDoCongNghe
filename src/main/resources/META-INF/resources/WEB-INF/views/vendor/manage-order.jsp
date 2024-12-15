<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<body>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 30px;
    }
    .sidebar {
        background-color: #343a40;
        padding: 20px;
        border-radius: 8px;
    }
    .sidebar a {
        color: #fff;
        text-decoration: none;
        font-weight: 600;
    }
    .sidebar a:hover, .sidebar .active {
        background-color: #007bff;
        color: white;
    }
    h3 {
        font-size: 2rem;
        font-weight: bold;
        color: #343a40;
        margin-bottom: 20px;
    }
    .input-group .form-control {
        border-radius: 5px;
    }
    .btn.btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        color: white;
        font-weight: 600;
        border-radius: 5px;
    }
    .btn.btn-primary:hover {
        background-color: #0056b3;
    }
    .table thead {
        background-color: #007bff;
        color: white;
    }
    .pagination {
        justify-content: center;
    }
    .pagination .page-item.active .page-link {
        background-color: #007bff;
        border-color: #007bff;
    }
    .pagination .page-link {
        color: #007bff;
    }
</style>
<div class="container mt-4" style="padding-bottom: 200px;">
    <h3 class="text-center">Quản Lý Đơn Hàng</h3>

    <!-- Sidebar -->
    <div class="row">
        <div class="col-md-3">
            <div class="list-group" id="sidebarMenu">
                <a href="${pageContext.request.contextPath}/vendor/manage-store" class="list-group-item list-group-item-action">Trang Chủ Cửa Hàng</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-product" class="list-group-item list-group-item-action">Quản Lý Sản Phẩm</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-order" class="list-group-item list-group-item-action active">Quản Lý Đơn Hàng</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-discount" class="list-group-item list-group-item-action">Chương Trình Khuyến Mãi</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-revenue" class="list-group-item list-group-item-action">Doanh Thu</a>
            </div>
        </div>

        <!-- Main content area -->
        <div class="col-md-9">
            <!-- Form tìm kiếm đơn hàng -->
            <form action="${pageContext.request.contextPath}/vendor/manage-order" method="get" class="mb-4">
                <div class="input-group">
                    <!-- Tìm kiếm theo ID -->
                    <input type="text" class="form-control" name="id" placeholder="Tìm theo ID" value="${param.id}">

                    <!-- Tìm kiếm theo tên -->
                    <input type="text" class="form-control" name="search" placeholder="Tìm theo tên khách hàng" value="${param.search}">

                    <!-- Lọc theo trạng thái -->
                    <select name="status" class="form-control">
                        <option value="">Chọn trạng thái</option>
                        <option value="DangVanChuyen" ${param.status == 'DangVanChuyen' ? 'selected' : ''}>Đang vận chuyển</option>
                        <option value="DaVanChuyen" ${param.status == 'DaVanChuyen' ? 'selected' : ''}>Đã vận chuyển</option>
                        <option value="ChoVanChuyen" ${param.status == 'ChoVanChuyen' ? 'selected' : ''}>Chờ vận chuyển</option>
                    </select>

                    <!-- Nút tìm kiếm -->
                    <button type="submit"  class=" tf-btn btn-sm radius-3 btn-fill btn-icon btn-icon animate-hover-btn
                         live-chat-btn">Tìm kiếm</button>
                </div>
            </form>

            <!-- Hiển thị danh sách đơn hàng -->
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>ID Đơn Hàng</th>
                        <th>Tên Khách Hàng</th>
                        <th>Ngày Đặt</th>
                        <th>Tổng Tiền</th>
                        <th>Trạng Thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.user.fullName}</td>
                            <td><fmt:formatDate value="${order.createdDate}" pattern="MMMM d, yyyy hh:mm:ss a" /></td>
                            <td><fmt:formatNumber value="${order.amountFromUser}" type="number" maxFractionDigits="0" /> VND</td>
                            <td>${order.status}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:forEach begin="0" end="${totalPages - 1}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-order?page=${i}&id=${param.id}&status=${param.status}&search=${param.search}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>
</body>
