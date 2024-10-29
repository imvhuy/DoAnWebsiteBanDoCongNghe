<%@ page contentType="text/html; charset=UTF-8" %>

<!-- Top bar -->
<div class="tf-top-bar bg_dark line">
    <div class="px_15 lg-px_40">
        <div class="tf-top-bar_wrap grid-3 gap-30 align-items-center">
            <div class="tf-top-bar_left">
                <div class="d-flex gap-30 text_white fw-5 ">
                    <span>(+333) 123-1688</span>
                    <span>sayhello@ecomus.com</span>
                </div>
            </div>
            <div class="text-center overflow-hidden">
                <div class="swiper tf-sw-top_bar" data-preview="1" data-space="0" data-loop="true" data-speed="1000" data-delay="2000">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <p class="top-bar-text fw-5 text_white">Season Sale: Time to refresh your wardrobe. <a href="shop-default.html" title="all collection" class="tf-btn btn-line">Shop now<i class="icon icon-arrow1-top-left"></i></a></p>
                        </div>
                        <div class="swiper-slide">
                            <p class="top-bar-text fw-5 text_white">Discount off 50%. <a href="shop-default.html" title="all collection" class="tf-btn btn-line">Shop now<i class="icon icon-arrow1-top-left"></i></a></p>
                        </div>
                        <div class="swiper-slide">
                            <p class="top-bar-text fw-5 text_white">Welcome to store. Fantastic theme! Beautifully designed</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="top-bar-language tf-cur justify-content-end">
                <div class="tf-currencies">
                    <select class="image-select center style-default type-currencies color-white">
                        <option data-thumbnail="images/country/fr.svg">EUR <span>€ | France</span></option>
                        <option data-thumbnail="images/country/de.svg">EUR <span>€ | Germany</span></option>
                        <option selected data-thumbnail="images/country/us.svg">USD <span>$ | United States</span></option>
                        <option data-thumbnail="images/country/vn.svg">VND <span>₫ | Vietnam</span></option>
                    </select>
                </div>
                <div class="tf-languages">
                    <select class="image-select center style-default type-languages color-white">
                        <option>English</option>
                        <option>العربية</option>
                        <option>简体中文</option>
                        <option>اردو</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /Top bar -->
<!-- Header -->
<header id="header" class="header-default">
    <div class="px_15 lg-px_40">
        <div class="row wrapper-header align-items-center">
            <div class="col-md-4 col-3 tf-lg-hidden">
                <a href="#mobileMenu" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="16" viewBox="0 0 24 16" fill="none">
                        <path d="M2.00056 2.28571H16.8577C17.1608 2.28571 17.4515 2.16531 17.6658 1.95098C17.8802 1.73665 18.0006 1.44596 18.0006 1.14286C18.0006 0.839753 17.8802 0.549063 17.6658 0.334735C17.4515 0.120408 17.1608 0 16.8577 0H2.00056C1.69745 0 1.40676 0.120408 1.19244 0.334735C0.978109 0.549063 0.857702 0.839753 0.857702 1.14286C0.857702 1.44596 0.978109 1.73665 1.19244 1.95098C1.40676 2.16531 1.69745 2.28571 2.00056 2.28571ZM0.857702 8C0.857702 7.6969 0.978109 7.40621 1.19244 7.19188C1.40676 6.97755 1.69745 6.85714 2.00056 6.85714H22.572C22.8751 6.85714 23.1658 6.97755 23.3801 7.19188C23.5944 7.40621 23.7148 7.6969 23.7148 8C23.7148 8.30311 23.5944 8.59379 23.3801 8.80812C23.1658 9.02245 22.8751 9.14286 22.572 9.14286H2.00056C1.69745 9.14286 1.40676 9.02245 1.19244 8.80812C0.978109 8.59379 0.857702 8.30311 0.857702 8ZM0.857702 14.8571C0.857702 14.554 0.978109 14.2633 1.19244 14.049C1.40676 13.8347 1.69745 13.7143 2.00056 13.7143H12.2863C12.5894 13.7143 12.8801 13.8347 13.0944 14.049C13.3087 14.2633 13.4291 14.554 13.4291 14.8571C13.4291 15.1602 13.3087 15.4509 13.0944 15.6653C12.8801 15.8796 12.5894 16 12.2863 16H2.00056C1.69745 16 1.40676 15.8796 1.19244 15.6653C0.978109 15.4509 0.857702 15.1602 0.857702 14.8571Z" fill="currentColor"></path>
                    </svg>
                </a>
            </div>
            <div class="col-xl-3 col-md-4 col-6">
                <a href="index.html" class="logo-header">
                    <img src="images/logo/logo.svg" alt="logo" class="logo">
                </a>
            </div>
            <div class="col-xl-6 tf-md-hidden">
                <nav class="box-navigation text-center">
                    <ul class="box-nav-ul d-flex align-items-center justify-content-center gap-30">
                        <li class="menu-item">
                            <a href="#" class="item-link">Home<i class="icon icon-arrow-down"></i></a>
                            <div class="sub-menu mega-menu">
                                <div class="container">
                                    <div class="row-demo">
                                        <div class="demo-item">
                                            <a href="index.html">
                                                <div class="demo-image position-relative">
                                                    <img class="lazyload" data-src="images/demo/home-01.jpg" src="images/demo/home-01.jpg" alt="home-01">
                                                    <div class="demo-label">
                                                        <span class="demo-new">New</span>
                                                        <span>Trend</span>
                                                    </div>
                                                </div>
                                                <span class="demo-name">Home Fashion 01</span>
                                            </a>
                                        </div>
                                        <div class="demo-item">
                                            <a href="home-multi-brand.html">
                                                <div class="demo-image position-relative">
                                                    <img class="lazyload" data-src="images/demo/home-multi-brand.jpg" src="images/demo/home-multi-brand.jpg" alt="home-multi-brand">
                                                    <div class="demo-label">
                                                        <span class="demo-new">New</span>
                                                        <span class="demo-hot">Hot</span>
                                                    </div>
                                                </div>
                                                <span class="demo-name">Home Multi Brand</span>
                                            </a>
                                        </div>
                                        <li class="menu-item">
                                            <a href="#" class="item-link">Shop<i class="icon icon-arrow-down"></i></a>
                                            <div class="sub-menu mega-menu">
                                                <div class="container">
                                                    <div class="row">
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Shop layouts</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="shop-default.html" class="menu-link-text link">Default</a></li>
                                                                    <li><a href="shop-left-sidebar.html" class="menu-link-text link">Left sidebar</a></li>
                                                                    <li><a href="shop-right-sidebar.html" class="menu-link-text link">Right sidebar</a></li>
                                                                    <li><a href="shop-fullwidth.html" class="menu-link-text link">Fullwidth</a></li>
                                                                    <li><a href="shop-collection-sub.html" class="menu-link-text link">Sub collection</a></li>
                                                                    <li><a href="shop-collection-list.html" class="menu-link-text link">Collections list</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Features</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="shop-link.html" class="menu-link-text link">Pagination links</a></li>
                                                                    <li><a href="shop-loadmore.html" class="menu-link-text link">Pagination loadmore</a></li>
                                                                    <li><a href="shop-infinite-scrolling.html" class="menu-link-text link">Pagination infinite scrolling</a></li>
                                                                    <li><a href="shop-filter-sidebar.html" class="menu-link-text link">Filter sidebar</a></li>
                                                                    <li><a href="shop-filter-hidden.html" class="menu-link-text link">Filter hidden</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Product styles</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="product-style-list.html" class="menu-link-text link">Product style list</a></li>
                                                                    <li><a href="product-style-01.html" class="menu-link-text link">Product style 01</a></li>
                                                                    <li><a href="product-style-02.html" class="menu-link-text link">Product style 02</a></li>
                                                                    <li><a href="product-style-03.html" class="menu-link-text link">Product style 03</a></li>
                                                                    <li><a href="product-style-04.html" class="menu-link-text link">Product style 04</a></li>
                                                                    <li><a href="product-style-05.html" class="menu-link-text link">Product style 05</a></li>
                                                                    <li><a href="product-style-06.html" class="menu-link-text link">Product style 06</a></li>
                                                                    <li><a href="product-style-07.html" class="menu-link-text link">Product style 07</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="menu-item">
                                            <a href="#" class="item-link">Products<i class="icon icon-arrow-down"></i></a>
                                            <div class="sub-menu mega-menu">
                                                <div class="container">
                                                    <div class="row">
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Product layouts</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="product-detail.html" class="menu-link-text link">Product default</a></li>
                                                                    <li><a href="product-grid-1.html" class="menu-link-text link">Product grid 1</a></li>
                                                                    <li><a href="product-grid-2.html" class="menu-link-text link">Product grid 2</a></li>
                                                                    <li><a href="product-stacked.html" class="menu-link-text link">Product stacked</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Product details</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="product-inner-zoom.html" class="menu-link-text link">Product inner zoom</a></li>
                                                                    <li><a href="product-zoom-magnifier.html" class="menu-link-text link">Product zoom magnifier</a></li>
                                                                    <li><a href="product-no-zoom.html" class="menu-link-text link">Product no zoom</a></li>
                                                                    <li><a href="product-photoswipe-popup.html" class="menu-link-text link">Product photoswipe popup</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Product swatchs</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="product-color-swatch.html" class="menu-link-text link">Product color swatch</a></li>
                                                                    <li><a href="product-rectangle.html" class="menu-link-text link">Product rectangle</a></li>
                                                                    <li><a href="product-rectangle-color.html" class="menu-link-text link">Product rectangle color</a></li>
                                                                    <li><a href="product-swatch-image.html" class="menu-link-text link">Product swatch image</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="mega-menu-item">
                                                                <div class="menu-heading">Product features</div>
                                                                <ul class="menu-list">
                                                                    <li><a href="product-frequently-bought-together.html" class="menu-link-text link">Frequently bought together</a></li>
                                                                    <li><a href="product-frequently-bought-together-2.html" class="menu-link-text link">Frequently bought together 2</a></li>
                                                                    <li><a href="product-upsell-features.html" class="menu-link-text link">Product upsell features</a></li>
                                                                    <li><a href="product-pre-orders.html" class="menu-link-text link">Product pre-orders</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="menu-item position-relative">
                                            <a href="#" class="item-link">Pages<i class="icon icon-arrow-down"></i></a>
                                            <div class="sub-menu submenu-default">
                                                <ul class="menu-list">
                                                    <li><a href="about-us.html" class="menu-link-text link text_black-2">About us</a></li>
                                                    <li>
                                                        <a href="brands.html" class="menu-link-text link text_black-2 position-relative">Brands
                                                            <div class="demo-label"><span class="demo-new">New</span></div>
                                                        </a>
                                                    </li>
                                                    <li><a href="brands-v2.html" class="menu-link-text link text_black-2">Brand V2</a></li>
                                                    <li><a href="contact-1.html" class="menu-link-text link text_black-2">Contact 1</a></li>
                                                    <li><a href="contact-2.html" class="menu-link-text link text_black-2">Contact 2</a></li>
                                                    <li><a href="faq-1.html" class="menu-link-text link text_black-2">FAQ 01</a></li>
                                                    <li><a href="faq-2.html" class="menu-link-text link text_black-2">FAQ 02</a></li>
                                                    <li><a href="our-store.html" class="menu-link-text link text_black-2">Our store</a></li>
                                                    <li><a href="store-locations.html" class="menu-link-text link text_black-2">Store locator</a></li>
                                                    <li><a href="timeline.html" class="menu-link-text link text_black-2 position-relative">Timeline <div class="demo-label"><span class="demo-new">New</span></div> </a></li>
                                                    <li><a href="view-cart.html" class="menu-link-text link text_black-2 position-relative">View cart</a></li>
                                                    <li><a href="checkout.html" class="menu-link-text link text_black-2 position-relative">Check out</a></li>
                                                    <li><a href="payment-confirmation.html" class="menu-link-text link text_black-2 position-relative">Payment Confirmation</a></li>
                                                    <li><a href="payment-failure.html" class="menu-link-text link text_black-2 position-relative">Payment Failure</a></li>
                                                    <li><a href="my-account.html" class="menu-link-text link text_black-2 position-relative">My Account</a></li>
                                                </ul>
                                            </div>
                                        </li>
                    </ul>
                </nav>
            </div>
            <div class="col-xl-3 col-md-4 col-3">
                <ul class="nav-icon d-flex justify-content-end align-items-center gap-20">
                    <li class="nav-search"><a href="#canvasSearch" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft" class="nav-icon-item"><i class="icon icon-search"></i></a></li>
                    <li class="nav-account"><a href="#login" data-bs-toggle="modal" class="nav-icon-item"><i class="icon icon-account"></i></a></li>
                    <li class="nav-wishlist"><a href="wishlist.html" class="nav-icon-item"><i class="icon icon-heart"></i><span class="count-box text-black">0</span></a></li>
                    <li class="nav-cart"><a href="#shoppingCart" data-bs-toggle="modal" class="nav-icon-item"><i class="icon icon-bag"></i><span class="count-box text-black">0</span></a></li>
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
                        <input class="tf-field-input tf-input" placeholder=" " type="email"  name="">
                        <label class="tf-field-label" >Email *</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="password"  name="">
                        <label class="tf-field-label" >Password *</label>
                    </div>
                    <div>
                        <a href="#forgotPassword" data-bs-toggle="modal" class="btn-link link">Forgot your password?</a>
                    </div>
                    <div class="bottom">
                        <div class="w-100">
                            <button type="submit" class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center"><span>Log in</span></button>
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
                        <p>Sign up for early Sale access plus tailored new arrivals, trends and promotions. To opt out, click unsubscribe in our emails</p>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="email"  name="">
                        <label class="tf-field-label" >Email *</label>
                    </div>
                    <div>
                        <a href="#login" data-bs-toggle="modal" class="btn-link link">Cancel</a>
                    </div>
                    <div class="bottom">
                        <div class="w-100">
                            <button type="submit" class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center"><span>Reset password</span></button>
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
                        <input class="tf-field-input tf-input" placeholder=" " type="text"  name="">
                        <label class="tf-field-label" >First name</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="text"  name="">
                        <label class="tf-field-label" >Last name</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="email"  name="">
                        <label class="tf-field-label">Email *</label>
                    </div>
                    <div class="tf-field style-1">
                        <input class="tf-field-input tf-input" placeholder=" " type="password"  name="">
                        <label class="tf-field-label">Password *</label>
                    </div>
                    <div class="bottom">
                        <div class="w-100">
                            <a href="register.html" class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center"><span>Register</span></a>
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