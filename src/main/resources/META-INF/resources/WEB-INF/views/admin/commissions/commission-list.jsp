<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- section-content-right -->
<!-- main-content -->
<div class="main-content">
	<!-- main-content-wrap -->
	<div class="main-content-inner">
		<!-- main-content-wrap -->
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>All Commissions</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="/admin">
							<div class="text-tiny">Dashboard</div>
					</a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="#">
							<div class="text-tiny">Commissions</div>
					</a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li>
						<div class="text-tiny">All Commissions</div>
					</li>
				</ul>
			</div>
			<!-- all-commission -->
			<div class="wg-box">
				<div class="flex items-center justify-between gap10 flex-wrap">
					<div class="wg-filter flex-grow">
						<div class="show">
							<div class="text-tiny">Showing ${commissionPage.size}
								entries</div>
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

						<form class="form-search" method="GET" action="/admin/commissions">
							<fieldset class="name">
								<input type="text" placeholder="Search here..." class=""
									name="name" tabindex="2" value="${name}">
							</fieldset>
							<input type="hidden" name="size" value="5" /> <input
								type="hidden" name="page" value="0" />
							<div class="button-submit">
								<button class="" type="submit">
									<i class="icon-search"></i>
								</button>
							</div>
						</form>

					</div>
					<a class="tf-button style-1 w208"
						href="<c:url value='/admin/commissions/add'/>"> <i
						class="icon-plus"></i>Add New Commission
					</a>
				</div>
				<div class="wg-table table-all-attribute">
					<!-- Table Header -->
					<ul class="table-title flex gap20 mb-14">

						<li><div class="body-title">Name</div></li>
						<li><div class="body-title">Cost</div></li>
						<li><div class="body-title">Store</div></li>
						<li><div class="body-title">Deleted Temporary</div></li>
						<li><div class="body-title">Action</div></li>
					</ul>

					<!-- Table Body -->
					<ul class="flex flex-column">
						<c:forEach var="commission" items="${commissionList}">
							<li
								class="attribute-item item-row flex items-center justify-between gap20">

								<div class="name">
									<a
										href="<c:url value='/admin/commissions/edit/${commission.id}'/>"
										class="body-title-2">${commission.name}</a>
								</div>
								<div class="body-text">
									<fmt:formatNumber value="${commission.cost}" pattern="#,###" />
									VNĐ
								</div>
								<div class="body-text">${commission.store.storeName}</div>
								<div class="body-text">${commission.isDeleted ? 'Yes' : 'No'}</div>
								<!-- Action Buttons -->
								<div class="list-icon-function">
									<div class="item eye">
										<a
											href="<c:url value='/admin/commissions/edit/${commission.id}'><c:param name='view' value='true'/></c:url>">
											<i class="icon-eye"></i>
										</a>
									</div>
									<div class="item edit">
										<a
											href="<c:url value='/admin/commissions/edit/${commission.id}'/>">
											<i class="icon-edit-3"></i>
										</a>
									</div>
									<div class="item trash">
										<a
											href="<c:url value='/admin/commissions/delete/${commission.id}'/>">
											<i class="icon-trash-2"></i>
										</a>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- Pagination -->
				<div class="divider"></div>
				<div class="flex items-center justify-between flex-wrap gap10">
					<div class="text-tiny">Showing
						${commissionPage.totalElements} commissions</div>

					<c:if test="${commissionPage.totalPages > 0}">
						<ul class="wg-pagination">
							<!-- Previous Page Link -->
							<li><a
								href="<c:url value='/admin/commissions'>
                        <c:param name='page' value='${commissionPage.number > 0 ? commissionPage.number - 1 : 0}'/>
                        <c:param name='size' value='${size}'/>
                    </c:url>">
									<i class="icon-chevron-left"></i>
							</a></li>

							<!-- Page Numbers -->
							<c:forEach begin="1" end="${commissionPage.totalPages}"
								var="pageNumber">
								<li
									class="<c:if test='${pageNumber == commissionPage.number + 1}'>active</c:if>">
									<a
									href="<c:url value='/admin/commissions'>
                            <c:param name='page' value='${pageNumber - 1}'/>
                            <c:param name='size' value='${size}'/>
                        </c:url>">${pageNumber}</a>
								</li>
							</c:forEach>

							<!-- Next Page Link -->
							<li><a
								href="<c:url value='/admin/commissions'>
                        <c:param name='page' value='${commissionPage.number + 1 < commissionPage.totalPages ? commissionPage.number + 1 : commissionPage.totalPages - 1}'/>
                        <c:param name='size' value='${size}'/>
                    </c:url>">
									<i class="icon-chevron-right"></i>
							</a></li>
						</ul>
					</c:if>
				</div>

			</div>
		</div>
	</div>
<script>
function changeEntriesPerPage() {
    // Lấy giá trị của số lượng bản ghi muốn hiển thị từ dropdown
    var size = document.getElementById('entries-select').value;

    // Lấy tham số 'page' hiện tại từ URL (nếu có), nếu không thì mặc định là 0
    var page = new URLSearchParams(window.location.search).get('page') || 0;

    // Tạo lại URL với các tham số mới cho 'size' và 'page'
    var newUrl = new URL(window.location.href);
    newUrl.searchParams.set('size', size);
    newUrl.searchParams.set('page', page);

    // Điều hướng lại trang với URL mới
    window.location.href = newUrl.toString();
}

</script>
	<!-- /main-content-wrap -->
</div>
<!-- /main-content-wrap -->
