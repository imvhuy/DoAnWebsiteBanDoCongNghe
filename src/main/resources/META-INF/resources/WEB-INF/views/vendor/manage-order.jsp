<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="container mt-4" style="padding-bottom: 200px;">
    <h3>Quản Lý Đơn Hàng</h3>
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
                <a href="${pageContext.request.contextPath}/vendor/manage-
revenue"
                   class="list-group-item list-group-item-action">Doanh
                    Thu</a>
            </div>
        </div>
    </div>
    <div class="col-md-9">
    <!-- Form tìm kiếm đơn hàng -->
    <form action="${pageContext.request.contextPath}/vendor/manage-orders" method="get" class="mb-4">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="Tìm kiếm đơn hàng" name="orderId" value="${orderId}">
            <select class="form-select" name="status">
                <option value="">Tất Cả Trạng Thái</option>
                <option value="NEW" ${status == 'NEW' ? 'selected' : ''}>Đơn Hàng Mới</option>
                <option value="CONFIRMED" ${status == 'CONFIRMED' ? 'selected' : ''}>Đã Xác Nhận</option>
                <option value="SHIPPING" ${status == 'SHIPPING' ? 'selected' : ''}>Đang Giao</option>
                <option value="DELIVERED" ${status == 'DELIVERED' ? 'selected' : ''}>Đã Giao</option>
                <option value="CANCELED" ${status == 'CANCELED' ? 'selected' : ''}>Hủy</option>
                <option value="RETURNED" ${status == 'RETURNED' ? 'selected' : ''}>Trả Hàng/Hoàn Tiền</option>
            </select>
            <button class="btn btn-primary" type="submit">Tìm Kiếm</button>
        </div>
    </form>


    <!-- Table quản lý đơn hàng -->
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID Đơn Hàng</th>
            <th>Tên Khách Hàng</th>
            <th>Ngày Đặt</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.id}</td>
                <td>${order.customerName}</td>
                <td>${fn:formatDate(order.orderDate, "yyyy-MM-dd")}</td>
                <td>
                        <span class="badge
                            ${order.status == 'NEW' ? 'bg-warning' : ''}
                            ${order.status == 'CONFIRMED' ? 'bg-primary' : ''}
                            ${order.status == 'SHIPPING' ? 'bg-info' : ''}
                            ${order.status == 'DELIVERED' ? 'bg-success' : ''}
                            ${order.status == 'CANCELED' ? 'bg-danger' : ''}
                            ${order.status == 'RETURNED' ? 'bg-secondary' : ''}">
                                ${order.status == 'NEW' ? 'Mới' :
                                        order.status == 'CONFIRMED' ? 'Đã Xác Nhận' :
                                                order.status == 'SHIPPING' ? 'Đang Giao' :
                                                        order.status == 'DELIVERED' ? 'Đã Giao' :
                                                                order.status == 'CANCELED' ? 'Hủy' :
                                                                        'Trả Hàng/Hoàn Tiền'}
                        </span>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/vendor/update-order-status" method="post">
                        <input type="hidden" name="orderId" value="${order.id}">
                        <select class="form-select" name="newStatus" onchange="this.form.submit()">
                            <option value="NEW" ${order.status == 'NEW' ? 'selected' : ''}>Mới</option>
                            <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>Đã Xác Nhận</option>
                            <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>Đang Giao</option>
                            <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã Giao</option>
                            <option value="CANCELED" ${order.status == 'CANCELED' ? 'selected' : ''}>Hủy</option>
                            <option value="RETURNED" ${order.status == 'RETURNED' ? 'selected' : ''}>Trả Hàng/Hoàn Tiền</option>
                        </select>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-orders?page=${currentPage - 1}&status=${status}">Previous</a>
                </li>
            </c:if>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-orders?page=${i}&status=${status}">${i}</a>
                </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-orders?page=${currentPage + 1}&status=${status}">Next</a>
                </li>
            </c:if>
        </ul>
    </nav>
    </div>
</div>

<!-- Thêm Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
