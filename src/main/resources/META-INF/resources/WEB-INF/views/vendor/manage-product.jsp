<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container mt-4" style="padding-bottom: 200px;">
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
            <div id="products" class="content-section">
                <h3>Quản Lý Sản Phẩm</h3>
                <form action="${pageContext.request.contextPath}/vendor/manage-product" method="get">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm" name="productName"
                               value="${productName}">
                        <select class="form-select" id="categorySelect" name="categoryId">
                            <option value="">Tất Cả Danh Mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${category.id == categoryId ? 'selected' : ''}>${category.name}</option>
                            </c:forEach>
                        </select>
                        <button class="btn btn-outline-secondary" type="submit">Tìm Kiếm</button>
                    </div>
                </form>

                <!-- Button to Open Modal -->
                <button class="btn btn-success mb-3" onclick="showProductModal()">Thêm Sản Phẩm</button>

                <table class="table mt-3">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Đã bán</th>
                        <th>Trạng Thái</th>
                        <th>Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="product" items="${stores}">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.product.name}</td>
                            <td>${product.product.price}</td>
                            <td>${product.quantity}</td>
                            <td>${product.sold}</td>
                            <td>${product.quantity - product.sold > 0 ? 'Còn Hàng' : 'Hết Hàng'}</td>
                            <td>
                                <button class="btn btn-warning" onclick="showEditProductModal(${product.id}, '${product.product.name}', ${product.product.price}, ${product.quantity})">Chỉnh Sửa</button>
                                <button class="btn btn-danger" onclick="confirmDelete(${product.id})">Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/vendor/manage-product?page=${currentPage - 1}&productName=${productName}">Previous</a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/vendor/manage-product?page=${i}&productName=${productName}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/vendor/manage-product?page=${currentPage + 1}&productName=${productName}">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
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
                    <img src="/admin/images/products/${store.avatar}" alt="Avatar của cửa hàng" class="img-thumbnail"
                         style="max-width: 200px;">
                    <p><strong>Trạng Thái:</strong> Đang Chờ Duyệt</p>
                </c:when>
                <c:otherwise>
                    <h2>Register Store</h2>
                    <p>Vui lòng điền thông tin để đăng ký cửa hàng của bạn.</p>
                    <form action="${pageContext.request.contextPath}/vendor/saveOrUpdate" method="post"
                          enctype="multipart/form-data">
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
                            <input type="file" class="form-control" id="avatar" name="avatarStore" accept="image/*"
                                   required>
                        </div>
                        <button type="submit" class="btn btn-primary">Đăng Ký</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
        </c:choose>
    </div>

    <!-- Modal for Adding Products -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Thêm Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Product Form -->
                    <form action="${pageContext.request.contextPath}/vendor/addStoreProduct" method="POST">
                        <div class="mb-3">
                            <label for="productSelect" class="form-label">Chọn Sản Phẩm</label>
                            <select class="form-select" id="productSelect" name="productid">
                                <c:forEach var="product" items="${products}">
                                    <option value="${product.id}">${product.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="quantityInput" class="form-label">Số Lượng</label>
                            <input type="number" class="form-control" id="quantityInput" name="quantity" min="1"
                                   required>
                        </div>

                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal for Editing Products -->
    <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">Chỉnh Sửa Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Product Edit Form -->
                    <form action="${pageContext.request.contextPath}/vendor/editStoreProduct" method="POST">
                        <input type="hidden" id="editProductId" name="productid">

                        <div class="mb-3">
                            <label for="editProductName" class="form-label">Tên Sản Phẩm</label>
                            <input type="text" class="form-control" id="editProductName" name="productName" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="editProductPrice" class="form-label">Giá</label>
                            <input type="number" class="form-control" id="editProductPrice" name="price" required readonly>
                        </div>

                        <div class="mb-3">
                            <label for="editQuantity" class="form-label">Số Lượng</label>
                            <input type="number" class="form-control" id="editQuantity" name="quantity" min="1"
                                   required>
                        </div>

                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
        <!-- Modal for Delete Confirmation -->
        <div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteProductModalLabel">Xác Nhận Xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa sản phẩm này không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <form id="deleteProductForm" method="POST">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    <script>
        function showProductModal() {
            // Show the modal to add product
            $('#addProductModal').modal('show');
        }

        function showEditProductModal(productId, productName, productPrice, productQuantity, productStatus) {
            // Set the values in the form
            $('#editProductId').val(productId);
            $('#editProductName').val(productName);
            $('#editQuantity').val(productQuantity);
            $('#editProductPrice').val(productPrice);
            // Show the modal
            $('#editProductModal').modal('show');
        }
        function confirmDelete(productId) {
            // Set the action of the delete form to the URL for deleting the product
            var deleteForm = document.getElementById('deleteProductForm');
            deleteForm.action = "${pageContext.request.contextPath}/vendor/deleteProduct?id=" + productId;

            // Show the delete confirmation modal
            $('#deleteProductModal').modal('show');
        }
    </script>
</div>
