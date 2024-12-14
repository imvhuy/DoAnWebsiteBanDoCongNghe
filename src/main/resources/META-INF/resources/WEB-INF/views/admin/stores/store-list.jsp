<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- main-content -->
<div class="main-content">
	<!-- main-content-wrap -->
	<div class="main-content-inner">
		<!-- main-content-wrap -->
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>All Stores</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="#"><div class="text-tiny">Store</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">All Stores</div></li>
				</ul>
			</div>

			<!-- All Stores Table -->
			<div class="wg-box">
				<div class="flex items-center justify-between gap10 flex-wrap">
					<div class="wg-filter flex-grow">
						<div class="show">
							<div class="text-tiny">Showing</div>
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
						<!-- Lọc trạng thái -->

						<form class="form-search" action="<c:url value='/admin/stores'/>"
							method="get">
							<fieldset class="name">
								<input type="text" placeholder="Search here..." name="storeName"
									tabindex="2" value="${param.storeName}" aria-required="true">
							</fieldset>
							<div class="button-submit">
								<button type="submit">
									<i class="icon-search"></i>
								</button>
							</div>
						</form>
						<div class="select">
							<select id="statusSelect" name="statusSelect" class="select"
								onchange="if(this.value) window.location.href = '/admin/stores?status=' + this.value;">
								<option value="">All</option>
								<option value="active"
									${param.status == 'active' ? 'selected' : ''}>Active</option>
								<option value="inactive"
									${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
							</select>

						</div>
					</div>

				</div>

				<div class="wg-table table-all-category">
					<ul class="table-title flex gap20 mb-14">
						<li><div class="body-title">Store Name</div></li>
						<li><div class="body-title">Bio</div></li>
						<li><div class="body-title">Status</div></li>
						<li><div class="body-title">Rating</div></li>
						<li><div class="body-title">Point</div></li>
						<li><div class="body-title">Check Product</div></li>
						<li><div class="body-title">Actions</div></li>
					</ul>

					<!-- Store list (Dynamically generated) -->
					<ul class="flex flex-column">
						<c:forEach var="store" items="${stores}">
							<!-- Thay storeList thành stores -->
							<li class="wg-product item-row gap20">
								<div class="name">
									<div class="image">
										<img src="${store.avatar}" alt="Avatar">
									</div>
									<div class="title line-clamp-2 mb-0">
										<a href="#" class="body-text">${store.name}</a>
									</div>
								</div>
								<div class="body-text text-main-dark mt-4">${store.bio}</div>
								<div class="body-text text-main-dark mt-4">
									<c:choose>
										<c:when test="${store.isActive}">
                    Active
                </c:when>
										<c:otherwise>
                    Inactive
                </c:otherwise>
									</c:choose>
								</div>
								<div class="body-text text-main-dark mt-4">${store.rating}/10
									points</div>
								<div class="body-text text-main-dark mt-4">${store.point}</div>

								<div class="body-text text-main-dark mt-4">
									<a
										href="<c:url value='/admin/stores/checkproduct/${store.id}' />">
										Check Product </a>
								</div>




								<div class="list-icon-function">
									<div class="item eye">
										<a href="<c:url value='/admin/stores/edit/${store.id}'/>">
											<i class="icon-eye"></i>
										</a>
									</div>
									<div class="item trash">
										<a href="<c:url value='/admin/stores/delete/${store.id}'/>">
											<i class="icon-trash-2"></i>
										</a>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>

				<div class="divider"></div>
				<div class="flex items-center justify-between flex-wrap gap10">
					<div class="text-tiny">Showing ${totalElements} entries</div>
					<ul class="wg-pagination">
						<li><a
							href="<c:url value='/admin/stores'>
        <c:param name='page' value='${currentPage > 1 ? currentPage - 1 : 1}'/>
        <c:param name='size' value='${size}'/>
    </c:url>">
								<i class="icon-chevron-left"></i>
						</a></li>

						<c:if test="${currentPage > 3}">
							<li><a
								href="<c:url value='/admin/store/list'>
            <c:param name='page' value='1'/>
            <c:param name='size' value='${size}'/>
        </c:url>">1</a></li>
							<li>...</li>
						</c:if>

						<c:set var="startPage"
							value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
						<c:set var="endPage"
							value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />
						<c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
							<li
								class="paginator__item ${pageNumber == currentPage ? 'active' : ''}">
								<a
								href="<c:url value='/admin/stores'>
                <c:param name='page' value='${pageNumber}'/>
                <c:param name='size' value='${size}'/>
            </c:url>">${pageNumber}</a>
							</li>
						</c:forEach>

						<c:if test="${currentPage < totalPages - 2}">
							<li>...</li>
							<li><a
								href="<c:url value='/admin/stores'>
            <c:param name='page' value='${totalPages}'/>
            <c:param name='size' value='${size}'/>
        </c:url>">${totalPages}</a></li>
						</c:if>

						<li><a
							href="<c:url value='/admin/stores'>
        <c:param name='page' value='${currentPage < totalPages ? currentPage + 1 : totalPages}'/>
        <c:param name='size' value='${size}'/>
    </c:url>">
								<i class="icon-chevron-right"></i>
						</a></li>
					</ul>

				</div>
			</div>
		</div>
	</div>

	<!-- Bottom page -->
	<div class="bottom-page">
		<div class="body-text">
			Copyright © 2024 <a
				href="https://themesflat.co/html/ecomus/index.html">Ecomus</a>.
			Design by Themesflat All rights reserved
		</div>
	</div>

</div>

<script>
	function changeEntriesPerPage() {
		const size = document.getElementById("entries-select").value;
		const url = new URL(window.location.href);
		url.searchParams.set('size', size);
		url.searchParams.set('page', '1'); // Reset to first page
		window.location.href = url.toString();
	}
</script>
<script>
    document.getElementById('statusSelect').addEventListener('change', function () {
        const selectedStatus = this.value; // Lấy trạng thái được chọn
        const url = new URL(window.location.href); // Lấy URL hiện tại

        // Cập nhật tham số `status` trong URL
        if (selectedStatus) {
            url.searchParams.set('status', selectedStatus);
        } else {
            url.searchParams.delete('status'); // Xóa nếu chọn "All"
        }

        // Chuyển hướng tới URL mới
        window.location.href = url.toString();
    });
</script>

