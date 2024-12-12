<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- main-content -->
<div class="main-content">
	<style>
.image {
	width: 190px; /* Kích thước hình ảnh */
	height: 368px;
	border-radius: 10%; /* Làm tròn ảnh */
	overflow: hidden; /* Ẩn phần ảnh ngoài khu vực tròn */

	/* Khoảng cách giữa các ảnh (có thể điều chỉnh theo nhu cầu) */
}

.image2 {
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
					<li><a href="/admin/stores/checkproduct/${storeId}"><div
								class="text-tiny">Product</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">View Product</div></li>
				</ul>
			</div>

			<form class="form-add-new-store form-style-2" method="post"
				action="/admin/stores/addProduct">
				<!-- Thêm trường hidden để truyền id sản phẩm -->
				<input type="hidden" name="id" value="${product.id}"> 
				<input type="hidden" id="storeId" name="storeId" value="${storeId}">
				<div class="wg-box">

					<div class="left">

						<div class="mb-4">
							<label for="productSelect" class="form-label">Select Product</label> 
							<select id="productSelect"  name="productSelect" class="select"
								onchange="if(this.value) window.location.href = '/admin/stores/SelectedAddProduct/' + document.getElementById('storeId').value + '/' + this.value;">
								<option value="">Select a product...</option>
								<c:forEach items="${products}" var="product">
									<option value="${product.id}"
										<c:if test="${product.id == selectedProductId}">selected</c:if>>
										${product.name}</option>
								</c:forEach>
							</select>


							<div class="mb-4" style="margin-top: 15px;">
								<label for="quantity" class="form-label">Quantity</label> <input
									type="number" id="quantity" class="form-control"
									name="quantityInput" placeholder="Enter quantity" min="1">
							</div>
						</div>


						<div class="wg-box">
							<h5 class="mb-4">Product Information</h5>
							<div class="body-text">View the information below to know
								about the product details</div>
							<h5 class="mb-4">Product Images</h5>
							<div class="container">
								<!-- Left Image -->
								<div class="image">
									<c:choose>
										<c:when test="${not empty product.galleryEntities}">
											<c:forEach var="gallery" items="${product.galleryEntities}">
												<c:if test="${gallery.type == 'left'}">
													<img src="/admin/images/products/${gallery.image}"
														alt="Left Image" class="image" style="max-width: 200px;" />
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<img src="images/products/product-1.jpg" alt="Left Image"
												class="image" style="max-width: 200px;" />
										</c:otherwise>
									</c:choose>
								</div>

								<!-- Right Image -->
								<div class="image">
									<c:choose>
										<c:when test="${not empty product.galleryEntities}">
											<c:forEach var="gallery" items="${product.galleryEntities}">
												<c:if test="${gallery.type == 'right'}">
													<img src="/admin/images/products/${gallery.image}"
														alt="Right Image" class="image" style="max-width: 200px;" />
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<img src="images/products/product-1.jpg" alt="Right Image"
												class="image" style="max-width: 200px;" />
										</c:otherwise>
									</c:choose>
								</div>
							</div>

							<!-- Front Behind Image -->
							<div class="container">
								<div class="image2">
									<c:choose>
										<c:when test="${not empty product.galleryEntities}">
											<c:forEach var="gallery" items="${product.galleryEntities}">
												<c:if test="${gallery.type == 'front'}">
													<img src="/admin/images/products/${gallery.image}"
														alt="Front Image" class="image2"
														style="max-width: 368px; margin: 20px;" />
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<img src="images/products/product-1.jpg" alt="Front Image"
												class="image2" style="width: 368px; margin: 20px;" />
										</c:otherwise>
									</c:choose>
								</div>

							</div>
						</div>

					</div>

					<div class="right flex-grow">
						<div class="cols gap24">
							<fieldset class="name mb-24">
								<div class="body-title mb-10">Product Name</div>
								<input class="flex-grow" type="text" placeholder="Product Name"
									name="name" value="${product.name}" readonly>
							</fieldset>
							<fieldset class="name mb-24">
								<div class="body-title mb-10">Product Category</div>
								<input class="flex-grow" type="text"
									placeholder="Product Category" name="name"
									value="${product.categoryEntity.name}" readonly>
							</fieldset>
							<fieldset class="name mb-24">
								<div class="body-title mb-10">Product Color</div>
								<input class="flex-grow" type="text" placeholder="Product Color"
									name="name" value="${product.color}" readonly>
							</fieldset>
						</div>
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
						<iframe width="560" height="315" src="${product.video}"
							frameborder="0"
							allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
							allowfullscreen></iframe>
					</div>


				</div>
				<div class="bot">
					<a href="/admin/stores/checkproduct/${storeId}"
						class="tf-button w180">Product List</a>
						 <button class="tf-button w180" type="submit">Add Product</button>
				</div>
			</form>

			<script>
				// Hàm preview hình ảnh khi người dùng chọn ảnh
				function previewImage(input, previewId) {
					var file = input.files[0];
					if (file) {
						var reader = new FileReader();
						reader.onload = function(e) {
							var preview = document.getElementById(previewId);
							preview.src = e.target.result;
							preview.style.display = 'block';
						};
						reader.readAsDataURL(file);
					}
				}

				window.onload = function() {
					// Hiển thị ảnh đã tải lên trong các preview
					var imageTypes = [ 'right', 'left', 'front' ];

					imageTypes.forEach(function(type) {
						var inputElement = document.getElementById(type
								+ 'Image');
						var previewElement = document.getElementById(type
								+ 'Preview');

						if (previewElement && previewElement.src) {
							previewElement.style.display = 'block'; // Hiển thị ảnh nếu đã có
						}

						// Nếu có file được chọn, hiển thị ảnh preview ngay lập tức
						if (inputElement.files && inputElement.files[0]) {
							previewImage(inputElement, type + 'Preview');
						}
					});
				};
			</script>


		</div>
	</div>
</div>
