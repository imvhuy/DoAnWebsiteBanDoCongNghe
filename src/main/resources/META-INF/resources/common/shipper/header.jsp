
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
</div>
<!-- /Top bar -->
<!-- Header -->
<header id="header" class="header-default">
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
    /* Căn chỉnh menu con theo chiều ngang */
    .horizontal-menu {
        display: flex; /* Hiển thị các mục theo chiều ngang */
        gap: 15px; /* Tạo khoảng cách giữa các mục */
        list-style: none; /* Loại bỏ dấu chấm của danh sách */
        padding: 0;
        margin: 0;
    }

    .horizontal-menu li {
        display: inline-block; /* Đảm bảo mỗi mục là một khối ngang */
    }

    .horizontal-menu li a {
        text-decoration: none; /* Bỏ gạch chân */
        font-size: 14px;
        color: #000; /* Màu chữ */
        padding: 5px 10px;
        transition: all 0.3s ease;
    }

    .horizontal-menu li a:hover {
        color: #007bff; /* Màu khi hover */
        text-decoration: underline;
    }
    .item-link {
        display: inline-flex; /* Hiển thị nội dung theo chiều ngang */
        align-items: center; /* Căn giữa chữ và icon */
        white-space: nowrap; /* Không cho chữ xuống dòng */
        text-decoration: none; /* Xóa gạch chân */
        gap: 5px; /* Khoảng cách giữa chữ và icon */
        color: #000; /* Màu chữ (có thể chỉnh nếu cần) */
    }

    .item-link i {
        font-size: 12px; /* Kích thước icon */
    }



    </style>
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
                        <path d="M2.00056 2.28571H16.8577C17.1608 2.28571 17.4515 2.16531 17.6658 1.95098C17.8802 1.73665 18.0006 1.44596 18.0006 1.14286C18.0006 0.839753 17.8802 0.549063 17.6658 0.334735C17.4515 0.120408 17.1608 0 16.8577 0H2.00056C1.69745 0 1.40676 0.120408 1.19244 0.334735C0.978109 0.549063 0.857702 0.839753 0.857702 1.14286C0.857702 1.44596 0.978109 1.73665 1.19244 1.95098C1.40676 2.16531 1.69745 2.28571 2.00056 2.28571ZM0.857702 8C0.857702 7.6969 0.978109 7.40621 1.19244 7.19188C1.40676 6.97755 1.69745 6.85714 2.00056 6.85714H22.572C22.8751 6.85714 23.1658 6.97755 23.3801 7.19188C23.5944 7.40621 23.7148 7.6969 23.7148 8C23.7148 8.30311 23.5944 8.59379 23.3801 8.80812C23.1658 9.02245 22.8751 9.14286 22.572 9.14286H2.00056C1.69745 9.14286 1.40676 9.02245 1.19244 8.80812C0.978109 8.59379 0.857702 8.30311 0.857702 8ZM0.857702 14.8571C0.857702 14.554 0.978109 14.2633 1.19244 14.049C1.40676 13.8347 1.69745 13.7143 2.00056 13.7143H12.2863C12.5894 13.7143 12.8801 13.8347 13.0944 14.049C13.3087 14.2633 13.4291 14.554 13.4291 14.8571C13.4291 15.1602 13.3087 15.4509 13.0944 15.6653C12.8801 15.8796 12.5894 16 12.2863 16H2.00056C1.69745 16 1.40676 15.8796 1.19244 15.6653C0.978109 15.4509 0.857702 15.1602 0.857702 14.8571Z" fill="currentColor"></path>
                    </svg>
                </a>
            </div>

            <!-- Navigation Menu -->
            <div class="col-xl-5 tf-md-hidden">
                <nav class="box-navigation text-center">
                    <ul class="box-nav-ul d-flex align-items-center gap-30">
                        <!-- Quản lý đơn hàng -->
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 10px 15px;">Assigned Orders<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <ul class="horizontal-menu">
                                    <li><a href="<c:url value='/shipper/orders'/>">Assigned Orders List</a></li>
                                </ul>
                            </div>
                        </li>

                        <!-- Thống kê và báo cáo -->
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 10px 15px;">Statistics & Reporting<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <ul class="horizontal-menu">
                                    <li><a href="<c:url value='/shipper/statistics' />">Order Status Statistics</a></li>
                                </ul>
                            </div>
                        </li>

                        <!-- Hỗ trợ và tìm kiếm -->
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 10px 15px;">Support & Search<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <ul class="horizontal-menu">
                                    <li><a href="#">New Order Notifications</a></li>
                                </ul>
                            </div>
                        </li>

                        <!-- Lịch sử và đánh giá -->
                        <li class="menu-item">
                            <a href="#" class="item-link" style="font-size: 14px; padding: 10px 15px;">History & Feedback<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <ul class="horizontal-menu">
                                    <li><a href="<c:url value='/shipper/orders/completed' />">Delivery History</a></li>
                                    <li><a href="#">Ratings & Feedback</a></li>
                                </ul>
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
                                    <a href="#" class="nav-icon-item dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 14px; padding: 3px;">
                                        <i class="icon icon-account"></i>
                                        <span>${pageContext.request.userPrincipal.name}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                        <li><a class="dropdown-item" href="/profile">Profile</a></li>
                                        <li><a class="dropdown-item" href="/orders">My Orders</a></li>
                                        <li><a class="dropdown-item" href="/settings">Settings</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="<c:url value='/logout' />">Logout</a></li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="#login" data-bs-toggle="modal" class="nav-icon-item" style="font-size: 16px; padding: 3px;">
                                    <i class="icon icon-account"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>

                    <!-- Các phần khác: wishlist, cart -->
                    <li class="nav-wishlist">
                        <a href="wishlist.html" class="nav-icon-item" style="font-size: 16px; padding: 3px;">
                            <i class="icon icon-heart"></i><span class="count-box bg-dark" style="font-size: 10px; width: 16px; height: 16px;">0</span>
                        </a>
                    </li>
                    <li class="nav-cart">
                        <a href="#shoppingCart" data-bs-toggle="modal" class="nav-icon-item" style="font-size: 16px; padding: 3px;">
                            <i class="icon icon-bag"></i><span class="count-box bg-dark" style="font-size: 10px; width: 16px; height: 16px;">2</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>


</header>
<!-- /Header -->

<!-- canvasSearch -->
<div class="offcanvas offcanvas-end canvas-search" id="canvasSearch" style="width: 100% !important; max-width: 1000px; padding-top: 55px; margin: 0 auto; top: 20px; left: 0; border: 0 !important; transform: none;">
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
                        <input type="text" placeholder="Search" class="" name="text" tabindex="0" value="" aria-required="true" required="">
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


<script>
    function openCanvasSearch() {
        const canvasSearch = new bootstrap.Offcanvas(document.getElementById('canvasSearch'));
        canvasSearch.show();
    }
</script>

<!-- modal login -->
<div class="modal modalCentered fade form-sign-in modal-part-content" id="login">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="header">
                <div class="demo-title">Log in</div>
                <span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
            </div>
            <div class="tf-login-form">
                <form class="" action="/login" method="post"  accept-charset="utf-8">
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" id="username" name="username" required>
                        <label class="tf-field-label">Username *</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" id= "password" name="password" required>
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
<!-- /modal login -->

<%--<script>document.addEventListener('DOMContentLoaded', function () {--%>
<%--    const searchInput = document.getElementById('inp$earch');--%>
<%--    const closeButton = document.getElementById('btn-close-search');--%>
<%--    const searchAutocomplete = document.getElementById('search_autocomplete');--%>

<%--    // Hiển thị nút xóa khi người dùng nhập văn bản--%>
<%--    searchInput.addEventListener('input', function () {--%>
<%--        if (searchInput.value.trim() !== '') {--%>
<%--            closeButton.style.display = 'inline';--%>
<%--            searchAutocomplete.classList.remove('is-hidden');--%>
<%--        } else {--%>
<%--            closeButton.style.display = 'none';--%>
<%--            searchAutocomplete.classList.add('is-hidden');--%>
<%--        }--%>
<%--    });--%>

<%--    // Xóa văn bản khi nhấn vào nút xóa--%>
<%--    closeButton.addEventListener('click', function () {--%>
<%--        searchInput.value = '';--%>
<%--        closeButton.style.display = 'none';--%>
<%--        searchAutocomplete.classList.add('is-hidden');--%>
<%--    });--%>

<%--    // Ẩn gợi ý tìm kiếm khi nhấp ra ngoài ô tìm kiếm--%>
<%--    document.addEventListener('click', function (event) {--%>
<%--        if (!event.target.closest('.search-form')) {--%>
<%--            searchAutocomplete.classList.add('is-hidden');--%>
<%--        }--%>
<%--    });--%>

<%--    // Ngăn chặn form khi bấm submit nếu cần (ví dụ không có giá trị nhập vào)--%>
<%--    document.querySelector('.search-form').addEventListener('submit', function (event) {--%>
<%--        if (searchInput.value.trim() === '') {--%>
<%--            event.preventDefault();--%>
<%--        }--%>
<%--    });--%>
<%--});--%>
<%--</script>--%>

