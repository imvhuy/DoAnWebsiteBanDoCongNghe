<%@ page contentType="text/html; charset=UTF-8" %>
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
    </style>
    <div class="px_15 lg-px_40">
        <div class="row wrapper-header align-items-center">
            <div class="col-xl-2 col-md-4 col-6 text-center">
                <a href="index.html" class="logo-header">
                    <img src="/web/images/logo/logo.jpg" alt="logo" class="logo">
                </a>
            </div>
            <div class="col-md-4 col-3 tf-lg-hidden">
                <a href="#mobileMenu" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft">
                    <!-- SVG icon for mobile menu -->
                </a>
            </div>
            <div class="col-xl-5 tf-md-hidden">
                <nav class="box-navigation text-center">
                    <ul class="box-nav-ul d-flex align-items-center gap-30">
                        <!-- Home menu item -->
                        <li class="menu-item">
                            <a href="#" class="item-link">Home<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <!-- Shop menu item -->
                        <li class="menu-item">
                            <a href="#" class="item-link">Shop<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <!-- Products menu item -->
                        <li class="menu-item">
                            <a href="#" class="item-link">Products<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <!-- Search bar in the middle of the menu -->
                        <li class="menu-item search-bar">
                            <form class="search-form" action="search-results.html" method="get">
                                <!-- Search button in the header menu -->
                                <li class="menu-item search-bar">
                                    <form class="search-form" onsubmit="event.preventDefault(); openCanvasSearch();">
                                        <input type="text" placeholder="Search..." onclick="openCanvasSearch()" class="form-control">
                                    </form>
                                </li>
                            </form>
                        </li>
                        <!-- Pages menu item -->
                        <li class="menu-item position-relative">
                            <a href="#" class="item-link">Pages<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu submenu-default">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <!-- Blog menu item -->
                        <li class="menu-item position-relative">
                            <a href="#" class="item-link">Blog<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu submenu-default">
                                <!-- Submenu content -->
                            </div>
                        </li>
                        <!-- Buy now menu item -->
                        <li class="menu-item">
                            <a href="https://themeforest.net/item/ecomus-ultimate-html5-template/53417990?s_rank=3" class="item-link">Buy now</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <div class="col-xl-5 col-md-4 col-3">
                <ul class="nav-icon d-flex justify-content-end align-items-center gap-20">
                    <li class="nav-account"><a href="#login" data-bs-toggle="modal" class="nav-icon-item"><i class="icon icon-account"></i></a></li>
                    <li class="nav-compare"><a href="compare.html" class="nav-icon-item"><i class="icon icon-compare"></i></a></li>
                    <li class="nav-wishlist"><a href="wishlist.html" class="nav-icon-item"><i class="icon icon-heart"></i><span class="count-box bg-dark">0</span></a></li>
                    <li class="nav-cart"><a href="#shoppingCart" data-bs-toggle="modal" class="nav-icon-item"><i class="icon icon-bag"></i><span class="count-box bg-dark">2</span></a></li>
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
                                        <img src="images/products/white-3.jpg" alt="">
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
                                        <img src="images/products/white-2.jpg" alt="">
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
                                        <img src="images/products/white-1.jpg" alt="">
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
                <form class="" action="https://themesflat.co/html/ecomus/my-account.html" accept-charset="utf-8">
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="email" name="">
                        <label class="tf-field-label">Email *</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" name="">
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

<script>document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('inp$earch');
    const closeButton = document.getElementById('btn-close-search');
    const searchAutocomplete = document.getElementById('search_autocomplete');

    // Hiển thị nút xóa khi người dùng nhập văn bản
    searchInput.addEventListener('input', function () {
        if (searchInput.value.trim() !== '') {
            closeButton.style.display = 'inline';
            searchAutocomplete.classList.remove('is-hidden');
        } else {
            closeButton.style.display = 'none';
            searchAutocomplete.classList.add('is-hidden');
        }
    });

    // Xóa văn bản khi nhấn vào nút xóa
    closeButton.addEventListener('click', function () {
        searchInput.value = '';
        closeButton.style.display = 'none';
        searchAutocomplete.classList.add('is-hidden');
    });

    // Ẩn gợi ý tìm kiếm khi nhấp ra ngoài ô tìm kiếm
    document.addEventListener('click', function (event) {
        if (!event.target.closest('.search-form')) {
            searchAutocomplete.classList.add('is-hidden');
        }
    });

    // Ngăn chặn form khi bấm submit nếu cần (ví dụ không có giá trị nhập vào)
    document.querySelector('.search-form').addEventListener('submit', function (event) {
        if (searchInput.value.trim() === '') {
            event.preventDefault();
        }
    });
});
</script>

