<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- main-content -->
<div class="main-content">
<style>
.image {
	width: 368px; /* Kích thước hình ảnh */
	height: 368px;
	border-radius: 10%; /* Làm tròn ảnh */
	overflow: hidden; /* Ẩn phần ảnh ngoài khu vực tròn */
}

.image img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* Cắt ảnh theo tỷ lệ hợp lý */
}
select.form-select {
    width: 100%;
    height: auto;
    background-color: #f6f6f6; /* Màu nền giống với các phần tử khác */
    border: 1px solid #ccc; /* Viền màu xám nhạt */
    border-radius: 4px; /* Bo góc nhẹ */
    padding: 10px; /* Khoảng cách bên trong */
    font-size: 14px; /* Kích thước chữ */
    color: #020202; /* Màu chữ */
    outline: none; /* Xóa viền mặc định khi click */
    box-shadow: none; /* Xóa hiệu ứng shadow mặc định */
}

select.form-select:focus {
    border-color: #f6f6f6; /* Màu viền khi focus */
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Hiệu ứng shadow khi focus */
    outline: none;
}
/* Highlight các options đã được chọn */
select.highlight-roles option:checked {
    background-color: #f6f6f6; /* Màu xanh nhạt cho highlight */
    color: #020202; /* Màu chữ nổi bật */
    font-weight: bold; /* Chữ đậm để dễ nhận biết */

}

/* Style cho các option chưa được chọn */
select.highlight-roles option:not(:checked) {
    background-color: #f6f6f6; /* Màu xám nhạt */
    
}

</style>
	<div class="main-content-inner">
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>${param.view == 'true' ? 'View User' : 'Edit User'}</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="/admin/users"><div class="text-tiny">User</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">Edit User</div></li>
				</ul>
			</div>

			<form class="form-add-new-user form-style-2" method="post"
				action="/admin/users/saveOrUpdate">
				<!-- Thêm trường hidden để truyền id người dùng -->
				<input type="hidden" name="id" value="${user.id}">
				<div class="wg-box">
					<div class="left">
						<h5 class="mb-4">Account</h5>
						<div class="body-text">Edit the information below to modify
							the user account</div>
						<h5 class="mb-4">Avatar</h5>
						<div class="image">
							<!-- Hiển thị ảnh avatar nếu có, nếu không thì dùng ảnh mặc định -->
							<img
								src="${user.avatar != null ? user.avatar : 'images/products/product-1.jpg'}"
								alt="User Avatar">
						</div>
					</div>

					<div class="right flex-grow">
						<fieldset class="name mb-24">
							<div class="body-title mb-10">Full Name</div>
							<input class="flex-grow" type="text" placeholder="Full Name"
								name="fullName" value="${user.fullName}" required>
						</fieldset>
						<fieldset class="name mb-24">
							<div class="body-title mb-10">User Name</div>
							<input class="flex-grow" type="text" placeholder="Username"
								name="username" value="${user.username}" required>
						</fieldset>
						<fieldset class="email mb-24">
							<div class="body-title mb-10">Email</div>
							<input class="flex-grow" type="email" placeholder="Email"
								name="email" value="${user.email}" required>
						</fieldset>

<fieldset class="email mb-24">
    <div class="body-title mb-10">Select Roles</div>
    <select name="roles" multiple class="form-select highlight-roles">
        <c:forEach var="role" items="${roles}">
            <!-- Kiểm tra xem role của user có thuộc danh sách roles không -->
            <option value="${role.id}" 
                <c:if test="${not empty user.roles && user.roles.contains(role)}">selected</c:if>>
                ${role.name}
            </option>
        </c:forEach>
    </select>
    <div class="body-text">Hold down the Ctrl (Windows) or Command (Mac) button to select multiple options.</div>
</fieldset>



						<fieldset class="password mb-24">
							<div class="body-title mb-10">Password</div>
							<input class="password-input" type="password"
								placeholder="Enter password" name="password"
								value="${user.password != null ? user.password : ''}" readonly>
							<span class="show-pass"> <i class="icon-eye view"></i> <i
								class="icon-eye-off hide"></i>
							</span>
						</fieldset>

						<fieldset class="password">
							<div class="body-title mb-10">Confirm password</div>
							<input class="password-input" type="password"
								placeholder="Confirm password" name="confirmPassword"
								value="${user.password != null ? user.password : ''}" readonly>
							<span class="show-pass"> <i class="icon-eye view"></i> <i
								class="icon-eye-off hide"></i>
							</span>
						</fieldset>

					</div>
					<div class="wg-box">
						<div class="left">
							<h5 class="mb-4">Permission</h5>
							<div class="body-text">Items that the account is allowed to
								edit</div>
						</div>
						<div class="right flex-grow">
							<fieldset class="mb-24">
								<div class="body-title mb-10">Status</div>
								<div class="radio-buttons">
									<div class="item">
										<!-- Status 'Allow' -->
										<input class="" type="radio" name="status" id="user-status1"
											value="1" <c:if test="${user.status == 1}">checked</c:if>>
										<label for="user-status1"><span class="body-title-2">Allow</span></label>
									</div>
									<div class="item">
										<!-- Status 'Deny' -->
										<input class="" type="radio" name="status" id="user-status2"
											value="0" <c:if test="${user.status == 0}">checked</c:if>>
										<label for="user-status2"><span class="body-title-2">Deny</span></label>
									</div>
								</div>
							</fieldset>

							<fieldset class="mb-24">
								<div class="body-title mb-10">Email Active</div>
								<div class="radio-buttons">
									<div class="item">
										<input class="" type="radio" name="isEmailActive"
											id="email-active1" value="true"
											<c:if test="${user.isEmailActive == true}">checked</c:if>>
										<label for="email-active1"><span class="body-title-2">Allow</span></label>
									</div>
									<div class="item">
										<input class="" type="radio" name="isEmailActive"
											id="email-active2" value="false"
											<c:if test="${user.isEmailActive == false}">checked</c:if>>
										<label for="email-active2"><span class="body-title-2">Deny</span></label>
									</div>
								</div>
							</fieldset>


						</div>
					</div>
				</div>

				<div class="bot">
					<a href="/admin/users" class="tf-button w180">Back To User List</a>

					<c:if test="${param.view != 'true'}">
						<button class="tf-button w180" type="submit">Update</button>
					</c:if>
				</div>




			</form>
		</div>
	</div>
</div>
