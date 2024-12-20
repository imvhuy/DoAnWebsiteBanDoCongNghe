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
    
	<link rel="stylesheet" href="/websocket/css/main.css"/>
    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="/web/images/logo/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="/web/images/logo/favicon.png">

</head>
<body>
<!-- Kiểm tra nếu có message và hiển thị modal -->
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/websocket/js/main.js" defer></script>
</body>
</html>