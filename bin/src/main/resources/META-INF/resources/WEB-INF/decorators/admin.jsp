<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
    <title>Ecomus - Ultimate Admin Dashboard HTML</title>

    <meta name="author" content="themesflat.com">

    <!-- Mobile Specific Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- Theme Style -->
    <link rel="stylesheet" type="text/css" href="/admin/css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="/admin/css/animation.css">
    <link rel="stylesheet" type="text/css" href="/admin/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/admin/css/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="/admin/css/styles.css">

    <!-- Font -->
    <link rel="stylesheet" href="/admin/font/fonts.css">

    <!-- Icon -->
    <link rel="stylesheet" href="/admin/icon/style.css">

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="/admin/images/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="/admin/images/favicon.png">
</head>
<body id="page-top">
<!-- #wrapper -->
<div id="wrapper">
    <!-- #page -->
    <div id="page" class="">
        <!-- layout-wrap -->
        <div class="layout-wrap">
            <!-- preload -->
            <div id="preload" class="preload-container">
                <div class="preloading">
                    <span></span>
                </div>
            </div>
            <!-- /preload -->
            <%@ include file="/common/admin/menu.jsp"%>
        </div>
        <sitemesh:write property="body" />
        <!-- /layout-wrap -->
    </div>
    <!-- /#page -->
</div>
<!-- /#wrapper -->
<!-- Javascript -->
<script src="/admin/js/jquery.min.js"></script>
<script src="/admin/js/bootstrap.min.js"></script>
<script src="/admin/js/bootstrap-select.min.js"></script>
<script src="/admin/js/zoom.js"></script>
<script src="/admin/js/morris.min.js"></script>
<script src="/admin/js/raphael.min.js"></script>
<script src="/admin/js/morris.js"></script>
<script src="/admin/js/jvectormap.min.js"></script>
<script src="/admin/js/jvectormap-us-lcc.js"></script>
<script src="/admin/js/jvectormap-data.js"></script>
<script src="/admin/js/jvectormap.js"></script>
<script src="/admin/js/apexcharts/apexcharts.js"></script>
<script src="/admin/js/apexcharts/line-chart-1.js"></script>
<script src="/admin/js/apexcharts/line-chart-2.js"></script>
<script src="/admin/js/apexcharts/line-chart-3.js"></script>
<script src="/admin/js/apexcharts/line-chart-4.js"></script>
<script src="/admin/js/apexcharts/line-chart-5.js"></script>
<script src="/admin/js/apexcharts/line-chart-6.js"></script>
<script src="/admin/js/apexcharts/line-chart-7.js"></script>
<script src="/admin/js/switcher.js"></script>
<script defer src="/admin/js/theme-settings.js"></script>
<script src="/admin/js/main.js"></script>
</body>
</html>