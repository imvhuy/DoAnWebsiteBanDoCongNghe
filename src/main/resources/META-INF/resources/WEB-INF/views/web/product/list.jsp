<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    /*.tf-shop-control {*/
    /*    display: flex;*/
    /*    flex-wrap: wrap;*/
    /*    justify-content: flex-start;*/
    /*    align-items: center;*/
    /*    margin-bottom: 20px;*/
    /*}*/
    /*@media (min-width: 1150px) {*/
    /*    .tf-dropdown-sort {*/
    /*        padding: 10px 18px;*/
    /*        min-width: 100px;*/
    /*    }*/
    /*}*/

</style>
<section class="flat-spacing-1">
    <div class="container">
            <div class="tf-control-sorting d-flex justify-content-end">
                <div class="tf-dropdown-sort" data-bs-toggle="dropdown">
                    <div class="btn-select">
                        <span class="text-sort-value">Featured</span>
                        <span class="icon icon-arrow-down"></span>
                    </div>
                    <div class="dropdown-menu">
                        <div class="select-item active">
                            <span class="text-value-item">Featured</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Best selling</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Alphabetically, A-Z</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Alphabetically, Z-A</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Price, low to high</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Price, high to low</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Date, old to new</span>
                        </div>
                        <div class="select-item">
                            <span class="text-value-item">Date, new to old</span>
                        </div>
                    </div>
                </div>
            </div>
        <div class="tf-row-flex">
            <div class="tf-shop-sidebar wrap-sidebar-mobile">

                <form action="#" id="facet-filter-form" class="facet-filter-form">

                    <!-- Availability Widget -->
                    <div class="widget-facet">
                        <div class="facet-title" data-bs-target="#availability" data-bs-toggle="collapse"
                             aria-expanded="true" aria-controls="availability">
                            <span>Availability</span>
                            <span class="icon icon-arrow-up"></span>
                        </div>
                        <div id="availability" class="collapse show">
                            <ul class="tf-filter-group current-scrollbar mb_36">
                                <li class="list-item d-flex gap-12 align-items-center">
                                    <input type="radio" name="availability" class="tf-check" id="availability-1">
                                    <label for="availability-1" class="label"><span>In stock</span>&nbsp;<span>(14)</span></label>
                                </li>
                                <li class="list-item d-flex gap-12 align-items-center">
                                    <input type="radio" name="availability" class="tf-check" id="availability-2">
                                    <label for="availability-2" class="label"><span>Out of stock</span>&nbsp;<span>(2)</span></label>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Price Widget -->
                    <div class="widget-facet wrap-price">
                        <div class="facet-title" data-bs-target="#price" data-bs-toggle="collapse" aria-expanded="true"
                             aria-controls="price">
                            <span>Price</span>
                            <span class="icon icon-arrow-up"></span>
                        </div>
                        <div id="price" class="collapse show">
                            <div class="widget-price filter-price">
                                <div class="tow-bar-block">
                                    <div class="progress-price"></div>
                                </div>
                                <div class="range-input">
                                    <input class="range-min" type="range" min="0" max="300" value="0"/>
                                    <input class="range-max" type="range" min="0" max="300" value="300"/>
                                </div>
                                <div class="box-title-price">
                                    <span class="title-price">Price :</span>
                                    <div class="caption-price">
                                        <div>
                                            <span>$</span>
                                            <span class="min-price">0</span>
                                        </div>
                                        <span>-</span>
                                        <div>
                                            <span>$</span>
                                            <span class="max-price">300</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Subcategory Widgets -->
                    <c:forEach var="subcategory" items="${subcategories}">
                        <div class="widget-facet">
                            <div class="facet-title" data-bs-target="#${subcategory.id}" data-bs-toggle="collapse"
                                 aria-expanded="true" aria-controls="${subcategory.id}">
                                <span>${subcategory.name}</span>
                                <span class="icon icon-arrow-up"></span>
                            </div>
                            <div id="${subcategory.id}" class="collapse show">
                                <ul class="tf-filter-group current-scrollbar mb_36">
                                    <c:forEach var="subcategoryValue" items="${subcategory.subcategoryValue}">
                                        <li class="list-item d-flex gap-12 align-items-center">
                                            <input type="checkbox" name="${subcategory.slug}" class="tf-check" id="${subcategoryValue.id}">
                                            <label for="${subcategoryValue.id}" class="label">
                                                <span id="subCategoryValue">${subcategoryValue.value}</span>&nbsp;
                                            </label>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:forEach>
                </form>
            </div>
            <div class="tf-shop-content wrapper-control-shop">
                <div class="meta-filter-shop"></div>
                <div class="grid-layout wrapper-shop" data-grid="grid-4">
                    <!-- Lặp qua danh sách sản phẩm -->
                    <c:forEach var="product" items="${productPages.content}">
                        <div class="card-product" data-price="${product.price}">
                            <div class="card-product-wrapper">
                                <a href="product-detail.html" class="product-img">
                                    <img class="lazyload img-product" src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/329149/iphone-16-pro-max-titan-den-1-638638962017739954-750x500.jpg" alt="image-product">
                                    <img class="lazyload img-hover" src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/329149/iphone-16-pro-max-titan-den-1-638638962017739954-750x500.jpg" alt="image-product">
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
                                    <a href="<c:url value='/products'>
                                <c:param name='name' value='${name}'/>
                                <c:param name='page' value='${pageNumber}'/>
                            </c:url>" style="width: 40px;height: 30px;text-align: center;">${pageNumber}</a>
                                </li>
                            </c:forEach>

                            <!-- Next Page Link -->
                            <li class="pagination-link">
                                <a href="<c:url value='/products'>
                            <c:param name='name' value='${name}'/>
                            <c:param name='page' value='${productPages.number + 2 <= productPages.totalPages ? productPages.number + 2 : productPages.totalPages}'/>
                        </c:url>" style="width: 40px;height: 30px;text-align: center;">
                                    <i class="icon icon-arrow-right"></i>
                                </a>
                            </li>
                        </ul>
                    </c:if>
                </ul>

            </div>
        </div>
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
    document.querySelectorAll('.tf-check').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            // Lấy tất cả các giá trị của các checkbox đã chọn
            let subcategoryMap = {};

            document.querySelectorAll('.tf-check:checked').forEach(function (checkedCheckbox) {
                let subcategoryId = checkedCheckbox.name; // subcategoryId là name của checkbox
                let selectedValue = checkedCheckbox.nextElementSibling.querySelector('span').textContent; // Lấy giá trị từ <span>

                // Nếu subcategoryId đã có trong map, thêm selectedValue vào mảng
                if (!subcategoryMap[subcategoryId]) {
                    subcategoryMap[subcategoryId] = [];
                }
                subcategoryMap[subcategoryId].push(selectedValue);
            });

            // Tạo query string từ đối tượng subcategoryMap
            let params = [];
            for (let key in subcategoryMap) {
                // Mỗi key là subcategoryId, giá trị là một danh sách các selectedValues
                subcategoryMap[key].forEach(function(value) {
                    params.push(encodeURIComponent(key) + '=' + encodeURIComponent(value));
                });
            }

            // Tạo URL với các tham số query
            let url = '/products?'+ params.join('&');

            // Gửi yêu cầu GET đến server
            window.location.href = url; // Chuyển hướng đến URL với query string
        });
    });

</script>
