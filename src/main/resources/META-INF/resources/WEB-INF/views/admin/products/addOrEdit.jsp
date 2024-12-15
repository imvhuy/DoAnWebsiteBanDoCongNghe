<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>

    html, body {
        height: 100%;
        overflow: auto; /* Cho phép cuộn toàn bộ trang */
        overflow-x: hidden
    }

    .main-content, .main-content-wrap {
        height: auto; /* Cho phép chiều cao tự động */
        min-height: 100vh; /* Tối thiểu bằng chiều cao màn hình */
        overflow-y: auto; /* Cho phép cuộn dọc */
    }

    #wrapper, #page, .layout-wrap {
        height: auto; /* Chiều cao tự động */
        overflow: visible; /* Hiển thị toàn bộ nội dung */
    }

    .main-content-inner {
        position: relative; /* Tránh dùng fixed hoặc absolute */
    }

    .wg-box {
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .box-title {
        font-size: 24px;
        margin-bottom: 20px;
        font-weight: bold;
    }

    .image-upload-container {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        margin-bottom: 20px;
    }

    .image-box {
        padding: 20px;
        border: 2px dashed #ccc;
        border-radius: 8px;
        text-align: center;
        position: relative;
        overflow: hidden;
        background: #f7f7f7;
    }

    .image-box:hover {
        background-color: #efefef;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .image-box label {
        display: block;
        margin-bottom: 10px;
        font-size: 16px;
        color: #555;
    }

    .image-input {
        display: none;
    }

    .image-preview {
        width: 100%;
        height: 200px;
        object-fit: contain;
        border-radius: 8px;
        display: none;
        max-width: 100%;
        max-height: 100%;
        margin-top: 10px;
    }

    .image-box input[type="file"] {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        opacity: 0;
        cursor: pointer;
    }

    .submit-btn {
        display: block;
        margin: 20px auto;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .submit-btn:hover {
        background-color: #45a049;
    }

    /* Sử dụng Flexbox để căn chỉnh các ảnh thành một hàng */
    /* Thẻ cha sử dụng Flexbox để căn chỉnh */
    .flat-spacing-2 {
        display: flex;
        justify-content: space-between;
        gap: 20px;
    }

    form.form-style-1 > * > *:first-child {
        max-width: 1200px !important;
    }

    .image-box {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        border: 1px solid #ccc;
        padding: 20px; /* Tăng khoảng cách padding cho ảnh lớn hơn */
        box-sizing: border-box;
    }

    .image-label {
        font-weight: bold;
        margin-bottom: 10px;
    }

    .image-input {
        margin-bottom: 15px;
    }

    .image-preview {
        display: block;
        max-width: 300px; /* Tăng kích thước tối đa của ảnh */
        width: 100%;
        /* Cho phép ảnh mở rộng đầy đủ theo chiều ngang */
        height: auto; /* Duy trì tỷ lệ ảnh */
        margin-top: 10px;
    }
</style>

<!-- #wrapper -->
<div id="wrapper">
    <!-- #page -->
    <div id="page" class="">
        <!-- layout-wrap -->
        <div class="layout-wrap loader-off">
            <!-- preload -->
            <div id="preload" class="preload-container">
                <div class="preloading">
                    <span></span>
                </div>
            </div>
            <!-- /preload -->

            <!-- section-content-right -->
            <div class="section-content-right">

                <!-- main-content -->
                <div class="main-content">
                    <!-- main-content-wrap -->
                    <div class="main-content-inner">
                        <!-- main-content-wrap -->
                        <div class="main-content-wrap">
                            <div
                                    class="flex items-center flex-wrap justify-between gap20 mb-30">
                                <ul
                                        class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                                    <li><a href="index.html">
                                        <div class="text-tiny">Dashboard</div>
                                    </a></li>
                                    <li><i class="icon-chevron-right"></i></li>
                                    <li><a href="#">
                                        <div class="text-tiny">Product</div>
                                    </a></li>
                                    <li><i class="icon-chevron-right"></i></li>
                                    <li>
                                        <div class="text-tiny">Add Product</div>
                                    </li>
                                </ul>
                            </div>
                            <!-- form-add-product -->
                            <form:form action="/admin/products/saveOrUpdate" method="POST"
                                       enctype="multipart/form-data" modelAttribute="product"
                                       class="form-new-product form-style-1 ">
                            <input type="hidden" value="${product.id}" name="id">
                                <%--                               <input type="text" value="${product.categoryId}" name="id">--%>
                                <%--                            <img src="/admin/images/products/${product.ga.image}"  style="display: block; max-width: 200px;" />--%>
                            <div class="wg-box mb-30">
                                <!-- Form Upload -->
                                <div class="flat-spacing-2 grid-4">
                                    <div class="image-box" id="rightBox">
                                        <label for="rightImage" class="image-label">Right
                                            Image</label> <input type="file" id="rightImage" name="rightImage"
                                                                 class="image-input" accept="image/*"
                                                                 onchange="previewImage(this, 'rightPreview')">
                                        <c:if test="${not empty product.galleries}">
                                            <c:forEach var="gallery" items="${product.galleries}">
                                                <c:if test="${gallery.type == 'right'}">
                                                    <!-- Hiển thị ảnh từ thư mục static/admin/images/products -->
                                                    <img src="/admin/images/products/${gallery.image}"
                                                         alt="Right Image" class="image-preview" id="rightPreview"
                                                         style="display: block; max-width: 200px;"/>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <!-- Placeholder for preview if no image is loaded -->
                                        <img id="rightPreview" alt="Right Image"
                                             class="image-preview"
                                             style="display: none; max-width: 200px;"/>
                                    </div>

                                    <!-- Left Image -->
                                    <div class="image-box" id="leftBox">
                                        <label for="leftImage" class="image-label">Left Image</label>
                                        <input type="file" id="leftImage" name="leftImage"
                                               class="image-input" accept="image/*"
                                               onchange="previewImage(this, 'leftPreview')">

                                        <c:if test="${not empty product.galleries}">
                                            <c:forEach var="gallery" items="${product.galleries}">
                                                <c:if test="${gallery.type == 'left'}">
                                                    <img src="/admin/images/products/${gallery.image}"
                                                         alt="Left Image" class="image-preview" id="leftPreview"
                                                         style="display: block; max-width: 200px;"/>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <!-- Placeholder for preview -->
                                        <img id="leftPreview" alt="Left Image" class="image-preview"
                                             style="display: none; max-width: 200px;"/>
                                    </div>

                                    <!-- Behind Image -->
                                    <div class="image-box" id="behindBox">
                                        <label for="behindImage" class="image-label">Behind
                                            Image</label> <input type="file" id="behindImage" name="behindImage"
                                                                 class="image-input" accept="image/*"
                                                                 onchange="previewImage(this, 'behindPreview')">

                                        <c:forEach var="gallery" items="${product.galleries}">
                                            <c:if test="${gallery.type == 'behind'}">
                                                <img src="/admin/images/products/${gallery.image}"
                                                     alt="Behind Image" class="image-preview"
                                                     id="behindPreview"
                                                     style="display: block; max-width: 200px;"/>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Placeholder for preview -->
                                        <img id="behindPreview" alt="Behind Image"
                                             class="image-preview"
                                             style="display: none; max-width: 200px;"/>
                                    </div>

                                    <!-- Front Image -->
                                    <div class="image-box" id="frontBox">
                                        <label for="frontImage" class="image-label">Front
                                            Image</label> <input type="file" id="frontImage" name="frontImage"
                                                                 class="image-input" accept="image/*"
                                                                 onchange="previewImage(this, 'frontPreview')">

                                        <c:if test="${not empty product.galleries}">
                                            <c:forEach var="gallery" items="${product.galleries}">
                                                <c:if test="${gallery.type == 'front'}">
                                                    <img src="/admin/images/products/${gallery.image}"
                                                         alt="Front Image" class="image-preview" id="frontPreview"
                                                         style="display: block; max-width: 200px;"/>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <!-- Placeholder for preview -->
                                        <img id="frontPreview" alt="Front Image"
                                             class="image-preview"
                                             style="display: none; max-width: 200px;"/>
                                    </div>
                                </div>
                                <!-- Product Name -->
                                <fieldset class="name">
                                    <div class="body-title">Product Name</div>
                                    <form:input path="name" class="body-title mb-10" type="text"
                                                placeholder="Product Name" tabindex="0"
                                                value="${product.name}" aria-required="true" required="true"/>
                                </fieldset>

                                <fieldset class="category">
                                    <div class="body-title">Category</div>
                                    <form:select path="categoryName" class="body-title mb-10" aria-required="true" required="true" name="categoryName" onchange="loadSubcategories()">
                                        <form:option value="">Choose Category</form:option>
                                        <!-- Sử dụng c:forEach từ JSTL để duyệt danh sách categories -->
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.name}" ${category.name == product.categoryName ? 'selected' : ''}>
                                                    ${category.name}
                                            </option>
                                        </c:forEach>
                                    </form:select>
                                </fieldset>

                                <fieldset class="subcategory">
                                    <div class="body-title">SubcategoryValue</div>
                                    <form:select path="subcategoryName" class="body-title mb-10" aria-required="true" required="true" multiple="multiple" id="subcategorySelect" onchange="handleSubcategorySelection()">

                                        <!-- Subcategory options will be dynamically loaded here -->
                                    </form:select>

                                    <div id="selectedSubcategories" class="selected-subcategories">
                                        <!-- Các giá trị đã chọn sẽ hiển thị ở đây -->
                                    </div>
                                </fieldset>
                                <fieldset class="color">
                                    <div class="body-title">Color</div>
                                    <form:select path="color" class="body-title mb-10"
                                                 aria-required="true" required="true">
                                        <option value="">Choose Color</option>
                                        <option value="Red"
                                            ${product.color == 'Red' ? 'selected' : ''}>Red
                                        </option>
                                        <option value="Blue"
                                            ${product.color == 'Blue' ? 'selected' : ''}>Blue
                                        </option>
                                        <option value="Yellow"
                                            ${product.color == 'Yellow' ? 'selected' : ''}>
                                            Yellow
                                        </option>
                                        <option value="Black"
                                            ${product.color == 'Black' ? 'selected' : ''}>
                                            Black
                                        </option>
                                        <option value="White"
                                            ${product.color == 'White' ? 'selected' : ''}>
                                            White
                                        </option>
                                        <option value="Pink"
                                            ${product.color == 'Pink' ? 'selected' : ''}>Pink
                                        </option>
                                    </form:select>
                                </fieldset>
                                <div class="cols-lg gap22">
                                    <fieldset class="price">
                                        <div class="body-title">Price</div>
                                        <form:input path="price" class="body-title mb-10"
                                                    type="number" placeholder="Price" value="${product.price}"
                                                    aria-required="true" required="true"/>
                                    </fieldset>
                                    <fieldset class="promotion-price">
                                        <div class="body-title">Promotion Price</div>
                                        <form:input path="promotionalPrice" class="body-title mb-10"
                                                    type="number" placeholder="Promotion Price"
                                                    value="${product.promotionalPrice}" aria-required="true"
                                                    required="true"/>
                                    </fieldset>
                                    <fieldset class="sold">
                                        <div class="body-title">Total Sold</div>
                                        <form:input path="totalSold" class="body-title mb-10"
                                                    type="number" placeholder="Sold"
                                                    value="${product.totalSold}" readonly="true"/>
                                    </fieldset>
                                    <fieldset class="quantity">
                                        <div class="body-title">Total Quantity</div>
                                        <form:input path="totalQuantity" class="body-title mb-10"
                                                    type="number" placeholder="Total Quantity"
                                                    value="${product.totalQuantity}" readonly="true"/>
                                    </fieldset>
                                </div>
                                <fieldset class="configuration">
                                    <div class="body-title">Configuration</div>
                                    <form:textarea path="configuration" class="body-title mb-10"
                                                   placeholder="Configuration" value="${product.configuration}"
                                                   aria-required="true" required="true"></form:textarea>
                                </fieldset>
                                <!-- Description -->
                                <fieldset class="description">
                                    <div class="body-title">Description</div>
                                    <form:textarea path="description" class="body-title mb-10"
                                                   placeholder="Product description"
                                                   value="${product.description}" aria-required="true"
                                                   required="true"></form:textarea>
                                </fieldset>
                                <fieldset class="video">
                                    <div class="body-title">Video</div>
                                    <form:textarea path="video" class="body-title mb-10"
                                                   placeholder="video" value="${product.video}"
                                                   aria-required="true" required="true"></form:textarea>
                                </fieldset>
                                <fieldset class="mb-24">
                                    <div class="body-title mb-10">Is Active</div>
                                    <div class="radio-buttons">
                                        <div class="item">
                                            <!-- Status 'Active' -->
                                            <form:radiobutton path="isActive" value="true" id="store-status1"
                                                        class=""
                                                        label="Active"
                                                        checked="${store.isActive == true}"/>
                                        </div>
                                        <div class="item">
                                            <!-- Status 'Inactive' -->
                                            <form:radiobutton path="isActive" value="false" id="store-status2"
                                                        class=""
                                                        label="Inactive"
                                                        checked="${store.isActive == false}"/>
                                        </div>
                                    </div>
                                </fieldset>

                                <fieldset class="mb-24">
                                    <div class="body-title mb-10">Is Selling</div>
                                    <div class="radio-buttons">
                                        <div class="item">
                                            <!-- Status 'Active' -->
                                            <form:radiobutton path="isSelling" value="true" id="store-selling1"
                                                        class=""
                                                        label="Active"
                                                        checked="${store.isSelling == true}"/>
                                        </div>
                                        <div class="item">
                                            <!-- Status 'Inactive' -->
                                            <form:radiobutton path="isSelling" value="false" id="store-selling2"
                                                        class=""
                                                        label="Inactive"
                                                        checked="${store.isSelling == false}"/>
                                        </div>
                                    </div>
                                </fieldset>
                                <button class="tf-button w208" type="submit">
                                        ${product.id == null ? 'Add Product' : 'Update Product'}</button>
                            </div>
                        </div>

                        </form:form>
                        <iframe width="560" height="315" src="${product.video}"
                                frameborder="0"
                                allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                        <!-- /form-add-product -->
                    </div>
                    <!-- /main-content-wrap -->
                </div>
                <!-- /main-content-wrap -->
                <!-- bottom-page -->
                <div class="bottom-page">
                    <div class="body-text">
                        Copyright © 2024 <a
                            href="https://themesflat.co/html/ecomus/index.html">Ecomus</a>.
                        Design by Themesflat All rights reserved
                    </div>
                </div>
                <!-- /bottom-page -->
            </div>
            <!-- /main-content -->
        </div>
        <!-- /section-content-right -->
    </div>
    <!-- /layout-wrap -->
</div>
<!-- /#page -->
<!-- /#wrapper -->

<!-- Thêm đoạn này vào đầu form -->
<c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">${message}</div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger" role="alert">${error}</div>
</c:if>
<script type="text/javascript" src="/web/js/jquery.min.js"></script>
<script>
    function loadSubcategories() {
        // Get the selected category
        var categoryName = $("select[name='categoryName']").val();

        // If no category is selected, exit the function
        if (!categoryName) {
            return;
        }

        // Send an AJAX request to fetch subcategories for the selected category
        $.ajax({
            url: "/api/subcategories/" + categoryName, // API endpoint
            type: "GET", // HTTP method
            data: { categoryName: categoryName }, // Data to send
            success: function(subcategories) {
                // Clear existing subcategory options
                var subcategorySelect = $("select[name='subcategoryName']");
                subcategorySelect.empty();

                // Loop through the returned subcategories and add them as options
                $.each(subcategories, function(index, subcategory) {
                    subcategorySelect.append('<option value="' + subcategory.value + '">' + subcategory.value + '</option>');
                });
            },
            error: function(xhr, status, error) {
                // Handle errors (e.g., network issues, API failures)
                console.error("Error loading subcategories: " + error);
            }
        });
    }

    // Hàm preview hình ảnh khi người dùng chọn ảnh
    function previewImage(input, previewId) {
        var file = input.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var preview = document
                    .getElementById(previewId);
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    }

    window.onload = function () {
        // Hiển thị ảnh đã tải lên trong các preview
        var imageTypes = ['right', 'left',
            'behind', 'front'];

        imageTypes
            .forEach(function (type) {
                var inputElement = document
                    .getElementById(type
                        + 'Image');
                var previewElement = document
                    .getElementById(type
                        + 'Preview');

                if (previewElement
                    && previewElement.src) {
                    previewElement.style.display = 'block'; // Hiển thị ảnh nếu đã có
                }

                // Nếu có file được chọn, hiển thị ảnh preview ngay lập tức
                if (inputElement.files
                    && inputElement.files[0]) {
                    previewImage(
                        inputElement,
                        type
                        + 'Preview');
                }
            });
    };
</script>