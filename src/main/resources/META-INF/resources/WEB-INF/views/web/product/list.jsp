<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- page-title -->
<div class="tf-page-title">
    <div class="container-full">
        <div class="row">
            <div class="col-12">
                <div class="heading text-center">Product</div>
                <p class="text-center text-2 text_black-2 mt_5">Shop through our latest selection of Fashion</p>
            </div>
        </div>
    </div>
</div>
<!-- /page-title -->
<style>

    .price-filter-box h3 {
        margin-bottom: 15px;
        font-size: 16px;
        font-weight: bold;
    }

    input[type="range"] {
        width: 100%;
        margin: 10px 0;
    }

    .price-values {
        display: flex;
        justify-content: space-between;
        font-size: 14px;
        color: #333;
    }

</style>
<section class="flat-spacing-2">
    <div class="container">
        <form action="${pageContext.request.contextPath}/products/${categoryslug}" method="get" id="facet-filter-form">
            <div class="tf-shop-control grid-4 align-items-center">
                <div class="tf-dropdown-sort">
                    <div class="btn-select">
                        <span class="text-sort-value" id="availability-selected">Select Availability</span>
                        <span class="icon icon-arrow-down"></span>
                    </div>
                    <div class="dropdown-menu">
                        <div class="select-item" onclick="selectFilter('availability', 'san-hang', 'Sẵn hàng')">
                            <span class="text-value-item">Sẵn hàng</span>
                        </div>
                        <div class="select-item" onclick="selectFilter('availability', 'het-hang', 'Hết hàng')">
                            <span class="text-value-item">Hết hàng</span>
                        </div>
                    </div>
                    <!-- Hidden input để giữ giá trị được chọn -->
                    <input type="hidden" name="availability" id="availability-input">
                </div>

                <!-- Price Range Filter -->
                <div class="price-filter-box tf-dropdown-sort">
                    <div class="btn-select">
                        <span class="text-sort-value" id="price-selected">Chọn giá</span>
                        <span class="icon icon-arrow-down"></span>
                    </div>
                    <div class="dropdown-menu" style="padding-left: 10px;padding-right: 10px;">
                        <h3>Chọn khoảng giá</h3>

                        <!-- Thanh trượt giá -->
                        <input type="range" id="priceRange" min="0" max="${maxPrice}" step="1" value="${maxPrice}">

                        <!-- Hiển thị giá trị đã chọn -->
                        <div class="price-values">
                            <span id="minPrice">0 VNĐ</span> -
                            <span id="maxPrice">${maxPrice} VNĐ</span>
                        </div>

                        <!-- Input ẩn để truyền dữ liệu về controller -->
                        <input type="hidden" name="minPrice" id="minPrice-input">
                        <input type="hidden" name="maxPrice" id="maxPrice-input">
                    </div>
                </div>



                <!-- Filter dropdown for each subcategory -->
                <c:forEach var="subcategory" items="${subcategories}">
                    <div class="tf-dropdown-sort">
                        <div class="btn-select">
                            <span class="text-sort-value" id="${subcategory.slug}-selected">Select ${subcategory.name}</span>
                            <span class="icon icon-arrow-down"></span>
                        </div>
                        <div class="dropdown-menu">
                            <c:forEach var="subcategoryValue" items="${subcategory.subcategoryValue}">
                                <div class="select-item" onclick="selectFilter('${subcategory.slug}', '${subcategoryValue.slug}', '${subcategoryValue.value}')">
                                    <span class="text-value-item">${subcategoryValue.value}</span>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- Hidden input to hold the selected value -->
                        <input type="hidden" name="${subcategory.slug}" id="${subcategory.slug}-input">
                    </div>
                </c:forEach>

                <!-- Submit Button for applying filters -->
                <div class="tf-control-sorting d-flex justify-content-end">
                    <button type="submit" class="btn btn-primary">Apply Filter</button>
                </div>
            </div>
        </form>
        </div>
        <div class="wrapper-control-shop">
            <div class="meta-filter-shop"></div>
            <div class="grid-layout wrapper-shop" data-grid="grid-4">
                <c:forEach var="product" items="${productPages.content}">
                    <div class="card-product" data-price="${product.price}">
                        <div class="card-product-wrapper">
                            <a href="${pageContext.request.contextPath}/product-detail/${product.id}" class="product-img">
                                <img class="lazyload img-product"
                                     src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/329149/iphone-16-pro-max-titan-den-1-638638962017739954-750x500.jpg"
                                     alt="image-product">
                                <img class="lazyload img-hover"
                                     src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/329149/iphone-16-pro-max-titan-den-1-638638962017739954-750x500.jpg"
                                     alt="image-product">
                            </a>
                            <div class="list-product-btn absolute-2">
                                <a href="#quick_add" data-bs-toggle="modal"
                                   class="box-icon bg_white quick-add tf-btn-loading">
                                    <span class="icon icon-bag"></span>
                                    <span class="tooltip">Quick Add</span>
                                </a>
                                <a href="javascript:void(0);" class="box-icon bg_white wishlist btn-icon-action">
                                    <span class="icon icon-heart"></span>
                                    <span class="tooltip">Add to Wishlist</span>
                                    <span class="icon icon-delete"></span>
                                </a>
                                <a href="#compare" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft"
                                   class="box-icon bg_white compare btn-icon-action">
                                    <span class="icon icon-compare"></span>
                                    <span class="tooltip">Add to Compare</span>
                                    <span class="icon icon-check"></span>
                                </a>
                                <a href="#quick_view" data-bs-toggle="modal"
                                   class="box-icon bg_white quickview tf-btn-loading">
                                    <span class="icon icon-view"></span>
                                    <span class="tooltip">Quick View</span>
                                </a>
                            </div>
                        </div>
                        <div class="card-product-info">
                            <a href="product-detail.html" class="title link">${product.name}</a>
                            <span class="price">${product.price}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- pagination -->
            <ul class="tf-pagination-wrap tf-pagination-list tf-pagination-btn">
                <c:if test="${productPages.totalPages > 0}">
                    <ul class="wg-pagination">
                        <!-- Page Numbers -->
                        <c:forEach var="pageNumber" items="${pageNumbers}">
                            <li class="pagination-link animate-hover-btn <c:if test='${pageNumber == productPages.number + 1}'>active</c:if>">
                                <a href="<c:url value='/products/${category.slug}'>
                                <c:param name='page' value='${pageNumber}'/>
                                <c:forEach var="key" items="${params}">
                                    <c:param name="${key.key}" value="${key.value}" />
                                </c:forEach>
                             </c:url>"
                                   style="width: 40px;height: 30px;text-align: center;">${pageNumber}</a>
                            </li>
                        </c:forEach>

                        <!-- Next Page Link -->
                        <li class="pagination-link">
                            <a href="<c:url value='/products/${category.slug}'>
                            <c:param name='page' value='${productPages.number + 2 <= productPages.totalPages ? productPages.number + 2 : productPages.totalPages}'/>
                            <c:forEach var="key" items="${params}">
                                <c:param name="${key.key}" value="${key.value}" />
                            </c:forEach>
                         </c:url>"
                               style="width: 40px;height: 30px;text-align: center;">
                                <i class="icon icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </c:if>
            </ul>

        </div>
</section>

<script type="text/javascript" src="/web/js/jquery.min.js"></script>
<script>
    document.querySelectorAll('.tf-dropdown-sort').forEach(function (dropdown) {
        dropdown.addEventListener('click', function () {
            var menu = this.querySelector('.dropdown-menu');
            var isVisible = menu.classList.contains('show');
            document.querySelectorAll('.dropdown-menu').forEach(function (m) {
                m.classList.remove('show');
            });
            if (!isVisible) {
                menu.classList.add('show');
            }
        });
    });

    function setDropdownValue(element, value) {
        // Lấy phần tử dropdown chứa giá trị đã chọn
        var dropdown = element.closest('.tf-dropdown-sort');

        // Cập nhật giá trị hiển thị trong dropdown
        dropdown.querySelector('.text-sort-value').textContent = value;
    }

    function selectFilter(filterName, filterValue, filterText) {
        // Cập nhật giá trị được chọn hiển thị trong dropdown
        document.getElementById(filterName + '-selected').innerText = filterText;

        // Cập nhật giá trị vào input ẩn
        document.getElementById(filterName + '-input').value = filterValue;
    }
    document.getElementById('facet-filter-form').addEventListener('submit', function (e) {
        const inputs = this.querySelectorAll('input[type="hidden"]');

        inputs.forEach(input => {
            if (!input.value || input.value.trim() === '') {
                input.removeAttribute('name'); // Loại bỏ name để không gửi tham số
            }
        });
    });

    // Cập nhật giá trị khi thay đổi thanh trượt
    const priceRange = document.getElementById("priceRange");
    const minPriceDisplay = document.getElementById("minPrice");
    const maxPriceDisplay = document.getElementById("maxPrice");
    const minPriceInput = document.getElementById("minPrice-input");
    const maxPriceInput = document.getElementById("maxPrice-input");

    priceRange.addEventListener("input", function () {
        const value = priceRange.value;

        // Cập nhật giá trị hiển thị
        minPriceDisplay.textContent = formatPrice(0);
        maxPriceDisplay.textContent = formatPrice(value);

        // Cập nhật input ẩn
        minPriceInput.value = 0;
        maxPriceInput.value = value;

        // Cập nhật giá trị hiển thị trong dropdown
        document.getElementById('price-selected').textContent = '0 - ' + formatPrice(value);
    });

    function formatPrice(price) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
            minimumFractionDigits: 0
        }).format(price);
    }
</script>
