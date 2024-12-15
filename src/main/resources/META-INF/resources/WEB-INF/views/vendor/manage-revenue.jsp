<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/common/taglib.jsp"%>
<div class="container mt-4" style="padding-bottom: 200px;">
	<h3>Quản Lý Đơn Hàng</h3>
	<div class="row">
		<div class="col-md-3">
			<!-- Sidebar -->
			<div class="list-group" id="sidebarMenu">
				<a href="${pageContext.request.contextPath}/vendor/manage-store"
					class="list-group-item list-group-item-action">Trang Chủ Cửa
					Hàng</a> <a
					href="${pageContext.request.contextPath}/vendor/manage-product"
					class="list-group-item list-group-item-action">Quản Lý Sản Phẩm</a>
				<a href="${pageContext.request.contextPath}/vendor/manage-order"
					class="list-group-item list-group-item-action">Quản Lý Đơn Hàng</a>
				<a href="${pageContext.request.contextPath}/vendor/manage-discount"
					class="list-group-item list-group-item-action">Chương Trình
					Khuyến Mãi</a> <a
					href="${pageContext.request.contextPath}/vendor/manage-revenue"
					class="list-group-item list-group-item-action">Doanh Thu</a>
			</div>
		</div>
		<div class="col-md-9">
			<!-- Revenue Chart" -->
			<div class="wg-box">
				<form id="yearForm"
					action="${pageContext.request.contextPath}/vendor/manage-revenue"
					method="GET">
					<label for="yearSelect">Chọn năm : </label><select name="year"
						id="yearSelect" onchange="submitForm()" style ="margin-left: 10px;">
						<c:forEach var="year" items="${yearList}">
							<option value="${year}" ${year == selectedYear ? 'selected' : ''}>${year}</option>
						</c:forEach>
					</select>

				</form>
				<div class="flex items-center justify-between">
					<h5>Biểu đồ tổng doanh thu theo tháng</h5>
				</div>

				<div class="flex flex-wrap gap40">
					<div>
						<div class="mb-1">
							<div class="block-legend">
								<div class="dot t3"></div>
								<div class="text-tiny" style="color: white; font-size: 30px;">Revenues</div>
							</div>
						</div>
					</div>
				</div>
				<div id="line-chart-7"></div>
			</div>
			<!-- /Revenue -->
		</div>
		<div class="col-md-3"></div>
		<div class="col-md-9">
			<!-- Amount Order Chart" -->
			<div class="wg-box">
				<div class="flex items-center justify-between">
					<h5>Biểu đồ số lượng đơn đặt hàng</h5>
				</div>
				<div class="flex flex-wrap gap40">
					<div>
						<div class="mb-1">
							<div class="block-legend">
								<div class="dot t3"></div>
								<div class="text-tiny" style="color: white; font-size: 30px;">Revenues</div>
							</div>
						</div>
					</div>
				</div>
				<div id="line-chart-22"></div>
			</div>
			<!-- /Amount Order -->
		</div>
	</div>

</div>
</div>

<script type="text/javascript">
	//tạo biến lưu trữ data cho chart
	<c:if test="${not empty jsonChartMonthlyData}">
	var jsonChartMonthlyData = <c:out value="${jsonChartMonthlyData}" escapeXml="false" />;
	</c:if>
	console.log("jsonChartMonthlyData:", jsonChartMonthlyData);
	console.log(jsonChartMonthlyData.revenueList); // Kiểm tra dữ liệu cột
	console.log(jsonChartMonthlyData.monthList); // Kiểm tra dữ liệu tháng
	//
	<c:if test="${not empty jsonChartMonthlyOrderData}">
	var jsonChartMonthlyOrderData = <c:out value="${jsonChartMonthlyOrderData}" escapeXml="false" />;
	</c:if>

	//
</script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<c:if test="${not empty jsonChartMonthlyData}">
	<script
		src="${pageContext.request.contextPath}/admin/js/apexcharts/line-chart-7.js">
		
	</script>
</c:if>
<c:if test="${not empty jsonChartMonthlyOrderData}">
	<script
		src="${pageContext.request.contextPath}/admin/js/apexcharts/line-chart-22.js">
		
	</script>
</c:if>
<script>
	//
	function submitForm() {
		document.getElementById("yearForm").submit();
	}
</script>

