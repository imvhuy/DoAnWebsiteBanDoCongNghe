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
<!-- Kiểm tra nếu có message và hiển thị modal -->
<c:if test="${not empty message}">
    <div class="container">
        <div class="login-form">
            <div class="main-div">
                <div class="alert alert-danger">
                        ${message}
                </div>
            </div>
        </div>
    </div>
</c:if>
<%@ include file = "/common/web/header.jsp" %>
<sitemesh:write property="body" />
<%@ include file = "/common/web/footer.jsp" %>


<!-- Javascript -->
<script type="text/javascript" src="/web/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/web/js/jquery.min.js"></script>
<script type="text/javascript" src="/web/js/swiper-bundle.min.js"></script>
<script type="text/javascript" src="/web/js/carousel.js"></script>
<script type="text/javascript" src="/web/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="/web/js/lazysize.min.js"></script>
<script type="text/javascript" src="/web/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="/web/js/count-down.js"></script>
<script type="text/javascript" src="/web/js/wow.min.js"></script>
<script type="text/javascript" src="/web/js/multiple-modal.js"></script>
<script type="text/javascript" src="/web/js/main.js"></script>
</body>
</html>