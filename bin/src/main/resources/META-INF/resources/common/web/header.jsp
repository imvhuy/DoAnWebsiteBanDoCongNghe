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
<header id="header" class="header-tech">
    <div class="px_15 lg-px_40">
        <div class="row wrapper-header align-items-center">
            <!-- Icon menu mobile -->
            <div class="col-md-4 col-3 tf-lg-hidden">
                <a href="#mobileMenu" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="16" viewBox="0 0 24 16"
                         fill="none">
                        <path
                                d="M2.00056 2.28571H16.8577C17.1608 2.28571 17.4515 2.16531 17.6658 1.95098C17.8802 1.73665 18.0006 1.44596 18.0006 1.14286C18.0006 0.839753 17.8802 0.549063 17.6658 0.334735C17.4515 0.120408 17.1608 0 16.8577 0H2.00056C1.69745 0 1.40676 0.120408 1.19244 0.334735C0.978109 0.549063 0.857702 0.839753 0.857702 1.14286C0.857702 1.44596 0.978109 1.73665 1.19244 1.95098C1.40676 2.16531 1.69745 2.28571 2.00056 2.28571ZM0.857702 8C0.857702 7.6969 0.978109 7.40621 1.19244 7.19188C1.40676 6.97755 1.69745 6.85714 2.00056 6.85714H22.572C22.8751 6.85714 23.1658 6.97755 23.3801 7.19188C23.5944 7.40621 23.7148 7.6969 23.7148 8C23.7148 8.30311 23.5944 8.59379 23.3801 8.80812C23.1658 9.02245 22.8751 9.14286 22.572 9.14286H2.00056C1.69745 9.14286 1.40676 9.02245 1.19244 8.80812C0.978109 8.59379 0.857702 8.30311 0.857702 8ZM0.857702 14.8571C0.857702 14.554 0.978109 14.2633 1.19244 14.049C1.40676 13.8347 1.69745 13.7143 2.00056 13.7143H12.2863C12.5894 13.7143 12.8801 13.8347 13.0944 14.049C13.3087 14.2633 13.4291 14.554 13.4291 14.8571C13.4291 15.1602 13.3087 15.4509 13.0944 15.6653C12.8801 15.8796 12.5894 16 12.2863 16H2.00056C1.69745 16 1.40676 15.8796 1.19244 15.6653C0.978109 15.4509 0.857702 15.1602 0.857702 14.8571Z"
                                fill="currentColor"></path>
                    </svg>
                </a>
            </div>
            <!-- Logo của cửa hàng -->
            <div class="col-xl-3 col-md-4 col-6">
                <a href="<c:url value='home'/>" class="logo-header">
                    <img src="images/logo/logo.jpg" alt="Tech Store Logo" class="logo">
                </a>
            </div>
            <!-- Navigation chính -->
            <div class="col-xl-6 tf-md-hidden">
                <nav class="box-navigation text-center">
                    <ul class="box-nav-ul d-flex align-items-center justify-content-center gap-30">
                        <!-- Danh mục sản phẩm -->
                        <li class="menu-item">
                            <a href="#" class="item-link">Danh mục<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <div class="container">
                                    <div class="row-demo">
                                        <div class="demo-item">
                                            <a href="phones.html">
                                                <span class="demo-name">Điện thoại</span>
                                            </a>
                                        </div>
                                        <div class="demo-item">
                                            <a href="laptops.html">
                                                <span class="demo-name">Laptop</span>
                                            </a>
                                        </div>
                                        <div class="demo-item">
                                            <a href="smart-devices.html">
                                                <span class="demo-name">Thiết bị thông minh</span>
                                            </a>
                                        </div>
                                        <div class="demo-item">
                                            <a href="accessories.html">
                                                <span class="demo-name">Phụ kiện</span>
                                            </a>
                                        </div>
                                        <div class="demo-item">
                                            <a href="gaming.html">
                                                <span class="demo-name">Gaming</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="menu-item"><a href="new-arrivals.html" class="item-link">Hàng mới về</a></li>
                        <form class="search-form">
                            <div class="cps-group-input is-flex align-items-center">
                                <!-- Ô nhập liệu tìm kiếm -->
                                <input id="inp$earch" type="text" placeholder="Bạn cần tìm gì?"
                                       autocomplete="off" value="" class="cps-input form-control">
                                <!-- Button tìm kiếm -->
                                <div class="input-group-btn">
                                    <button type="submit"
                                            class="border-0 shadow-none text-dark d-flex align-items-center">
                                        <svg height="15" aria-hidden="true" focusable="false" data-prefix="fas"
                                             data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg"
                                             viewBox="0 0 512 512" class="svg-inline--fa fa-search">
                                            <path fill="currentColor"
                                                  d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z">
                                            </path>
                                        </svg>
                                    </button>
                                </div>
                                <!-- Nút xóa nhanh (hiển thị khi có văn bản trong ô tìm kiếm) -->
                                <span id="btn-close-search" style="display:none; cursor: pointer;">X</span>
                                <!-- Tự động hoàn thành tìm kiếm -->
                                <div id="search_autocomplete"
                                     class="box-search-result search-autocomplete is-hidden">
                                    <div class="category-box is-hidden">
                                        <p class="title-box">Có phải bạn muốn tìm</p>
                                        <div class="list-cate"></div>
                                    </div>
                                    <div class="product-box mt-2">
                                        <p class="title-box">Sản phẩm gợi ý</p>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <li class="menu-item"><a href="deals.html" class="item-link">Khuyến mãi</a></li>
                        <li class="menu-item"><a href="bestsellers.html" class="item-link">Bán chạy</a></li>


                    </ul>
                </nav>
            </div>
            <!-- Icons tìm kiếm, tài khoản, wishlist và giỏ hàng -->
            <div class="col-xl-3 col-md-4 col-3">
                <ul class="nav-icon d-flex justify-content-end align-items-center gap-20">
                    <li class="nav-account">
                        <a href="#login" data-bs-toggle="modal"
                           class="nav-icon-item d-flex flex-column align-items-center">
                            <i class="icon icon-account"></i>
                            <span class="icon-label">Tài khoản</span>
                        </a>
                    </li>
                    <li class="nav-wishlist">
                        <a href="wishlist.html" class="nav-icon-item d-flex flex-column align-items-center">
                            <i class="icon icon-heart"></i>
                            <span class="count-box text-black">0</span>
                            <span class="icon-label">Yêu thích</span>
                        </a>
                    </li>
                    <li class="nav-cart">
                        <a href="#shoppingCart" data-bs-toggle="modal"
                           class="nav-icon-item d-flex flex-column align-items-center">
                            <i class="icon icon-bag"></i>
                            <span class="count-box text-black">0</span>
                            <span class="icon-label">Giỏ hàng</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
<!-- /Header -->

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

