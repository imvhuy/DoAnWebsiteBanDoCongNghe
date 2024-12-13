<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.body-title {
	width: 152px; /* Cá» Äá»nh chiá»u rá»ng */
	height: 20px; /* Cá» Äá»nh chiá»u cao */
	color: #000;
	/* MÃ u chá»¯ (cáº§n Äiá»u chá»nh theo thiáº¿t káº¿ cá»§a báº¡n) */
	font-size: 14px; /* KÃ­ch thÆ°á»c chá»¯ */
	font-family: "Albert Sans", sans-serif; /* Font chá»¯ */
	line-height: 20px;
	/* Äáº£m báº£o cÄn chá»nh dÃ²ng vá»i chiá»u cao */
	overflow: hidden; /* áº¨n ná»i dung vÆ°á»£t quÃ¡ */
	white-space: nowrap; /* KhÃ´ng xuá»ng dÃ²ng */
	text-overflow: ellipsis;
	/* Hiá»n thá» dáº¥u "..." náº¿u ná»i dung quÃ¡ dÃ i */
	display: block; /* Äáº£m báº£o lÃ  block-level element */
}
</style>
<!-- #wrapper -->

<!-- main-content -->
<div class="main-content">
	<!-- main-content-wrap -->
	<div class="main-content-inner">
		<!-- main-content-wrap -->
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>All Products</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a>
					</li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="#"><div class="text-tiny">Product</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li>
						<div class="text-tiny">All Products</div>
					</li>
				</ul>
			</div>
			<!-- product-list -->
			<div class="wg-box">
				<div class="title-box">
					<i class="icon-coffee"></i>
					<div class="body-text">Tip search by Product ID: Each product
						is provided with a unique ID, which you can rely on to find the
						exact product you need.</div>
				</div>
				<!-- Filters and Search Form -->
				<div class="flex items-center justify-between gap10 flex-wrap">
					<div class="wg-filter flex-grow">
						<div class="show">
							<div class="text-tiny">Showing ${productPage.size} entries</div>
							<div class="select">
								<select id="entries-select" onchange="changeEntriesPerPage()">
									<option value="10" ${size == 10 ? 'selected' : ''}>10</option>
									<option value="20" ${size == 20 ? 'selected' : ''}>20</option>
									<option value="30" ${size == 30 ? 'selected' : ''}>30</option>
								</select>
							</div>
							<div class="text-tiny">entries</div>
						</div>

						<form class="form-search" method="GET" action="/admin/products">
							<fieldset class="name">
								<input type="text" placeholder="Search here..." class=""
									name="name" tabindex="2" value="${name}">
							</fieldset>
							<input type="hidden" name="size" value="${size}" /> <input
								type="hidden" name="page" value="0" />
							<!-- Trang luôn là 0 khi tìm kiếm -->
							<div class="button-submit">
								<button class="" type="submit">
									<i class="icon-search"></i>
								</button>
							</div>
						</form>

					</div>

					<a class="tf-button style-1 w208"
						href="<c:url value='/admin/products/add'/>"> <i
						class="icon-plus"></i>Add New Product
					</a>
				</div>
				<div class="wg-table table-product-list">
					<ul class="table-title flex gap20 mb-14">
						<li style="width: 152px; height: 20px;">
							<div class="body-title">Product ID</div>
						</li>
						<li>
							<div class="body-title">Product Name</div>
						</li>
						<li>
							<div class="body-title">Price</div>
						</li>
						<li>
							<div class="body-title">Action</div>
						</li>
					</ul>
					<ul class="flex flex-column">
						<!-- Table Body -->
						<c:forEach var="product" items="${products}">
							<li class="wg-product item-row gap20">
								<div class="name" style="width: 152px; height: 20px;">
									<a class="body-title-2">${product.id}</a>
								</div>
								<div class="name">
									<a class="body-title-2">${product.name}</a>
								</div>
								<div class="name">
									<a class="body-title-2">${product.price}</a>
								</div> <!-- Action Buttons -->
								<div class="list-icon-function">
									<div class="item edit">
										<a href="<c:url value='/admin/products/edit/${product.id}'/>">
											<i class="icon-edit-3"></i>
										</a>
									</div>
									<div class="item trash">
										<a
											href="<c:url value='/admin/products/delete/${product.id}'/>">
											<i class="icon-trash-2"></i>
										</a>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- Pagination -->
				<!-- Pagination -->
				<div class="divider"></div>
				<div class="flex items-center justify-between flex-wrap gap10">
					<div class="text-tiny">Showing ${productPage.totalElements}
						entries</div>

					<c:if test="${productPage.totalPages > 1}">
						<ul class="wg-pagination">
							<!-- Previous Page Link -->
							<li><a
								href="<c:url value='/admin/products'>
            <c:param name='name' value='${name}'/>
            <c:param name='size' value='${size}'/>
            <c:param name='page' value='${productPage.number > 0 ? productPage.number : 1}'/>
        </c:url>">
									<i class="icon-chevron-left"></i>
							</a></li>

							<!-- Display First Page if Needed -->
							<c:if test="${productPage.number > 1}">
								<li><a
									href="<c:url value='/admin/products'>
                <c:param name='name' value='${name}'/>
                <c:param name='size' value='${size}'/>
                <c:param name='page' value='1'/>
            </c:url>">1</a></li>
								<li>...</li>
							</c:if>

							<!-- Display Pages Around Current Page -->
							<c:set var="startPage"
								value="${productPage.number - 2 > 1 ? productPage.number - 2 : 1}" />
							<c:set var="endPage"
								value="${productPage.number + 2 < productPage.totalPages ? productPage.number + 2 : productPage.totalPages}" />
							<c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
								<li
									class="${pageNumber == productPage.number + 1 ? 'active' : ''}">
									<a
									href="<c:url value='/admin/products'>
                    <c:param name='name' value='${name}'/>
                    <c:param name='size' value='${size}'/>
                    <c:param name='page' value='${pageNumber}'/>
                </c:url>">${pageNumber}</a>
								</li>
							</c:forEach>

							<!-- Display Last Page if Needed -->
							<c:if test="${productPage.number < productPage.totalPages - 2}">
								<li>...</li>
								<li><a
									href="<c:url value='/admin/products'>
                <c:param name='name' value='${name}'/>
                <c:param name='size' value='${size}'/>
                <c:param name='page' value='${productPage.totalPages}'/>
            </c:url>">${productPage.totalPages}</a></li>
							</c:if>

							<!-- Next Page Link -->
							<li><a
								href="<c:url value='/admin/products'>
            <c:param name='name' value='${name}'/>
            <c:param name='size' value='${size}'/>
            <c:param name='page' value='${productPage.number + 1 < productPage.totalPages ? productPage.number + 1 : productPage.totalPages - 1}'/>
        </c:url>">
									<i class="icon-chevron-right"></i>
							</a></li>
						</ul>
					</c:if>

				</div>
			</div>
			<!-- /product-list -->
		</div>
		<!-- /main-content-wrap -->
	</div>
	<!-- /main-content-wrap -->

	<!-- bottom-page -->
	<div class="bottom-page">
		<div class="body-text">
			Copyright Â© 2024 <a
				href="https://themesflat.co/html/ecomus/index.html">Ecomus</a>.
			Design by Themesflat All rights reserved
		</div>
	</div>
	<!-- /bottom-page -->
</div>
<!-- /main-content -->

<script>
function changeEntriesPerPage() {
    var entriesPerPage = document.getElementById("entries-select").value;
    var currentPage = ${productPage.number}; // Lấy giá trị trang hiện tại từ JSP

    // Chuyển hướng về trang 1 khi thay đổi số lượng mục trên mỗi trang
    window.location.href = "/admin/products?page=" + 1 + "&size=" + entriesPerPage;
}

</script>



<!-- ThÃªm Äoáº¡n nÃ y vÃ o Äáº§u ná»i dung trang -->
<c:if test="${not empty message}">
	<div class="alert alert-success" role="alert">${message}</div>
</c:if>

<c:if test="${not empty error}">
	<div class="alert alert-danger" role="alert">${error}</div>
</c:if>

