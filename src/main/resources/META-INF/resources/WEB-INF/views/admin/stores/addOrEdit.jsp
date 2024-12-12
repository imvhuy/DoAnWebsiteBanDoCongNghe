
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
</style>
	<div class="main-content-inner">
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>Edit Store</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="/admin/stores"><div class="text-tiny">Store</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">Edit Store</div></li>
				</ul>
			</div>

			<form class="form-add-new-store form-style-2" method="post"
				action="/admin/stores/saveOrUpdate">
				<!-- Thêm trường hidden để truyền id cửa hàng -->
				<input type="hidden" name="id" value="${store.id}">
				<div class="wg-box">
					<div class="left">
						<h5 class="mb-4">Store Information</h5>
						<div class="body-text">Edit the information below to modify
							the store details</div>
						<h5 class="mb-4">Store Avatar</h5>
						<div class="image">
							<!-- Hiển thị ảnh đại diện cửa hàng nếu có, nếu không thì dùng ảnh mặc định -->
							<img
								src="${store.avatar != null ? store.avatar : 'images/products/product-1.jpg'}"
								alt="Store Avatar">
						</div>
					</div>

					<div class="right flex-grow">
						<fieldset class="name mb-24">
							<div class="body-title mb-10">Store Name</div>
							<input class="flex-grow" type="text" placeholder="Store Name"
								name="storeName" value="${store.storeName}" readonly>
						</fieldset>
						<fieldset class="description-promotion mb-24">
							<div class="body-title mb-10">Store Bio</div>
							<textarea class="flex-grow" placeholder="Store Bio" name="bio"
								rows="4" tabindex="0" readonly>${store.bio}</textarea>
						</fieldset>


						<fieldset class="point mb-24">
							<div class="body-title mb-10">Store Points</div>
							<input class="flex-grow" type="number" placeholder="Store Points"
								name="point" value="${store.point}" readonly>
						</fieldset>
						<div class="cols gap24">
							<fieldset class="point mb-24">
								<div class="body-title mb-10">Store Level Name</div>
								<input class="flex-grow" type="text"
									placeholder="Store Level Name" name="point"
									value="${storeLevel.name}" disabled>
							</fieldset>

							<fieldset class="point mb-24">
								<div class="body-title mb-10">Store Level Discount</div>
								<input class="flex-grow" type="text"
									placeholder="Store Level Discount" name="point"
									value="${storeLevel.discount} %" disabled>
							</fieldset>

							<fieldset class="rating mb-24">
								<div class="body-title mb-10">Store Rating</div>
								<!-- Trường hiển thị cho người dùng, với đơn vị "points" -->
								<input class="flex-grow" type="text" placeholder="Store Rating"
									name="ratingDisplay" value="${store.rating} points" readonly>

								<!-- Trường hidden chứa giá trị số nguyên, gửi giá trị này khi submit form -->
								<input type="hidden" name="rating" value="${store.rating}">
							</fieldset>
						</div>

						<fieldset class="commission mb-24">
							<div class="body-title mb-10">Store Commisstion Cost</div>
							<input class="flex-grow" type="text"
								placeholder="Store Commisstion Cost"
								value="<fmt:formatNumber value="${store.commission.cost}" pattern="#,###" /> VNĐ"
								readonly>
						</fieldset>

						<fieldset class="commission mb-24">
							<div class="body-title mb-10">Store Commisstion Description</div>
							<input class="flex-grow" type="text"
								placeholder="Store Commisstion Description"
								value="${store.commission.description}" readonly>
						</fieldset>

					</div>
					<div class="wg-box">
						<div class="left">
							<h5 class="mb-4">Store Status</h5>
							<div class="body-text">You can see the shop's status below.</div>
						</div>
						<div class="right flex-grow">

							<fieldset class="mb-24">
								<div class="body-title mb-10">Store Open</div>
								<div class="radio-buttons">
									<div class="item">
										<input class="" type="radio" name="isOpen" id="store-open1"
											value="true"
											<c:if test="${store.isOpen == true}">checked</c:if> disabled>
										<label for="store-open1"><span class="body-title-2">Open</span></label>
									</div>
									<div class="item">
										<input class="" type="radio" name="isOpen" id="store-open2"
											value="false"
											<c:if test="${store.isOpen == false}">checked</c:if> disabled>
										<label for="store-open2"><span class="body-title-2">Closed</span></label>
									</div>
								</div>
							</fieldset>
							<div class="body-text">Items that the store is allowed to
								edit</div>
							<div class="right flex-grow">
								<fieldset class="mb-24">
									<div class="body-title mb-10">Is Active</div>
									<div class="radio-buttons">
										<div class="item">
											<!-- Status 'Active' -->
											<input class="" type="radio" name="isActive"
												id="store-status1" value="true"
												<c:if test="${store.isActive == true}">checked</c:if>>
											<label for="store-status1"><span class="body-title-2">Active</span></label>
										</div>
										<div class="item">
											<!-- Status 'Inactive' -->
											<input class="" type="radio" name="isActive"
												id="store-status2" value="false"
												<c:if test="${store.isActive == false}">checked</c:if>>
											<label for="store-status2"><span class="body-title-2">Inactive</span></label>
										</div>
									</div>
								</fieldset>
							</div>

						</div>
					</div>
				</div>

				<c:if test="${param.view != 'true'}">
					<div class="bot">
						<a href="/admin/stores" class="tf-button w180">Back To Store
							List</a>
						<button class="tf-button w180" type="submit">Update</button>

					</div>
				</c:if>

			</form>
		</div>
	</div>
</div>