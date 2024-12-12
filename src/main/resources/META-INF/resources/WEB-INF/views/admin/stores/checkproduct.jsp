<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- main-content -->
<div class="main-content">
	<!-- main-content-wrap -->
	<div class="main-content-inner">
		<!-- main-content-wrap -->
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>All Product in ${storeName}</h3>

				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="/admin/stores"><div class="text-tiny">Store</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">All Product</div></li>
				</ul>
			</div>

			<!-- all-product -->
			<div class="wg-box">
				<div class="flex items-center justify-between gap10 flex-wrap">
					<div class="wg-filter flex-grow">
						<div class="show">
							<div class="text-tiny">Show</div>
							<div class="select">
								<select id="entries-select" onchange="changeEntriesPerPage()">
									<option value="5" ${size == 5 ? 'selected' : ''}>5</option>
									<option value="10" ${size == 10 ? 'selected' : ''}>10</option>
									<option value="20" ${size == 20 ? 'selected' : ''}>20</option>
									<option value="30" ${size == 30 ? 'selected' : ''}>30</option>
								</select>
							</div>
							<div class="text-tiny">entries</div>
						</div>
						<form class="form-search" method="GET"
							action="/admin/stores/checkproduct/${storeId}">
							<fieldset class="name">
								<input type="text" placeholder="Search.." name="name"
									value="${name}">
							</fieldset>
							<input type="hidden" name="size" value="${size}" /> <input
								type="hidden" name="page" value="1" />
							<div class="button-submit">
								<button class="" type="submit">
									<i class="icon-search"></i>
								</button>
							</div>
						</form>
					</div>
					<a class="tf-button style-1 w208"
						href="<c:url value='/admin/stores/addProduct/${storeId}'/>"> <i
						class="icon-plus"></i>Add New Product
					</a>
				</div>

				<!-- Danh sách sản phẩm -->

				<div class="wg-table table-all-user">
					<ul class="table-title flex gap20 mb-14">
						<li><div class="body-title">Product Name</div></li>
						<li><div class="body-title">Price</div></li>
						<li><div class="body-title">Category</div></li>
						<li><div class="body-title">Quantity</div></li>
						<li><div class="body-title">Action</div></li>
					</ul>
					<ul class="flex flex-column">
						<!-- Duyệt qua danh sách người dùng -->
						<c:forEach var="StoreProduct" items="${StoreProducts}">
							<li class="wg-product item-row">
								<div class="name flex-grow">
									<c:forEach var="gallery"
										items="${StoreProduct.product.galleryEntities}">
										<c:if test="${gallery.type == 'front'}">
											<img src="/admin/images/products/${gallery.image}"
												alt="Left Image" class="image" style="max-width: 200px;" />
										</c:if>
									</c:forEach>
									<div>
										<div class="title">
											<a
												href="/admin/stores/viewProduct/${StoreProduct.product.id}"
												class="body-title-2">${StoreProduct.product.name}</a>
										</div>

									</div>
								</div>
								<div class="body-text">
									<fmt:formatNumber value="${StoreProduct.product.price}"
										pattern="#,###" />
									VND
								</div>
								<div class="body-text">${StoreProduct.product.categoryEntity.name}</div>
								<div class="body-text">${StoreProduct.quantity}</div>
								<div class="list-icon-function">
									<!-- Xem chi tiết sản phẩm -->
									<div class="item eye">
										<a
											href="<c:url value='/admin/stores/viewProduct/${StoreProduct.id}'/>"><i
											class="icon-eye"></i></a>
									</div>
								</div>

							</li>
						</c:forEach>
					</ul>
				</div>

				<div class="divider"></div>

				<!-- Phân trang -->
				<div class="flex items-center justify-between flex-wrap gap10">
					<div class="text-tiny">Show ${storeProductPage.totalElements}
						entries</div>
					<ul class="wg-pagination">
						<!-- Nút Previous -->
						<li><a
							href="<c:url value='/admin/stores/checkproduct/${storeId}'>
            	<c:param name='page' value='${currentPage > 1 ? currentPage - 1 : 1}' />
            	<c:param name='size' value='${size}' />
            	</c:url>"><i
								class="icon-chevron-left"></i></a></li>

						<!-- Hiển thị trang đầu nếu cần -->
						<c:if test="${currentPage > 3}">
							<li><a
								href="<c:url value='/admin/stores/checkproduct/${storeId}'>
                <c:param name='page' value='1'/>
                <c:param name='size' value='${size}'/>
            </c:url>">1</a></li>
							<li>...</li>
						</c:if>

						<!-- Các trang xung quanh trang hiện tại -->
						<c:set var="startPage"
							value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
						<c:set var="endPage"
							value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />
						<c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
							<li
								class="paginator__item ${pageNumber == currentPage ? 'active' : ''}">
								<a
								href="<c:url value='/admin/stores/checkproduct/${storeId}'>
                    <c:param name='page' value='${pageNumber}'/>
                    <c:param name='size' value='${size}'/>
                </c:url>">${pageNumber}</a>
							</li>
						</c:forEach>

						<!-- Hiển thị trang cuối nếu cần -->
						<c:if test="${currentPage < totalPages - 2}">
							<li>...</li>
							<li><a
								href="<c:url value='/admin/stores/checkproduct/${storeId}'>
                <c:param name='page' value='${totalPages}'/>
                <c:param name='size' value='${size}'/>
            </c:url>">${totalPages}</a></li>
						</c:if>

						<!-- Nút Next -->
						<li><a
							href="<c:url value='/admin/stores/checkproduct/${storeId}'>
            	<c:param name='page' value='${currentPage < totalPages ? currentPage + 1 : totalPages}' />
            	<c:param name='size' value='${size}' />
            	</c:url>"><i
								class="icon-chevron-right"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script>
		function changeEntriesPerPage() {
			const size = document.getElementById("entries-select").value;
			const url = new URL(window.location.href);
			url.searchParams.set('size', size); // Cập nhật tham số size
			url.searchParams.set('page', '1'); // Đảm bảo trang luôn bắt đầu từ trang 1
			window.location.href = url.toString(); // Chuyển hướng tới URL mới
		}
	</script>
</div>
