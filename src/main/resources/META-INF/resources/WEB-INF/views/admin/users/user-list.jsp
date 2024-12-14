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
				<h3>All User</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="#"><div class="text-tiny">User</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">All User</div></li>
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
						<form class="form-search" method="GET" action="/admin/users">
							<fieldset class="name">
								<input type="text" placeholder="Search here..." class=""
									name="username" tabindex="2" value="${username}">
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

					<!--	<a class="tf-button style-1 w208"
						href="<c:url value='/admin/users/add' />"> <i
						class="icon-plus"></i> Add new
					</a> -->

				</div>

				<!-- Danh sách người dùng -->
				<div class="wg-table table-all-user">
					<ul class="table-title flex gap20 mb-14">
						<li><div class="body-title">User</div></li>
						<li><div class="body-title">Roles</div></li> <!-- Thêm cột Roles -->
						<li><div class="body-title">Email</div></li>
						<li><div class="body-title">Commit History</div></li>
						<li><div class="body-title">Action</div></li>
					</ul>
					<ul class="flex flex-column">
						<!-- Duyệt qua danh sách người dùng -->
						<c:forEach var="user" items="${users}">
							<li class="wg-product item-row">
								<div class="name flex-grow">
									<div class="image">
										<img
											src="${user.avatar != null ? user.avatar : 'images/products/product-1.jpg'}"
											alt="User Avatar">
									</div>
									<div>
										<div class="title">
											<a href="#" class="body-title-2">${user.fullName}</a>
										</div>

									</div>
								</div>
								<!-- Hiển thị Roles -->
								<div class="body-text">
								    <c:forEach var="role" items="${user.roles}" varStatus="status">
								        <span>${role.name}</span>
								        <c:if test="${!status.last}">, </c:if> <!-- Chỉ thêm dấu phẩy nếu không phải mục cuối -->
								    </c:forEach>
								</div>

								<div class="body-text">${user.email}</div>
								
								<div class="body-text">
									<a href="/admin/users/checkHistory/${user.id}">Check
										History Commit</a>
								</div>
								<div class="list-icon-function">
									<!-- Xem thông tin người dùng -->
									<div class="item eye">
										<a
											href="<c:url value='/admin/users/edit/${user.id}'>
    										<c:param name='view' value='true' />
											</c:url>">
											<i class="icon-eye"></i>
										</a>

									</div>

									<!-- Sửa thông tin người dùng -->
									<div class="item edit">
										<a href="<c:url value='/admin/users/edit/${user.id}' />"><i
											class="icon-edit-3"></i></a>
									</div>

									<!-- Xóa người dùng -->
									<div class="item trash">
										<a href="<c:url value='/admin/users/delete/${user.id}' />">

											<i class="icon-trash-2"></i>
										</a>
									</div>
								</div>

							</li>
						</c:forEach>
					</ul>
				</div>

				<div class="divider"></div>

				<!-- Phân trang -->
				<!-- Phân trang -->
				<div class="flex items-center justify-between flex-wrap gap10">
					<div class="text-tiny">Showing ${userPage.totalElements}
						entries</div>
					<ul class="wg-pagination">
						<!-- Nút Previous -->
						<li><a
							href="<c:url value='/admin/users'>
            <c:param name='page' value='${currentPage > 1 ? currentPage - 1 : 1}'/>
            <c:param name='size' value='${size}'/>
        </c:url>"><i
								class="icon-chevron-left"></i></a></li>

						<!-- Hiển thị trang đầu nếu cần -->
						<c:if test="${currentPage > 3}">
							<li><a
								href="<c:url value='/admin/users'>
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
								href="<c:url value='/admin/users'>
                    <c:param name='page' value='${pageNumber}'/>
                    <c:param name='size' value='${size}'/>
                </c:url>">${pageNumber}</a>
							</li>
						</c:forEach>

						<!-- Hiển thị trang cuối nếu cần -->
						<c:if test="${currentPage < totalPages - 2}">
							<li>...</li>
							<li><a
								href="<c:url value='/admin/users'>
                <c:param name='page' value='${totalPages}'/>
                <c:param name='size' value='${size}'/>
            </c:url>">${totalPages}</a></li>
						</c:if>

						<!-- Nút Next -->
						<li><a
							href="<c:url value='/admin/users'>
            <c:param name='page' value='${currentPage < totalPages ? currentPage + 1 : totalPages}'/>
            <c:param name='size' value='${size}'/>
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
