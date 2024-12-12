<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Vendor Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#storeModal" data-bs-toggle="modal">Create Store</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#orders">My Orders</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#settings">Settings</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="list-group">
                <a href="#storeManagement" class="list-group-item list-group-item-action" data-bs-toggle="collapse">Manage Stores</a>
                <a href="#productManagement" class="list-group-item list-group-item-action" data-bs-toggle="collapse">Manage Products</a>
                <a href="#orderManagement" class="list-group-item list-group-item-action" data-bs-toggle="collapse">Manage Orders</a>
                <a href="#promotionManagement" class="list-group-item list-group-item-action" data-bs-toggle="collapse">Promotions</a>
                <a href="#revenueManagement" class="list-group-item list-group-item-action" data-bs-toggle="collapse">Revenue Management</a>
            </div>
        </div>

        <!-- Main content -->
        <div class="col-md-9">
            <!-- Manage Stores -->
            <div id="storeManagement" class="collapse show">
                <h4>Manage Stores</h4>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Avatar</th>
                        <th>Store Name</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="store" items="${stores}">
                        <tr>
                            <td>
                                <c:if test="${not empty store.avatar}">
                                    <img src="/admin/images/products/${store.avatar}"
                                         class="image-preview"
                                         style="display: block; max-width: 200px;"/>
                                </c:if>
                            </td>
                            <td>${store.name}</td>
                            <td>${store.isActive ? 'Active' : 'Inactive'}</td>
                            <td>
                                <!-- Sửa nút Edit thành modal trigger -->
                                <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editStoreModal"
                                        data-store-id="${store.id}"
                                        data-store-name="${store.name}"
                                        data-store-bio="${store.bio}"
                                        data-store-avatar="${store.avatar}"
                                        data-store-isActive="${store.isActive}">
                                    Edit
                                </button>

                                <!-- Xóa cửa hàng -->
                                <form action="/vendor/stores/delete/${store.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Manage Products -->
            <div id="productManagement" class="collapse">
                <h4>Manage Products</h4>
                <a href="/vendor/products/add" class="btn btn-success mb-3">Add New Product</a>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.name}</td>
                            <td>${product.price}</td>
                            <td>${product.isActive ? 'Active' : 'Inactive'}</td>
                            <td>
                                <a href="/vendor/products/edit/${product.id}" class="btn btn-primary btn-sm">Edit</a>
                                <form action="/vendor/products/delete/${product.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Manage Orders -->
            <div id="orderManagement" class="collapse">
                <h4>Manage Orders</h4>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.status}</td>
                            <td>
                                <a href="/vendor/orders/updateStatus/${order.id}" class="btn btn-info btn-sm">Update Status</a>
                                <form action="/vendor/orders/cancel/${order.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-danger btn-sm">Cancel</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Promotions -->
            <div id="promotionManagement" class="collapse">
                <h4>Create & Manage Promotions</h4>
                <form method="post" action="/vendor/promotions/create">
                    <div class="mb-3">
                        <label for="promotionName" class="form-label">Promotion Name</label>
                        <input type="text" class="form-control" id="promotionName" name="promotionName" required>
                    </div>
                    <div class="mb-3">
                        <label for="promotionDiscount" class="form-label">Discount Percentage</label>
                        <input type="number" class="form-control" id="promotionDiscount" name="promotionDiscount" required>
                    </div>
                    <div class="mb-3">
                        <label for="promotionStart" class="form-label">Start Date</label>
                        <input type="date" class="form-control" id="promotionStart" name="promotionStart" required>
                    </div>
                    <div class="mb-3">
                        <label for="promotionEnd" class="form-label">End Date</label>
                        <input type="date" class="form-control" id="promotionEnd" name="promotionEnd" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Create Promotion</button>
                </form>
            </div>

            <!-- Revenue Management -->
            <div id="revenueManagement" class="collapse">
                <h4>Manage Shop Revenue</h4>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Revenue Period</th>
                        <th>Amount</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="revenue" items="${revenues}">
                        <tr>
                            <td>${revenue.period}</td>
                            <td>${revenue.amount}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Store Creation -->
<div class="modal fade" id="storeModal" tabindex="-1" aria-labelledby="storeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="storeModalLabel">Create New Store</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/vendor/saveOrUpdate" method="post" enctype="multipart/form-data">
                    <!-- Store Name -->
                    <div class="mb-3">
                        <label for="name" class="form-label">Store Name</label>
                        <input type="text" class="form-control" id="name" name = "name" required>
                    </div>

                    <!-- Store Description -->
                    <div class="mb-3">
                        <label for="storeDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="storeDescription" required></textarea>
                    </div>

                    <!-- Upload Image for Store Avatar -->
                    <div class="mb-3">
                        <label for="storeAvatar" class="form-label">Store Avatar (Image)</label>
                        <input type="file" class="form-control"  name="storeAvatar" accept="image/*" required>
                        <small class="form-text text-muted">Choose a profile image for your store (Max size: 5MB).</small>
                    </div>

                    <!-- Is Active Switch -->
                    <div class="mb-3">
                        <label for="isActive" class="form-label">Is Active</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="isActive">
                        </div>
                    </div>

                    <!-- Is Open Switch -->
                    <div class="mb-3">
                        <label for="isOpen" class="form-label">Is Open</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="isOpen" name="isOpen">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">Create Store</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Edit Store -->
<div class="modal fade" id="editStoreModal" tabindex="-1" aria-labelledby="editStoreModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editStoreModalLabel">Edit Store</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/vendor/stores/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="storeId" id="storeId">
                    <div class="mb-3">
                        <label for="storeName" class="form-label">Store Name</label>
                        <input type="text" class="form-control" id="storeName" name="storeName" required>
                    </div>
                    <div class="mb-3">
                        <label for="storeBio" class="form-label">Store Bio</label>
                        <textarea class="form-control" id="storeBio" name="storeBio" rows="4" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="storeAvatar" class="form-label">Store Avatar</label>
                        <input type="file" class="form-control" id="storeAvatar" name="storeAvatar">
                    </div>
                    <!-- Is Active Switch -->
                    <div class="mb-3">
                        <label class="form-label">Is Active</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="isActive">
                        </div>
                    </div>

                    <!-- Is Open Switch -->
                    <div class="mb-3">
                        <label for="isOpen" class="form-label">Is Open</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="isOpen">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    // Populate the modal fields when the Edit button is clicked
    const editStoreModal = document.getElementById('editStoreModal');
    editStoreModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget; // Button that triggered the modal
        const storeId = button.getAttribute('data-store-id');
        const storeName = button.getAttribute('data-store-name');
        const storeBio = button.getAttribute('data-store-bio');
        const storeAvatar = button.getAttribute('data-store-avatar');
        const isActive = button.getAttribute('data-store-isActive') === 'true';

        // Populate the fields in the modal
        document.getElementById('storeId').value = storeId;
        document.getElementById('storeName').value = storeName;
        document.getElementById('storeBio').value = storeBio;
        document.getElementById('isActive').checked = isActive;
    });
</script>