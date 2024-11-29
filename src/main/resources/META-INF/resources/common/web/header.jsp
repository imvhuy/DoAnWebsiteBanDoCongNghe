<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- Top bar -->
<div class="tf-top-bar bg_dark line">
    <div class="px_15 lg-px_40">
        <div class="tf-top-bar_wrap grid-3 gap-30 align-items-center">
            <div class="tf-top-bar_left">
                <div class="d-flex gap-30 text_white fw-5 ">
                    <span></span>
                </div>
            </div>
            <div class="text-center overflow-hidden">
                <div class="swiper tf-sw-top_bar" data-preview="1" data-space="0" data-loop="true" data-speed="1000"
                     data-delay="2000">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <p class="top-bar-text fw-5 text_white">Welcome to store. Fantastic theme! Beautifully
                                designed</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /Top bar -->
<style>/* Search form in navigation */
.search-bar {
    display: flex;
    align-items: center;
}

.search-form {
    display: flex;
    align-items: center;
}

.search-form input {
    border: 1px solid #ccc;
    padding: 5px 10px;
    border-radius: 4px 0 0 4px;
    outline: none;
    width: 350px;
}

.search-form button {
    background-color: transparent;
    border: none;
    padding: 5px 10px;
    border-radius: 0 4px 4px 0;
    cursor: pointer;
}

.search-form button i {
    font-size: 1.2em;
}

/* Container chính */
.menu-container {
    display: flex;
    border: 1px solid #ddd;
    background-color: #fff;
    width: 100%;
    padding: 5px; /* Quá lớn hoặc không cân đối */
    max-width: 1400px;
    margin: 0 auto;
    position: relative;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}


/* Mặc định ẩn menu-right */
.hidden {
    display: none;
}

/* Khi có nội dung, hiển thị menu-right */
.menu-right {
    width: 100%; /* Hoặc tăng giá trị phù hợp với kích thước mong muốn */
    padding: 15px;
    background-color: #fff;
    flex: 1; /* Sử dụng flex để dãn đều với các thành phần khác */
    box-sizing: border-box; /* Đảm bảo padding không làm tăng chiều rộng */
}


.menu-content.active {
    display: block; /* Hiển thị nội dung khi có lớp active */
}

.menu-right.active {
    display: flex; /* Hiển thị khi cần */
}

/* Mega Menu chính */
.mega-menu {
    position: absolute;
    top: 100%; /* Xuất hiện ngay dưới menu chính */
    left: 50%; /* Căn giữa theo chiều ngang */
    transform: translateX(-50%); /* Dịch chuyển menu về giữa */
    width: 100%; /* Rộng hơn (chiếm 90% màn hình) */
    background-color: #fff;
    padding: 30px; /* Tăng padding để nhìn rộng rãi hơn */
    border-radius: 8px; /* Bo góc để nhìn mềm mại hơn */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border: 1px solid #ddd;
    z-index: 1000; /* Đảm bảo menu nằm trên các thành phần khác */
}

/* Bố cục bên trong Mega Menu */
.menu-row {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 5 cột đều nhau */
    gap: 20px; /* Khoảng cách giữa các cột */
}

/* Cột trong Mega Menu */
.menu-column {
    width: 200px;
    background: #f9f9f9;
    padding: 15px;
    border-radius: 5px;
    border: 1px solid #ddd;
}

.menu-column h4 {
    font-size: 18px; /* Tăng kích thước tiêu đề */
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.menu-column ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.menu-column ul li {
    margin-bottom: 8px; /* Tăng khoảng cách giữa các mục */
}

.menu-column ul li a {
    text-decoration: none;
    color: #555;
    font-size: 14px;
}

.menu-column ul li a:hover {
    color: #007bff;
}

/* Badge "Mới" */
.new-badge {
    background-color: red;
    color: white;
    padding: 2px 6px;
    font-size: 12px;
    border-radius: 3px;
    margin-left: 5px;
}

/* Danh mục bên trái */
.menu-left {
    background-color: #f5f5f5;
    padding: 15px;
    width: 20%; /* Đảm bảo menu bên trái nhỏ hơn phần nội dung */
    min-width: 200px;
}

.menu-left ul {
    list-style: none;
    padding: 0;
}

.menu-left ul li {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    cursor: pointer;
    text-align: left;
    font-size: 16px; /* Tăng kích thước danh mục */
    font-weight: bold;
}

.menu-left ul li:hover {
    background-color: #ddd;
    color: #007bff;
}

.category-item {
    background-color: transparent; /* Xóa màu nền */
    padding: 0; /* Loại bỏ padding nếu không cần */
    margin: 0; /* Căn chỉnh để không bị lệch */
    text-align: left; /* Căn chỉnh chữ về bên trái */
    font-size: 14px; /* Kích thước chữ đồng đều */
    font-weight: normal; /* Đảm bảo không bị nhấn mạnh */
    line-height: 1.6; /* Đặt khoảng cách dòng phù hợp */
}

.category-item:hover {
    background-color: #ddd; /* Chỉ áp dụng hiệu ứng nền khi hover (nếu cần) */
    cursor: pointer;
}

</style>
<!-- Header -->
<header id="header" class="header-default">
    <div class="px_15 lg-px_40">
        <div class="row wrapper-header align-items-center" style="height: 90px;">
            <div class="col-xl-2 col-md-4 col-6 text-center">
                <a href="/home" class="logo-header">
                    <img src="/web/images/logo/logo.jpg" alt="logo" class="logo" style="max-height: 40px;">
                </a>
            </div>

            <!-- Mobile Menu Icon -->
            <div class="col-md-4 col-3 tf-lg-hidden">
                <a href="#mobileMenu" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft">
                    <!-- SVG icon for mobile menu -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="16" viewBox="0 0 24 16" fill="none">
                        <path d="M2.00056 2.28571H16.8577C17.1608 2.28571 17.4515 2.16531 17.6658 1.95098C17.8802 1.73665 18.0006 1.44596 18.0006 1.14286C18.0006 0.839753 17.8802 0.549063 17.6658 0.334735C17.4515 0.120408 17.1608 0 16.8577 0H2.00056C1.69745 0 1.40676 0.120408 1.19244 0.334735C0.978109 0.549063 0.857702 0.839753 0.857702 1.14286C0.857702 1.44596 0.978109 1.73665 1.19244 1.95098C1.40676 2.16531 1.69745 2.28571 2.00056 2.28571ZM0.857702 8C0.857702 7.6969 0.978109 7.40621 1.19244 7.19188C1.40676 6.97755 1.69745 6.85714 2.00056 6.85714H22.572C22.8751 6.85714 23.1658 6.97755 23.3801 7.19188C23.5944 7.40621 23.7148 7.6969 23.7148 8C23.7148 8.30311 23.5944 8.59379 23.3801 8.80812C23.1658 9.02245 22.8751 9.14286 22.572 9.14286H2.00056C1.69745 9.14286 1.40676 9.02245 1.19244 8.80812C0.978109 8.59379 0.857702 8.30311 0.857702 8ZM0.857702 14.8571C0.857702 14.554 0.978109 14.2633 1.19244 14.049C1.40676 13.8347 1.69745 13.7143 2.00056 13.7143H12.2863C12.5894 13.7143 12.8801 13.8347 13.0944 14.049C13.3087 14.2633 13.4291 14.554 13.4291 14.8571C13.4291 15.1602 13.3087 15.4509 13.0944 15.6653C12.8801 15.8796 12.5894 16 12.2863 16H2.00056C1.69745 16 1.40676 15.8796 1.19244 15.6653C0.978109 15.4509 0.857702 15.1602 0.857702 14.8571Z"
                              fill="currentColor"></path>
                    </svg>
                </a>
            </div>

            <!-- Navigation Menu -->
            <div class="col-xl-5 tf-md-hidden">
                <nav class="box-navigation text-center">
                    <ul class="box-nav-ul d-flex align-items-center gap-30">
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 5px 10px;">Home<i
                                    class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <div class="container">
                                    <div class="row-demo">
                                        <div class="demo-item">
                                            <a href="index.html">
                                                <div class="demo-image position-relative">
                                                    <img class="lazyload" data-src="/web/images/demo/home-01.jpg"
                                                         src="/web/images/demo/home-01.jpg" alt="home-01">
                                                    <div class="demo-label">
                                                        <span class="demo-new">New</span>
                                                        <span>Trend</span>
                                                    </div>
                                                </div>
                                                <span class="demo-name">Home Fashion 01</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 5px 10px;">Showroom<i
                                    class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 5px 10px;">Category<i
                                    class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu" style="padding-top: 0px;top: 90px;">
                                <div class="menu-container">
                                    <!-- Danh sách danh mục bên trái -->
                                    <div class="menu-left">
                                        <ul class="categories" id="category-list">
                                            <!-- Danh mục sẽ được load qua Ajax -->
                                        </ul>
                                    </div>

                                    <!-- Nội dung chi tiết bên phải (mặc định ẩn) -->
                                    <div id="category-content" class="menu-right hidden"></div>
                                    <div id="subcategory-value-content" class="menu-column hidden"></div>

                                </div>
                            </div>
                        </li>


                        <li class="menu-item search-bar">
                            <form class="search-form" action="search-results.html" method="get"
                                  style="padding: 0 10px;">
                                <input type="text" placeholder="Search..." onclick="openCanvasSearch()"
                                       class="form-control">
                            </form>
                        </li>
                        <li class="menu-item position-relative">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 5px 10px;">Pages<i
                                    class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu submenu-default">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <li class="menu-item position-relative">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 5px 10px;">Blog<i
                                    class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu submenu-default">
                                <!-- Submenu content -->
                            </div>
                        </li>
                    </ul>
                </nav>
            </div>

            <!-- Icons for Account, Wishlist, Cart -->
            <div class="col-xl-5 col-md-4 col-3">
                <ul class="nav-icon d-flex justify-content-end align-items-center gap-20">
                    <!-- Kiểm tra nếu người dùng đã đăng nhập -->
                    <li class="nav-account">
                        <c:choose>
                            <c:when test="${pageContext.request.userPrincipal != null}">
                                <div class="dropdown">
                                    <a href="#" class="nav-icon-item dropdown-toggle" id="userDropdown"
                                       data-bs-toggle="dropdown" aria-expanded="false"
                                       style="font-size: 14px; padding: 3px;">
                                        <i class="icon icon-account"></i>
                                        <span>${pageContext.request.userPrincipal.name}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                        <li><a class="dropdown-item"
                                               href="<c:url value='/profile/${pageContext.request.userPrincipal.name}'/>">Profile</a>
                                        </li>
                                        <li><a class="dropdown-item" href="/orders">My Orders</a></li>
                                        <li><a class="dropdown-item" href="/settings">Settings</a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li><a class="dropdown-item" href="<c:url value='/logout' />">Logout</a></li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="#login" data-bs-toggle="modal" class="nav-icon-item"
                                   style="font-size: 16px; padding: 3px;">
                                    <i class="icon icon-account"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>

                    <!-- Các phần khác: wishlist, cart -->
                    <li class="nav-wishlist">
                        <a href="wishlist.html" class="nav-icon-item" style="font-size: 16px; padding: 3px;">
                            <i class="icon icon-heart"></i><span class="count-box bg-dark"
                                                                 style="font-size: 10px; width: 16px; height: 16px;">0</span>
                        </a>
                    </li>
                    <li class="nav-cart">
                        <a href="#shoppingCart" data-bs-toggle="modal" class="nav-icon-item"
                           style="font-size: 16px; padding: 3px;">
                            <i class="icon icon-bag"></i><span class="count-box bg-dark"
                                                               style="font-size: 10px; width: 16px; height: 16px;">2</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
<!-- /Header -->

<!-- canvasSearch -->
<div class="offcanvas offcanvas-end canvas-search" id="canvasSearch"
     style="width: 100% !important; max-width: 1000px; padding-top: 55px; margin: 0 auto; top: 20px; left: 0; border: 0 !important; transform: none;">
    <div class="canvas-wrapper">
        <header class="tf-search-head">
            <div class="title fw-5">
                Search our site
                <div class="close">
                    <span class="icon-close icon-close-popup" data-bs-dismiss="offcanvas" aria-label="Close"></span>
                </div>
            </div>
            <div class="tf-search-sticky">
                <form class="tf-mini-search-frm">
                    <fieldset class="text">
                        <input type="text" placeholder="Search" class="" name="text" tabindex="0" value=""
                               aria-required="true" required="">
                    </fieldset>
                    <button class="" type="submit"><i class="icon-search"></i></button>
                </form>
            </div>
        </header>
        <div class="canvas-body p-0">
            <div class="tf-search-content">
                <div class="tf-cart-hide-has-results">
                    <div class="tf-col-quicklink">
                        <div class="tf-search-content-title fw-5">Quick link</div>
                        <ul class="tf-quicklink-list">
                            <li class="tf-quicklink-item">
                                <a href="shop-default.html" class="">Fashion</a>
                            </li>
                            <li class="tf-quicklink-item">
                                <a href="shop-default.html" class="">Men</a>
                            </li>
                            <li class="tf-quicklink-item">
                                <a href="shop-default.html" class="">Women</a>
                            </li>
                            <li class="tf-quicklink-item">
                                <a href="shop-default.html" class="">Accessories</a>
                            </li>
                        </ul>
                    </div>
                    <div class="tf-col-content">
                        <div class="tf-search-content-title fw-5">Need some inspiration?</div>
                        <div class="tf-search-hidden-inner">
                            <div class="tf-loop-item">
                                <div class="image">
                                    <a href="product-detail.html">
                                        <img src="/web/images/products/white-3.jpg" alt="">
                                    </a>
                                </div>
                                <div class="content">
                                    <a href="product-detail.html">Cotton jersey top</a>
                                    <div class="tf-product-info-price">
                                        <div class="compare-at-price">$10.00</div>
                                        <div class="price-on-sale fw-6">$8.00</div>
                                    </div>
                                </div>
                            </div>
                            <div class="tf-loop-item">
                                <div class="image">
                                    <a href="product-detail.html">
                                        <img src="/web/images/products/white-2.jpg" alt="">
                                    </a>
                                </div>
                                <div class="content">
                                    <a href="product-detail.html">Mini crossbody bag</a>
                                    <div class="tf-product-info-price">
                                        <div class="price fw-6">$18.00</div>
                                    </div>
                                </div>
                            </div>
                            <div class="tf-loop-item">
                                <div class="image">
                                    <a href="product-detail.html">
                                        <img src="/web/images/products/white-1.jpg" alt="">
                                    </a>
                                </div>
                                <div class="content">
                                    <a href="product-detail.html">Oversized Printed T-shirt</a>
                                    <div class="tf-product-info-price">
                                        <div class="price fw-6">$18.00</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /canvasSearch -->
<!-- modal login -->
<div class="modal modalCentered fade form-sign-in modal-part-content" id="login">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="header">
                <div class="demo-title">Log in</div>
                <span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
            </div>
            <div class="tf-login-form">
                <form class="" action="/login" method="post" accept-charset="utf-8">
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" id="username" name="username"
                               required>
                        <label class="tf-field-label">Username *</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" id="password"
                               name="password" required>
                        <label class="tf-field-label">Password *</label>
                    </div>
                    <div>
                        <a href="#forgotPassword" data-bs-toggle="modal" class="btn-link link">Forgot your password?</a>
                    </div>
                    <div class="bottom">
                        <div class="w-100">
                            <button type="submit"
                                    class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center">
                                <span>Log in</span></button>
                        </div>
                        <div class="w-100">
                            <a href="#register" data-bs-toggle="modal" class="btn-link fw-6 w-100 link">
                                New customer? Create your account
                                <i class="icon icon-arrow1-top-left"></i>
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal modalCentered fade form-sign-in modal-part-content" id="forgotPassword">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="header">
                <div class="demo-title">Reset your password</div>
                <span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
            </div>
            <div class="tf-login-form">
                <form class="">
                    <div>
                        <p>Sign up for early Sale access plus tailored new arrivals, trends and promotions. To opt out,
                            click unsubscribe in our emails</p>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="email" name="">
                        <label class="tf-field-label">Email *</label>
                    </div>
                    <div>
                        <a href="#login" data-bs-toggle="modal" class="btn-link link">Cancel</a>
                    </div>
                    <div class="bottom">
                        <div class="w-100">
                            <button type="submit"
                                    class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center">
                                <span>Reset password</span></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal modalCentered fade form-sign-in modal-part-content" id="register">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="header">
                <div class="demo-title">Register</div>
                <span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
            </div>
            <div class="tf-login-form">
                <form class="">
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" name="">
                        <label class="tf-field-label">First name</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" name="">
                        <label class="tf-field-label">Last name</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="email" name="">
                        <label class="tf-field-label">Email *</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" name="">
                        <label class="tf-field-label">Password *</label>
                    </div>
                    <div class="bottom">
                        <div class="w-100">
                            <a href="register.html"
                               class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center"><span>Register</span></a>
                        </div>
                        <div class="w-100">
                            <a href="#login" data-bs-toggle="modal" class="btn-link fw-6 w-100 link">
                                Already have an account? Log in here
                                <i class="icon icon-arrow1-top-left"></i>
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function openCanvasSearch() {
        const canvasSearch = new bootstrap.Offcanvas(document.getElementById('canvasSearch'));
        canvasSearch.show();
    }
</script>

<script type="text/javascript" src="/web/js/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        // Tải danh sách danh mục từ server
        $.ajax({
            url: '/api/categories',
            method: 'GET',
            dataType: 'json',
            success: function (categories) {
                console.log('Categories:', categories);
                // Hiển thị danh sách danh mục
                categories.forEach(function (category) {
                    $('#category-list').append(' <li class="category-item" data-category-id="' + category.id + '" data-category-slug="' + category.slug + '">' + '<a href="/products/' + category.slug + '">' + category.name + '</a> </li>');
                });
            },
            error: function (xhr, status, error) {
                console.log("Error:", status, error); // In ra lỗi nếu có
            }
        });

        // Xử lý sự kiện khi người dùng click vào danh mục chính
        $(document).on('mouseenter', '.category-item', function () {
            var categoryId = $(this).data("category-id");  // Lấy ID của danh mục chính
            var categoryContent = '';  // Biến chứa nội dung HTML của danh mục con
            var categoryName = $(this).data("category-slug");  // Giả sử bạn có data-category-name trong HTML của danh mục chính

            // Kiểm tra xem phần tử đã được tải danh mục con chưa
            if (!$(this).hasClass('loaded')) {
                // Đánh dấu phần tử đã được xử lý
                $('.category-item').removeClass('loaded'); // Xóa trạng thái "loaded" của tất cả các danh mục
                $(this).addClass('loaded'); // Đánh dấu phần tử này đã được xử lý

                // Ẩn tất cả nội dung cũ
                $('.menu-content').removeClass('active').addClass('hidden');

                // Tải các danh mục con của danh mục chính
                $.ajax({
                    url: '/api/categories/' + categoryId + '/subcategories',
                    method: 'GET',
                    success: function (subcategories) {
                        // Xây dựng nội dung cho danh mục chính
                        categoryContent = '<div class="menu-content" id="category-' + categoryId + '">';
                        categoryContent += '<div class="menu-row">'; // Dòng chứa các danh mục con

                        subcategories.forEach(function (subcategory) {
                            // Tạo một div cho mỗi menu-column (danh mục con)
                            var subcategoryContent = '<div class="menu-column">';
                            subcategoryContent += '<h4>' + subcategory.name + '</h4>';

                            // Tải các giá trị thuộc tính của danh mục con
                            $.ajax({
                                url: '/api/subcategories/' + subcategory.id + '/subcategory-values',
                                method: 'GET',
                                dataType: 'json',
                                success: function (subcategoryValue) {
                                    var subcategoryValueContent = '<ul>';
                                    subcategoryValue.forEach(function (value) {
                                        // Tạo URL theo cấu trúc /danh-muc/slug
                                        var subcategorySlug = value.slug;  // Giả sử mỗi value có slug
                                        var categorySlug = categoryName;

                                        // Tạo đường dẫn mới với danh mục và slug
                                        var link = '/' + categorySlug + '/' + subcategorySlug;

                                        subcategoryValueContent += '<li><a href="' + link + '">' + value.value + '</a></li>';
                                    });
                                    subcategoryValueContent += '</ul>';

                                    // Thêm giá trị thuộc tính vào nội dung của danh mục con
                                    subcategoryContent += subcategoryValueContent;
                                    subcategoryContent += '</div>'; // Đóng div của menu-column

                                    // Thêm nội dung của danh mục con vào danh mục chính
                                    categoryContent += subcategoryContent;

                                    // Khi tất cả dữ liệu đã được tải và xử lý xong, cập nhật giao diện
                                    $('#category-content').html(categoryContent).removeClass('hidden').addClass('active');
                                },
                                error: function (xhr, status, error) {
                                    console.log("Error fetching attribute values:", status, error);
                                }
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        console.log("Error fetching subcategories:", status, error);
                    }
                });
            }
        });




// Hiển thị danh mục khi người dùng nhấn vào
//         $(document).on('mouseenter', '.category-item', function () {
//             var categoryId = $(this).data("category-id");  // Lấy ID của danh mục
//             var categoryContentId = '#category-' + categoryId;
//
//             // Ẩn tất cả các nội dung cũ
//             $('.menu-content').removeClass('active');
//             $(categoryContentId).addClass('active'); // Hiển thị danh mục tương ứng
//         });
    });

</script>

<!-- /modal login -->

<script>document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('inp$earch');
    const closeButton = document.getElementById('btn-close-search');
    const searchAutocomplete = document.getElementById('search_autocomplete');
    // Ngăn chặn form khi bấm submit nếu cần (ví dụ không có giá trị nhập vào)
    document.querySelector('.search-form').addEventListener('submit', function (event) {
        if (searchInput.value.trim() === '') {
            event.preventDefault();
        }
    });
});
</script>

