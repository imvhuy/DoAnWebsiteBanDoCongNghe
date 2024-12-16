<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!-- preload -->
<div class="preload preload-container">
	<div class="preload-logo">
		<div class="spinner"></div>
	</div>
</div>
<!-- /preload -->
<div id="wrapper">
	<!-- page-title -->
	<div class="tf-page-title">
		<div class="container-full">
			<div class="heading text-center">Check Out</div>
		</div>
	</div>
	<!-- /page-title -->

	<!-- page-cart -->
	<section class="flat-spacing-11">
		<div class="container">
			<div class="tf-page-cart-wrap layout-2">
				<div class="tf-page-cart-item">
					<h5 class="fw-5 mb_20">Billing details</h5>
					<form class="form-checkout">
						<fieldset class="box fieldset">
							<div class="select-custom">
								<label for="address">Address</label>
								<select id="address-select" name="address" class="tf-select w-100" onchange="updateHiddenAddress()">
									<c:forEach var="address" items="${addresses}">
										<option value="${address.id}">Name: ${address.fullName}, Phone: ${address.phone}, Address: ${address.address}</option>
									</c:forEach>
								</select>
							</div>
						</fieldset>
					</form>
					<a href="/profile/address/${pageContext.request.userPrincipal.name}">
						<button name="addAddress"
								class="tf-btn radius-3 btn-fill btn-icon animate-hover-btn justify-content-center">
							Add Address
						</button>
					</a>
				</div>
				<div class="tf-page-cart-footer">
					<div class="tf-cart-footer-inner">
						<h5 class="fw-5 mb_20">Your order</h5>
						<form class="tf-page-cart-checkout widget-wrap-checkout">

							<ul class="wrap-checkout-product">
								<c:set var="totalAmount" value="0" />
								<!-- Khởi tạo tổng ban đầu -->
								<c:forEach var="cartProduct" items="${cartProducts}">
									<!-- Cập nhật tổng giá trị sản phẩm -->
									<c:set var="totalAmount">
										<c:choose>
											<c:when test="${not empty cartProduct.promotionalPrice}">
												${totalAmount + (cartProduct.promotionalPrice * cartProduct.quantity)}
											</c:when>
											<c:otherwise>
												${totalAmount + (cartProduct.price * cartProduct.quantity)}
											</c:otherwise>
										</c:choose>
									</c:set>

									<li class="checkout-product-item">
										<figure class="img-product">
											<img src="/admin/images/products/${cartProduct.image}"
												 alt="product">
											<span class="quantity">${cartProduct.quantity }</span>
										</figure>
										<div class="content">
											<div class="info">
												<p class="name">${cartProduct.name }</p>
											</div>
											<span class="price"> <c:choose>
												<c:when test="${not empty cartProduct.promotionalPrice}">
													<fmt:formatNumber
															value="${cartProduct.promotionalPrice * cartProduct.quantity}"
															type="number" maxFractionDigits="0" />
												</c:when>
												<c:otherwise>
													<fmt:formatNumber
															value="${cartProduct.price * cartProduct.quantity}"
															type="number" maxFractionDigits="0" />
												</c:otherwise>
											</c:choose> VND
											</span>

										</div>
									</li>
								</c:forEach>
							</ul>
							<div class="coupon-box">
								<select id="coupon-select" name="coupon-select"
										class="tf-select w-100">
									<option value=0 data-discount=""></option>
									<c:forEach var="voucher" items="${vouchers}">
										<option value="${voucher.id}"
												data-discount="${voucher.discount}"
												<c:if test="${voucher.minimumPrice > totalAmount}">disabled</c:if>>
												${voucher.description}-${voucher.discount}</option>
									</c:forEach>
								</select>
								<!-- <input type="text" placeholder="Discount code"> -->
								<button type="button" onclick="applyDiscount()"
										class="tf-btn btn-sm radius-3 btn-fill btn-icon animate-hover-btn">Apply</button>
							</div>
							<!-- Danh sách carriers -->
							<div class="coupon-box">
								<select id="carrier-select" name="carrier-select"
										class="tf-select w-100">
									<c:forEach var="carrier" items="${carrieres}"
											   varStatus="status">
										<option value="${carrier.id}" data-price="${carrier.price}"
											${status.first ? 'selected' : ''}>${carrier.name}</option>
									</c:forEach>
								</select> <span class="total fw-5" id="shippingFee"> <fmt:formatNumber
									value="${carrieres[0].price + 50000}" type="number"
									maxFractionDigits="0" /> VND
								</span>
							</div>
							<div class="d-flex justify-content-between line pb_20">
								<h6 class="fw-5">Total</h6>
								<h6 class="total fw-5" id="total">
									<fmt:formatNumber
											value="${totalAmount + carrieres[0].price + 50000}"
											type="number" maxFractionDigits="0" />
									VND
								</h6>
								<input type="hidden" name="totalPrice"
									   value="${totalAmount + carrieres[0].price + 50000}">
							</div>

							<div class="wd-check-payment">
								<div class="fieldset-radio mb_20">
									<input type="radio" name="payment" id="bank" class="tf-check"
										   checked value="bank"> <label for="bank">Direct
									bank transfer</label>

								</div>
								<div class="fieldset-radio mb_20">
									<input type="radio" name="payment" id="delivery"
										   class="tf-check" value="cash"> <label for="delivery">Cash
									on delivery</label>
								</div>
								<p class="text_black-2 mb_20">
									Your personal data will be used to process your order, support
									your experience throughout this website, and for other purposes
									described in our <a href="privacy-policy.html"
														class="text-decoration-underline">privacy policy</a>.
								</p>
								<div class="box-checkbox fieldset-radio mb_20">
									<input type="checkbox" id="check-agree" class="tf-check">
									<label for="check-agree" class="text_black-2">I have
										read and agree to the website <a href="terms-conditions.html"
																		 class="text-decoration-underline">terms and conditions</a>.
									</label>
								</div>
							</div>
							<!-- Các trường dữ liệu bạn muốn gửi, ví dụ như địa chỉ -->
							<input type="hidden" id="address-hidden" name="address" value=1>
							<input type="hidden" id="voucher-hidden" name="voucher">
							<button name="submitOrder"
									class="tf-btn radius-3 btn-fill btn-icon animate-hover-btn justify-content-center">Place
								order</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- page-cart -->

</div>

<!-- gotop -->
<div class="progress-wrap">
	<svg class="progress-circle svg-content" width="100%" height="100%"
		 viewBox="-1 -1 102 102">
		<path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"
			  style="transition: stroke-dashoffset 10ms linear 0s; stroke-dasharray: 307.919, 307.919; stroke-dashoffset: 286.138;"></path>
	</svg>
</div>
<!-- /gotop -->

<!-- toolbar-bottom -->
<div class="tf-toolbar-bottom type-1150">
	<div class="toolbar-item">
		<a href="#toolbarShopmb" data-bs-toggle="offcanvas"
		   aria-controls="offcanvasLeft">
			<div class="toolbar-icon">
				<i class="icon-shop"></i>
			</div>
			<div class="toolbar-label">Shop</div>
		</a>
	</div>

	<div class="toolbar-item">
		<a href="#canvasSearch" data-bs-toggle="offcanvas"
		   aria-controls="offcanvasLeft">
			<div class="toolbar-icon">
				<i class="icon-search"></i>
			</div>
			<div class="toolbar-label">Search</div>
		</a>
	</div>
	<div class="toolbar-item">
		<a href="#login" data-bs-toggle="modal">
			<div class="toolbar-icon">
				<i class="icon-account"></i>
			</div>
			<div class="toolbar-label">Account</div>
		</a>
	</div>
	<div class="toolbar-item">
		<a href="wishlist.html">
			<div class="toolbar-icon">
				<i class="icon-heart"></i>
				<div class="toolbar-count">0</div>
			</div>
			<div class="toolbar-label">Wishlist</div>
		</a>
	</div>
	<div class="toolbar-item">
		<a href="#shoppingCart" data-bs-toggle="modal">
			<div class="toolbar-icon">
				<i class="icon-bag"></i>
				<div class="toolbar-count">1</div>
			</div>
			<div class="toolbar-label">Cart</div>
		</a>
	</div>
</div>
<!-- /toolbar-bottom -->







<script>
	document
			.getElementById("carrier-select")
			.addEventListener(
					"change",
					function() {
						const selectedOption = this.options[this.selectedIndex]; // Lấy option được chọn
						var shippingFee = parseFloat(selectedOption
								.getAttribute("data-price")) || 0; // Lấy phí vận chuyển (hoặc 0 nếu không có)

						//Lấy tổng tiền của đơn hàng sau khi áp dụng discount( nếu có)
						// Lấy giá trị của data-discount từ tùy chọn
						// Lấy phần tử <select>
						const couponSelect = document
								.getElementById('coupon-select');
						console.log("couponSelect :", couponSelect);
						console.log("selectedIndex :",
								couponSelect.selectedIndex);
						// Lấy tùy chọn đang được chọn
						const selectedCouponOption = couponSelect.options[couponSelect.selectedIndex];
						console.log("selectedCouponOption :",
								selectedCouponOption);
						var discount = 0;
						if (selectedCouponOption != null) {
							discount = parseInt(selectedCouponOption
									.getAttribute('data-discount'));
						}
						if (isNaN(discount))
						{
							discount = 0;
						}

						// Lấy giá trị Total hiện tại (biến totalAmount đã được tính toán ở phần jsp trên khi lặp qua danh
						//sách cart items)
						const totalAmount = "${totalAmount}";
						console.log("totalAmount : ", totalAmount);
						// Tính toán tổng mới sau khi áp dụng giảm giá
						const discountAmount = (totalAmount * discount) / 100;
						console.log("discount : ", discount);
						console.log("discountAmount : ", discountAmount);
						//Tổng tiền khi chưa có phí ship
						const currentTotal = totalAmount - discountAmount;

						//Lấy phần tử chứa tổng tiền
						const totalElement = document.getElementById("total");
						//cộng thêm tiền lộ phí :v
						shippingFee = shippingFee + 50000;
						// Tính tổng mới (cả phí ship)
						const newTotal = currentTotal + shippingFee;
						console.log("currentTotal : ", currentTotal);
						console.log("shippingFee : ", shippingFee);
						// Cập nhật giá trị trong h6
						document.getElementById("shippingFee").innerHTML = shippingFee
										.toLocaleString()
								+ " VND";
						document.getElementById("total").innerHTML = newTotal
										.toLocaleString()
								+ " VND";
					});

	//hàm update giá trị của address-hidden  khi người dùng select address
	function updateHiddenAddress() {
		// Lấy giá trị từ thẻ <select>
		const selectedAddress = document.getElementById("address-select").value;
		// Gán giá trị này vào thẻ <input hidden>
		document.getElementById("address-hidden").value = selectedAddress;
	}

	function applyDiscount() {
		// Lấy phần tử <select>
		const couponSelect = document.getElementById('coupon-select');
		const carrierSelect = document.getElementById('carrier-select');
		// Lấy tùy chọn đang được chọn
		// Lấy phần tử <select>
		const selectedOption = couponSelect.options[couponSelect.selectedIndex];
		// Kiểm tra nếu không có tùy chọn nào được chọn hoặc tùy chọn bị disabled
		if (!selectedOption || selectedOption.disabled) {
			alert('Please select a valid coupon!');
			return;
		}
		//lấy tiền shi]p
		const selectedCarrierOption = carrierSelect.options[carrierSelect.selectedIndex];
		var shippingFee = parseInt(selectedCarrierOption.getAttribute('data-price')) + 50000;
		// Lấy giá trị của data-discount từ tùy chọn
		var discount = parseInt(selectedOption.getAttribute('data-discount'));
		console.log("discount : ",discount);
		if (isNaN(discount))
		{
			discount = 0;
		}

		// Lấy giá trị Total hiện tại (biến totalAmount đã được tính toán ở phần jsp trên khi lặp qua danh
		//sách cart items)
		const totalAmount = "${totalAmount}";
		//console.log("Total Amount from JSP:", totalAmount);
		const totalElement = document.getElementById('total');

		//let currentTotal = parseFloat(totalElement.textContent.replace('VND', '').trim().replace(',', ''));
		let currentTotal = totalAmount;

		// Tính toán tổng mới sau khi áp dụng giảm giá
		const discountAmount = (currentTotal * discount) / 100;
		console.log("discountAmount : ",discountAmount);
		const newTotal = currentTotal - discountAmount + shippingFee;

		// Cập nhật Total trên giao diện
		totalElement.innerHTML = newTotal.toLocaleString() + " VND";
		//console.log('totalElement.innerHTML : ',totalElement.innerHTML );
	}

	document.addEventListener("DOMContentLoaded", function() {
		const placeOrderBtn = document.querySelector('button[name="submitOrder"]');
		const paymentMethodRadios = document.querySelectorAll('input[name="payment"]');

		placeOrderBtn.addEventListener('click', function(e) {
			e.preventDefault();  // Ngừng gửi form thông qua submit thông thường

			const paymentMethod = [...paymentMethodRadios].find(radio => radio.checked).value;
			//const totalPrice = document.querySelector('input[name="totalPrice"]').value;
			//Lấy phần tử chứa tổng tiền
			const totalElement  = document.getElementById("total");
			const totalText = totalElement.textContent.trim(); // Lấy nội dung text và loại bỏ khoảng trắng thừa
			// Loại bỏ 'VND' và chuyển đổi giá trị thành số
			console.log("totalText : ",totalText);
			let cleanedString = totalText.replace('VND', '').replaceAll(',', '').replace(/\./g, "");
			const totalPrice = Number(cleanedString); // Loại bỏ 'VND' và dấu phẩy

			console.log("texttt : ",totalText.replace('VND', '').replaceAll(',', ''));
			console.log("totalPrice : ",totalPrice);
			//const voucher = document.querySelector('input[name="voucher"]').value;
			// Lấy phần tử <select>
			const couponSelect = document.getElementById('coupon-select');
			const selectedCouponOption = couponSelect.options[couponSelect.selectedIndex];
			var voucher = parseInt(selectedCouponOption.value);
			//console.log("voucher : ", voucher);
			const address = document.querySelector('input[name="address"]').value;
			//const carrierId = document.querySelector('select[name="carrier-select"]').value;
			const carrierSelect = document.getElementById('carrier-select');
			const selectedCarrierOption = carrierSelect.options[carrierSelect.selectedIndex];
			var carrierId = parseInt(selectedCarrierOption.value);


			if (paymentMethod === 'bank') {
				console.log('bank');
				console.log({
					address,
					carrierId,
					paymentMethod,
					voucher
				});
				// Gửi yêu cầu API thanh toán
				const paymentDTO = {
					totalPrice, voucher, address, paymentMethod, carrierId
				};

				fetch('/api/payment/create-payment', {
					method: 'POST',
					headers: {'Content-Type': 'application/json'},
					body: JSON.stringify(paymentDTO),
				})
						.then(response => response.json())
						.then(data => {
							if (data.success) window.location.href = data.paymentUrl;
							else alert('Payment failed');
						})
						.catch(() => alert('Error processing payment'));
			} else if (paymentMethod === 'cash') {
				console.log("cashhhhhhhhhh12222 : ");
				console.log({
					address,
					carrierId,
					paymentMethod,
					voucher
				});

				// Gửi yêu cầu POST đến controller
				$.ajax({
					url: '/user/cart/checkout/placeOrder',
					type: 'POST',
					data: {
						address: address,
						'carrier-select': carrierId,
						payment: paymentMethod,
						'coupon-select': voucher
					},
					success: function(response) {
						alert('Đặt hàng thành công')
						window.location.href = '${pageContext.request.contextPath}/profile/checkorderlist/${username}';
					},
					error: function(xhr, status, error) {
						console.error('Error:', error);
						alert('Không tìm thấy địa chỉ của bạn.');
					}
				});
			}

		});
	});


	// Hàm kiểm tra và xử lý khi trang load
	window.onload = function() {
		var addressSelect = document.getElementById("address-select");
		//var noAddressMessage = document.getElementById("no-address-message");

		// Kiểm tra xem có option nào không
		if (addressSelect.options.length === 0) {
			// Nếu không có option, hiển thị thông báo
			alert("Vui lòng thêm địa chi");

			// Sau 3 giây, điều hướng tới một controller khác
			setTimeout(function() {
				window.location.href = '${pageContext.request.contextPath}/profile/address/${username}';  // Thay '/your-controller-url' bằng URL controller của bạn
			}, 3000);  // 3000 ms = 3 giây
		}
	};
</script>
