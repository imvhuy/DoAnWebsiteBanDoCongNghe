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

	/* Khoảng cách giữa các ảnh (có thể điều chỉnh theo nhu cầu) */
}

.container {
	display: flex !important; /* Dùng flex để các thẻ div nằm ngang */
	gap: 10px !important; /* Khoảng cách giữa các thẻ */
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
				<h3>Product Detail</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Dashboard</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="/admin/stores/checkproduct/${storeID}"><div
								class="text-tiny">Product</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">View Product</div></li>
				</ul>
			</div>

			<form class="form-add-new-store form-style-2" method="post"
				action="/admin/stores/saveOrUpdate">
				<!-- Thêm trường hidden để truyền id sản phẩm -->
				<input type="hidden" name="id" value="${product.id}">
				<div class="wg-box">
					<div class="left">
						<h5 class="mb-4">Product Information</h5>
						<div class="body-text">View the information below to know about
							the product details</div>
						<h5 class="mb-4">Product Avatar</h5>
						<div class="container">
							<div class="image">
								<!-- Hiển thị ảnh đại diện sản phẩm nếu có, nếu không thì dùng ảnh mặc định -->
								<img
									src="${product.galleryEntities != null && !product.galleryEntities.isEmpty() ? product.galleryEntities[0].image : 'images/products/product-1.jpg'}"
									alt="Product Avatar">
							</div>
							<div class="image">
								<!-- Hiển thị ảnh đại diện sản phẩm nếu có, nếu không thì dùng ảnh mặc định -->
								<img
									src="${product.galleryEntities != null && !product.galleryEntities.isEmpty() ? product.galleryEntities[1].image : 'images/products/product-1.jpg'}"
									alt="Product Avatar">
							</div>
						</div>
						<div class="container">

							<div class="image">
								<!-- Hiển thị ảnh đại diện sản phẩm nếu có, nếu không thì dùng ảnh mặc định -->
								<img
									src="${product.galleryEntities != null && !product.galleryEntities.isEmpty() ? product.galleryEntities[3].image : 'images/products/product-1.jpg'}"
									alt="Product Avatar">
							</div>
						</div>

					</div>

					<div class="right flex-grow">
						<fieldset class="name mb-24">
							<div class="body-title mb-10">Product Name</div>
							<input class="flex-grow" type="text" placeholder="Product Name"
								name="productName" value="${product.productName}" readonly>
						</fieldset>
						<fieldset class="description mb-24">
							<div class="body-title mb-10">Description</div>
							<textarea class="flex-grow auto-width" placeholder="Description"
								name="description" readonly style="height: 120px !important;">${product.description}</textarea>
						</fieldset>

						<fieldset class="description mb-24">
							<div class="body-title mb-10">Configuration</div>
							<textarea class="flex-grow auto-width"
								placeholder="Configuration" name="description"
								style="height: 350px !important; overflow-y: auto;"
								readonly="readonly">${product.configuration}</textarea>
						</fieldset>

						<div class="cols gap24">
							<fmt:formatNumber value="${product.price}" pattern="#,###"
								var="formattedPrice" />
							<fieldset class="price mb-24">
								<div class="body-title mb-10">Price</div>
								<input class="flex-grow" type="text" placeholder="Price"
									name="price" value="${formattedPrice} VNĐ" readonly>
							</fieldset>
							<fieldset class="quantity mb-24">
								<div class="body-title mb-10">Quantity</div>
								<input class="flex-grow" type="number" placeholder="Quantity"
									name="quantity" value="${storeProductEntity.quantity}" readonly>
							</fieldset>
						</div>

						<div class="cols gap24">

							<fmt:formatNumber value="${product.promotionalPrice}"
								pattern="#,###" var="formattedpromotionPrice" />
							<fieldset class="promotional-price mb-24">
								<div class="body-title mb-10">Promotional Price</div>
								<input class="flex-grow" type="text"
									placeholder="Promotional Price"
									value="${formattedpromotionPrice} VNĐ" readonly />
							</fieldset>

							<fieldset class="sold mb-24">
								<div class="body-title mb-10">Sold Number</div>
								<input class="flex-grow" type="number" placeholder="Sold"
									name="sold" value="${storeProductEntity.sold}" readonly>
							</fieldset>
						</div>
					</div>
					<div class="wg-box">
					
					<h5>You can see the Product's status below.</h5>
						<fieldset class="status mb-24">
							<div class="body-title mb-10">Product Status</div>
							<div class="radio-buttons">
								<div class="item">
									<!-- Status 'Active' -->
									<input class="" type="radio" name="isActive"
										id="product-status1" value="true"
										<c:if test="${product.isActive == true}">checked</c:if>
										disabled> <label for="product-status1"><span
										class="body-title-2">Active</span></label>
								</div>
								<div class="item">
									<!-- Status 'Inactive' -->
									<input class="" type="radio" name="isActive"
										id="product-status2" value="false"
										<c:if test="${product.isActive == false}">checked</c:if>
										disabled> <label for="product-status2"><span
										class="body-title-2">Inactive</span></label>
								</div>
							</div>
						</fieldset>

						<fieldset class="selling-status mb-24">
							<div class="body-title mb-10">Is Selling</div>
							<div class="radio-buttons">
								<div class="item">
									<input class="" type="radio" name="isSelling"
										id="product-selling1" value="true"
										<c:if test="${product.isSelling == true}">checked</c:if>
										disabled> <label for="product-selling1"><span
										class="body-title-2">Selling</span></label>
								</div>
								<div class="item">
									<input class="" type="radio" name="isSelling"
										id="product-selling2" value="false"
										<c:if test="${product.isSelling == false}">checked</c:if>
										disabled> <label for="product-selling2"><span
										class="body-title-2">Not Selling</span></label>
								</div>
							</div>
						</fieldset>
					</div>


				</div>
				<div class="bot">
					<a href="/admin/stores/checkproduct/${storeID}"
						class="tf-button w180">Product List</a>
				</div>
			</form>




		</div>
	</div>
</div>
