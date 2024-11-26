
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>UTE Tech</title>

    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- font -->
    <link rel="stylesheet" href="/web/fonts/fonts.css">
    <!-- Icons -->
    <link rel="stylesheet" href="/web/fonts/font-icons.css">
    <link rel="stylesheet" href="/web/css/bootstrap.min.css">
    <link rel="stylesheet" href="/web/css/swiper-bundle.min.css">
    <link rel="stylesheet" href="/web/css/animate.css">
    <link rel="stylesheet" type="text/css" href="/web/css/styles.css"/>

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="/web/images/logo/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="/web/images/logo/favicon.png">

</head>
<body>
<!-- Modal Thông Báo -->
<div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <!-- Header với nền trắng và chữ đen -->
            <div class="modal-header" style="background-color: white; color: black; font-size: 1.5rem;">
                <h5 class="modal-title" id="messageModalLabel">Notify</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(0);"></button>
            </div>

            <!-- Nội dung thông báo với chữ đen trên nền trắng -->
            <div class="modal-body" style="background-color: white; color: black; font-size: 1.2rem;">
                <!-- Biến chứa thông báo -->
                ${message}
            </div>

            <!-- Footer với nút đóng màu đen và chữ trắng -->
            <div class="modal-footer" style="background-color: white;">
                <button type="button" class="tf-btn btn-fill animate-hover-btn" data-bs-dismiss="modal" style="background-color: black; color: white;">
                    Đóng
                </button>
            </div>
        </div>
    </div>
</div>


<!-- Kiểm tra nếu có message và hiển thị modal -->
<c:if test="${not empty message}">
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {
            var messageModal = new bootstrap.Modal(document.getElementById('messageModal'));
            messageModal.show();
        });
    </script>
</c:if>
<%@ include file = "/common/web/header.jsp" %>
<!-- page-title -->
<div class="tf-page-title">
    <div class="container-full">
        <div class="heading text-center">My Account</div>
    </div>
</div>
<!-- /page-title -->

<!-- page-cart -->
<section class="flat-spacing-11">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="wrap-sidebar-account">
                    <ul class="my-account-nav">
                        <li>
                            <a href="<c:url value='/profile/${pageContext.request.userPrincipal.name}' />" class="my-account-nav-item ${currentPage == 'dashboard' ? 'active' : ''}">
                                Dashboard
                            </a>
                        </li>
                        <li>
                            <a href="my-account-orders.html" class="my-account-nav-item ${currentPage == 'orders' ? 'active' : ''}">
                                Orders
                            </a>
                        </li>
                        <li>
                            <a class="my-account-nav-item ${currentPage == 'address' ? 'active' : ''}" href="<c:url value='/profile/address/${pageContext.request.userPrincipal.name}' />">
                                Address
                            </a>
                        </li>
                        <li>
                            <a class="my-account-nav-item ${currentPage == 'detail' ? 'active' : ''}" href="<c:url value='/profile/detail/${pageContext.request.userPrincipal.name}' />">
                                Account Details
                            </a>
                        </li>
                        <li>
                            <a href="my-account-wishlist.html" class="my-account-nav-item ${currentPage == 'wishlist' ? 'active' : ''}">
                                Wishlist
                            </a>
                        </li>
                        <li>
                            <a href="login.html" class="my-account-nav-item ${currentPage == 'logout' ? 'active' : ''}">
                                Logout
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
            <sitemesh:write property="body" />
        </div>
    </div>
</section>
<!-- page-cart -->

<div class="btn-sidebar-account">
    <button data-bs-toggle="offcanvas" data-bs-target="#mbAccount" aria-controls="offcanvas"><i class="icon icon-sidebar-2"></i></button>
</div>

<%@ include file = "/common/web/footer.jsp" %>

<!-- Javascript -->
<script type="text/javascript" src="/web/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/web/js/jquery.min.js"></script>
<script type="text/javascript" src="/web/js/swiper-bundle.min.js"></script>
<script type="text/javascript" src="/web/js/carousel.js"></script>
<script type="text/javascript" src="/web/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="/web/js/lazysize.min.js"></script>
<script type="text/javascript" src="/web/js/count-down.js"></script>
<script type="text/javascript" src="/web/js/wow.min.js"></script>
<script type="text/javascript" src="/web/js/wow.min.js"></script>
<script type="text/javascript" src="/web/js/multiple-modal.js"></script>
<script type="text/javascript" src="/web/js/main.js"></script>
</body>
</html>