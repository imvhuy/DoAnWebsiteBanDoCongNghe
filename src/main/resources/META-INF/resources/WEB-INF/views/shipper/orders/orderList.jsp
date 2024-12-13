<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<body>

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }

    h2 {
        color: #007bff;
        font-weight: bold;
        text-align: center;
        font-size: 40px;
        margin-bottom: 20px;
    }

    .form-row {
        margin-top: 20px;
        justify-content: center;
    }

    label {
        font-size: 18px;
        color: #555;
        font-weight: 500;
    }

    .form-control {
        border-radius: 30px;
        padding: 8px 15px;
        font-size: 16px;
        border: 1px solid #ced4da;
        box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.1);
    }

    .btn-primary {
        border-radius: 30px;
        font-size: 16px;
        padding: 10px 25px;
        background-color: #007bff;
        border: none;
        transition: all 0.3s ease;
    }

    .btn-primary:hover {
        background-color: #0056b3;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    }

    /* Style cho bảng */
    .table {
        width: 100%;
        margin-top: 30px;
        border-collapse: collapse;
    }

    .table th, .table td {
        padding: 20px;
        text-align: center;
        vertical-align: middle;
        border: 1px solid #ddd;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    .table th {
        background-color: #007bff;
        color: white;
        font-weight: bold;
        text-transform: uppercase;
    }

    /* Style cho hàng lẻ */
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #f9f9f9;
    }

    /* Hiệu ứng hover cho bảng */
    .table-hover tbody tr:hover {
        background-color: #e3f2fd;
    }

    /* Nút hành động */
    .btn {
        border-radius: 50px;
        padding: 8px 16px;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .btn-warning {
        background-color: #ffc107;
        color: white;
        border: none;
    }

    .btn-success {
        background-color: #28a745;
        color: white;
        border: none;
    }

    .btn-warning:hover {
        background-color: #e0a800;
    }

    .btn-success:hover {
        background-color: #218838;
    }

    /* Phân trang */
    .pagination {
        margin-top: 30px;
        justify-content: center;
    }

    .pagination .page-link {
        border-radius: 50%;
        background-color: #007bff;
        color: white;
        font-size: 16px;
        padding: 8px 12px;
        border: none;
        transition: background-color 0.3s ease;
    }

    .pagination .page-link:hover {
        background-color: #0056b3;
    }

    .pagination .page-item.active .page-link {
        background-color: #0056b3;
        color: white;
    }

    .pagination .page-item.disabled .page-link {
        background-color: #e9ecef;
        color: #6c757d;
    }
</style>
<!-- Tiêu đề -->
<h2 class="text-center mb-4">Order List</h2>

<!-- Form Lọc Trạng Thái -->
<form action="${pageContext.request.contextPath}/shipper/orders" method="get" class="mb-4">
    <div class="form-row justify-content-center align-items-center">
        <div class="col-auto">
            <label for="status" class="font-weight-bold">Filter by status:</label>
        </div>
        <div class="col-auto">
            <select class="form-control shadow-sm" id="status" name="status">
                <option value="">Select status</option>
                <option value="ChoVanChuyen" ${status == 'ChoVanChuyen' ? 'selected' : ''}>Chờ vận Chuyển</option>
                <option value="DangVanChuyen" ${status == 'DangVanChuyen' ? 'selected' : ''}>Đang vận Chuyển</option>
            </select>
        </div>
        <div class="col-auto">
            <label for="search" class="font-weight-bold">Search:</label>
        </div>
        <div class="col-auto">
            <input type="text" class="form-control shadow-sm" id="search" name="search" placeholder="Enter keyword"
                   value="${search}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary btn-lg shadow-sm">Filter</button>
        </div>
    </div>
</form>


<!-- Bảng danh sách đơn hàng -->
<table class="table table-striped table-bordered table-hover">
    <thead class="thead-dark">
    <tr>
        <th>ID</th>
        <th>User Name</th>
        <th>Address</th>
        <th>Status</th>
        <th>Delivery Name</th>
        <th>Amount from User</th>
        <th>Amount to GD</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <!-- Hiển thị danh sách đơn hàng -->
    <c:forEach var="order" items="${orders}">
        <tr>
            <td>${order.id}</td>
            <td>${order.user.fullName}</td>
            <td>${order.address}</td>
            <td>${order.status}</td>
            <td>${order.delivery.deliveryName}</td>
            <td><fmt:formatNumber value="${order.amountFromUser}" type="number" maxFractionDigits="0" /> VND</td>
            <td><fmt:formatNumber value="${order.amountToGD}" type="number" maxFractionDigits="0" /> VND</td>


            <td>
                <!-- Hiển thị nút hành động dựa trên trạng thái -->
                <c:choose>
                    <c:when test="${order.status eq 'chờ vận chuyển'}">
                        <form action="${pageContext.request.contextPath}/shipper/orders/updateStatus" method="post">
                            <input type="hidden" name="orderId" value="${order.id}" />
                            <input type="hidden" name="newStatus" value="đang vận chuyển" />
                            <button type="submit" class="btn btn-warning">Vận Chuyển</button>
                        </form>
                    </c:when>
                    <c:when test="${order.status eq 'đang vận chuyển'}">
                        <form action="${pageContext.request.contextPath}/shipper/orders/updateStatus" method="post">
                            <input type="hidden" name="orderId" value="${order.id}" />
                            <input type="hidden" name="newStatus" value="đã vận chuyển" />
                            <button type="submit" class="btn btn-success">Đã Giao</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted">Done</span>
                    </c:otherwise>
                </c:choose>

            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Phân trang -->
<c:if test="${totalPages > 0}">
    <nav>
        <ul class="pagination justify-content-end">
            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}&status=${status}">${i + 1}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</c:if>

<!-- Kết nối Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
