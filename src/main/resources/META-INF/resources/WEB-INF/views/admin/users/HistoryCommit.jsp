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
				<h3>All Commit of ${userName} </h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="/admin/users"><div class="text-tiny">User</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">Transaction History</div></li>
				</ul>
			</div>

			<!-- all-user -->
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
						<form class="form-search" method="GET"
							action="/admin/users/checkHistory/${userId}"
							style="display: flex; flex-wrap: wrap; gap: 10px;">
							<!-- Ensure page starts from 1 -->
							<input type="hidden" name="size" value="30" /> <input
								type="hidden" name="page" value="1" />

							<!-- Start Date -->
							<fieldset class="name" style="flex: 1 1 200px;">
								<label for="startDate">Start Date</label> <input type="date"
									id="startDate" placeholder="Start Date" class=""
									name="startDate" tabindex="2" value="${startDate}">
							</fieldset>

							<!-- End Date -->
							<fieldset class="name" style="flex: 1 1 200px;">
								<label for="endDate">End Date</label> <input type="date"
									id="endDate" placeholder="End Date" class="" name="endDate"
									tabindex="3" value="${endDate}">
							</fieldset>

							<!-- Submit Button -->
							<div class="button-submit"
								style="flex: 1 1 100%; display: flex; justify-content: flex-end;">
								<button class="" type="submit">
									<i class="icon-search"></i>
								</button>
							</div>
						</form>





					</div>

					<!--	<a class="tf-button style-1 w208"
						href="<c:url value='/admin/users/add' />"> <i
						class="icon-plus"></i> Add new
					</a> -->

				</div>

				<!-- transaction-history -->
				<div class="wg-box">
					<!-- Transaction Table -->
					<!-- transaction-history.jsp -->
					<div class="wg-table table-all-user">
						<ul class="table-title flex gap20 mb-14">
							<li><div class="body-title">Transaction ID</div></li>
							<li><div class="body-title">Transaction Date</div></li>
							<li><div class="body-title">Amount</div></li>
							<li><div class="body-title">Status</div></li>
							<li><div class="body-title">Payment Method</div></li>
						</ul>
						<ul class="flex flex-column">
							<!-- Loop through transactions -->
							<c:forEach var="transaction" items="${transactions}">
								<li class="wg-product item-row">
									<!-- Transaction ID -->
									<div class="body-text">${transaction.id}</div> <!-- Transaction Date (using Order create date) -->
									<div class="body-text">



										<fmt:formatDate value="${transaction.createdDate}" />
									</div> <!-- Amount -->
									<div class="body-text">
										<fmt:formatNumber value="${transaction.amount}"
											pattern="#,###" />
										VNĐ
									</div>

									<div class="body-text">${transaction.isPaid ? 'Đã thanh toán' : 'Chưa thanh toán'}</div>
									<!-- Payment Method (from PaymentEntity) -->
									<div class="body-text">${transaction.payment.method}</div>
								</li>
							</c:forEach>
						</ul>
					</div>



					<div class="divider"></div>

					<!-- Pagination -->
					<!-- Pagination -->
					<div class="flex items-center justify-between flex-wrap gap10">
						<div class="text-tiny">Showing ${totalElements} entries</div>
						<ul class="wg-pagination">
							<!-- Nút Previous -->
							<li><a
								href="<c:url value='/admin/users/checkHistory/${userId}'>
            <c:param name='page' value='${currentPage > 1 ? currentPage - 1 : 1}'/>
            <c:param name='size' value='${size}'/>
        </c:url>">
									<i class="icon-chevron-left"></i>
							</a></li>

							<!-- Hiển thị trang đầu nếu cần -->
							<c:if test="${currentPage > 3}">
								<li><a
									href="<c:url value='/admin/users/checkHistory/${userId}'>
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
									href="<c:url value='/admin/users/checkHistory/${userId}'>
                    <c:param name='page' value='${pageNumber}'/>
                    <c:param name='size' value='${size}'/>
                </c:url>">${pageNumber}</a>
								</li>
							</c:forEach>

							<!-- Hiển thị trang cuối nếu cần -->
							<c:if test="${currentPage < totalPages - 2}">
								<li>...</li>
								<li><a
									href="<c:url value='/admin/users/checkHistory/${userId}'>
                <c:param name='page' value='${totalPages}'/>
                <c:param name='size' value='${size}'/>
            </c:url>">${totalPages}</a></li>
							</c:if>

							<!-- Nút Next -->
							<li><a
								href="<c:url value='/admin/users/checkHistory/${userId}'>
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
		<script>
			// Hàm thay đổi số lượng mục mỗi trang và tải lại trang với tham số size mới
			function changeEntriesPerPage() {
				const size = document.getElementById("entries-select").value;
				const url = new URL(window.location.href);
				url.searchParams.set('size', size); // Cập nhật tham số size
				url.searchParams.set('page', '1'); // Đảm bảo trang luôn bắt đầu từ trang 1
				window.location.href = url.toString(); // Chuyển hướng tới URL mới
			}
		</script>
	</div>
</div>