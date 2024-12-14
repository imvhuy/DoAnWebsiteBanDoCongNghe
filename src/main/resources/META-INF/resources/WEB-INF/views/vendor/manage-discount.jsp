<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="container mt-4" style="padding-bottom: 200px;">
    <h3>Quản Lý Chương Trình Khuyến Mãi</h3>
    <div class="row">
        <div class="col-md-3">
            <!-- Sidebar -->
            <div class="list-group" id="sidebarMenu">
                <a href="${pageContext.request.contextPath}/vendor/manage-store" class="list-group-item list-group-item-action">Trang Chủ Cửa Hàng</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-product" class="list-group-item list-group-item-action">Quản Lý Sản Phẩm</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-order" class="list-group-item list-group-item-action">Quản Lý Đơn Hàng</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-discount" class="list-group-item list-group-item-action">Chương Trình Khuyến Mãi</a>
                <a href="${pageContext.request.contextPath}/vendor/manage-revenue" class="list-group-item list-group-item-action">Doanh Thu</a>
            </div>
        </div>
        <div class="col-md-9">
            <!-- Form tạo/chỉnh sửa chương trình khuyến mãi -->
            <form action="${pageContext.request.contextPath}/vendor/save-discount" method="post" class="mb-4">
                <div class="form-group">
                    <label for="discountName">Tên Chương Trình</label>
                    <input type="text" id="discountName" name="discountName" class="form-control" placeholder="Nhập tên chương trình" value="${discount.name}">
                </div>
                <div class="form-group">
                    <label for="discountType">Loại Khuyến Mãi</label>
                    <select class="form-control" id="discountType" name="discountType">
                        <option value="PERCENTAGE" ${discount.type == 'PERCENTAGE' ? 'selected' : ''}>Giảm phần trăm</option>
                        <option value="AMOUNT" ${discount.type == 'AMOUNT' ? 'selected' : ''}>Giảm tiền</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="discountValue">Giá trị</label>
                    <input type="number" id="discountValue" name="discountValue" class="form-control" placeholder="Nhập giá trị" value="${discount.value}">
                </div>
                <div class="form-group">
                    <label for="startDate">Ngày Bắt Đầu</label>
<%--                    <input type="date" id="startDate" name="startDate" class="form-control" value="${fn:formatDate(discount.startDate, 'yyyy-MM-dd')}">--%>
                </div>
                <div class="form-group">
                    <label for="endDate">Ngày Kết Thúc</label>
<%--                    <input type="date" id="endDate" name="endDate" class="form-control" value="${fn:formatDate(discount.endDate, 'yyyy-MM-dd')}">--%>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Lưu Chương Trình</button>
                </div>
            </form>

            <!-- Danh sách chương trình khuyến mãi -->
            <h4>Danh Sách Chương Trình Khuyến Mãi</h4>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Chương Trình</th>
                    <th>Loại Khuyến Mãi</th>
                    <th>Giảm Giá</th>
                    <th>Thời Gian</th>
                    <th>Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="promo" items="${discounts}">
                    <tr>
                        <td>${promo.id}</td>
                        <td>${promo.name}</td>
                        <td>${promo.type == 'PERCENTAGE' ? 'Giảm phần trăm' : 'Giảm tiền'}</td>
                        <td>${promo.value}${promo.type == 'PERCENTAGE' ? '%' : ' VND'}</td>
<%--                        <td>${fn:formatDate(promo.startDate, 'yyyy-MM-dd')} - ${fn:formatDate(promo.endDate, 'yyyy-MM-dd')}</td>--%>
                        <td>
                            <a href="${pageContext.request.contextPath}/vendor/edit-discount?id=${promo.id}" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="${pageContext.request.contextPath}/vendor/delete-discount?id=${promo.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa chương trình này?')">Xóa</a>
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
                            <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-discount?page=${currentPage - 1}">Previous</a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-discount?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/vendor/manage-discount?page=${currentPage + 1}">Next</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
