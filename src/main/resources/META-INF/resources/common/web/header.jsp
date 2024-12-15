
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="websocket/css/main.css" />	
<!-- Top bar -->
<div class="tf-top-bar bg_dark line">
	<div class="px_15 lg-px_40">
		<div class="tf-top-bar_wrap grid-3 gap-30 align-items-center">
			<div class="tf-top-bar_left">
				<div class="d-flex gap-30 text_white fw-5 ">
					<span></span>
				</div>
			</div>
			<div class="text-center overflow-hidden">
				<div class="swiper tf-sw-top_bar" data-preview="1" data-space="0"
					data-loop="true" data-speed="1000" data-delay="2000">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<p class="top-bar-text fw-5 text_white">Welcome to store.
								Fantastic theme! Beautifully designed</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /Top bar -->
<style>/* Search form in navigation */
.search-bar {
	display: flex;
	align-items: center;
}

.search-form {
	display: flex;
	align-items: center;
}

.search-form input {
	border: 1px solid #ccc;
	padding: 5px 10px;
	border-radius: 4px 0 0 4px;
	outline: none;
	width: 350px;
}

.search-form button {
	background-color: transparent;
	border: none;
	padding: 5px 10px;
	border-radius: 0 4px 4px 0;
	cursor: pointer;
}

.search-form button i {
	font-size: 1.2em;
}

/* Container chính */
.menu-container {
	display: flex;
	border: 1px solid #ddd;
	background-color: #fff;
	width: 100%;
	padding: 5px; /* Quá lớn hoặc không cân đối */
	max-width: 1400px;
	margin: 0 auto;
	position: relative;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

#category-list {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex; /* Dùng flexbox để xếp các mục theo chiều ngang */
	gap: 45px; /* Khoảng cách giữa các mục */
}

.category-item {
	display: inline-block;
	font-size: 14px;
	text-align: center;
}

.category-item a {
	color: #333; /* Màu chữ */
	text-decoration: none;
	padding: 5px 10px;
	display: inline-block;
}

.category-item a:hover {
	color: #007bff; /* Màu chữ khi hover */
}

.category-item a:active {
	color: #0056b3; /* Màu chữ khi click */
}

.canvas-search {
	width: 90vw !important; /* Chiếm 90% chiều rộng màn hình */
	max-width: 1000px; /* Giới hạn tối đa */
	height: 90vh; /* Chiều cao động */
	max-height: 100vh;
	padding-top: 55px;
	margin: auto;
	top: 5%; /* Căn giữa màn hình */
	left: 50%;
	transform: translateX(-50%);
	border: 0 !important;
	overflow-y: auto; /* Cuộn khi cần */
}

.canvas-search {
	opacity: 0;
	visibility: hidden;
	transform: translateY(-50px) translateX(-50%);
	transition: all 0.4s ease;
}

.canvas-search.show {
	opacity: 1;
	visibility: visible;
	transform: translateY(0) translateX(-50%);
}

.tf-search-head .title {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.tf-search-content {
	padding: 20px;
}

.tf-loop-item {
	margin-bottom: 20px;
}

.tf-quicklink-list {
	display: flex;
	gap: 15px;
	flex-wrap: wrap;
}
</style>
<!-- Header -->
<header id="header" class="header-default">
	<div class="px_15 lg-px_40">
		<div class="row wrapper-header align-items-center"
			style="height: 90px;">
			<div class="col-xl-2 col-md-4 col-6 text-center">
				<a href="/home" class="logo-header"> <img
					src="/web/images/logo/logo.jpg" alt="logo" class="logo"
					style="max-height: 40px;">
				</a>
			</div>

			<!-- Mobile Menu Icon -->
			<div class="col-md-4 col-3 tf-lg-hidden">
				<a href="#mobileMenu" data-bs-toggle="offcanvas"
					aria-controls="offcanvasLeft"> <!-- SVG icon for mobile menu -->
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="16"
						viewBox="0 0 24 16" fill="none">
                        <path
							d="M2.00056 2.28571H16.8577C17.1608 2.28571 17.4515 2.16531 17.6658 1.95098C17.8802 1.73665 18.0006 1.44596 18.0006 1.14286C18.0006 0.839753 17.8802 0.549063 17.6658 0.334735C17.4515 0.120408 17.1608 0 16.8577 0H2.00056C1.69745 0 1.40676 0.120408 1.19244 0.334735C0.978109 0.549063 0.857702 0.839753 0.857702 1.14286C0.857702 1.44596 0.978109 1.73665 1.19244 1.95098C1.40676 2.16531 1.69745 2.28571 2.00056 2.28571ZM0.857702 8C0.857702 7.6969 0.978109 7.40621 1.19244 7.19188C1.40676 6.97755 1.69745 6.85714 2.00056 6.85714H22.572C22.8751 6.85714 23.1658 6.97755 23.3801 7.19188C23.5944 7.40621 23.7148 7.6969 23.7148 8C23.7148 8.30311 23.5944 8.59379 23.3801 8.80812C23.1658 9.02245 22.8751 9.14286 22.572 9.14286H2.00056C1.69745 9.14286 1.40676 9.02245 1.19244 8.80812C0.978109 8.59379 0.857702 8.30311 0.857702 8ZM0.857702 14.8571C0.857702 14.554 0.978109 14.2633 1.19244 14.049C1.40676 13.8347 1.69745 13.7143 2.00056 13.7143H12.2863C12.5894 13.7143 12.8801 13.8347 13.0944 14.049C13.3087 14.2633 13.4291 14.554 13.4291 14.8571C13.4291 15.1602 13.3087 15.4509 13.0944 15.6653C12.8801 15.8796 12.5894 16 12.2863 16H2.00056C1.69745 16 1.40676 15.8796 1.19244 15.6653C0.978109 15.4509 0.857702 15.1602 0.857702 14.8571Z"
							fill="currentColor"></path>
                    </svg>
				</a>
			</div>

			<!-- Navigation Menu -->
			<div class="col-xl-5 tf-md-hidden">
				<nav class="box-navigation text-center">
					<ul class="box-nav-ul d-flex align-items-center gap-30">
						<li class="menu-item"><a href="#" class="item-link"
							style="font-size: 14px; padding: 5px 10px;">Home<i
								class="icon icon-arrow-down"></i></a>
							<div class="sub-menu mega-menu">
								<div class="container">
									<div class="row-demo">
										<div class="demo-item">
											<a href="index.html">
												<div class="demo-image position-relative">
													<img class="lazyload"
														data-src="/web/images/demo/home-01.jpg"
														src="/web/images/demo/home-01.jpg" alt="home-01">
													<div class="demo-label">
														<span class="demo-new">New</span> <span>Trend</span>
													</div>
												</div> <span class="demo-name">Home Fashion 01</span>
											</a>
										</div>
									</div>
								</div>
								<!-- Submenu content -->
							</div></li>
						<li class="menu-item"><a href="#" class="item-link"
							style="font-size: 14px; padding: 5px 10px;">Showroom<i
								class="icon icon-arrow-down"></i></a>
							<div class="sub-menu mega-menu">
								<!-- Submenu content -->
							</div></li>
						<li class="menu-item"><a href="#" class="item-link"
							style="font-size: 14px; padding: 5px 10px;">Category<i
								class="icon icon-arrow-down"></i></a>
							<div class="sub-menu mega-menu"
								style="padding-top: 0px; top: 90px;">
								<div class="menu-container">
									<!-- Danh sách danh mục bên trái -->
									<div class="menu-left">
										<ul class="categories" id="category-list">

										</ul>
									</div>
								</div>
							</div></li>


						<li class="menu-item search-bar">
							<form class="search-form" action="search-results.html"
								method="get" style="padding: 0 10px;">
								<input type="text" placeholder="Search..."
									onclick="openCanvasSearch()" class="form-control">
							</form>
						</li>
						<li class="menu-item position-relative"><a href="#"
							class="item-link" style="font-size: 14px; padding: 5px 10px;">Pages<i
								class="icon icon-arrow-down"></i></a>
							<div class="sub-menu submenu-default">
								<!-- Submenu content -->
							</div></li>
						<li class="menu-item position-relative"><a
							href="vendor/manage-store" class="item-link"
							style="font-size: 14px; padding: 5px 10px;">Store</a></li>
					</ul>
				</nav>
			</div>

			<!-- Icons for Account, Wishlist, Cart -->
			<div class="col-xl-5 col-md-4 col-3">
				<ul
					class="nav-icon d-flex justify-content-end align-items-center gap-20">

					<!-- Nút Live Chat nằm sát mép phải -->
					<div>
						<div class="footer-newsletter footer-col-block">
							<button type="button"
								class=" tf-btn btn-sm radius-3 btn-fill btn-icon btn-icon animate-hover-btn
					     live-chat-btn"
								data-bs-toggle="modal" data-bs-target="#chatModal">
								Chat with us</button>
						</div>
					</div>

					<!-- Kiểm tra nếu người dùng đã đăng nhập -->
					<li class="nav-account"><c:choose>
							<c:when test="${pageContext.request.userPrincipal != null}">
								<div class="dropdown">
									<a href="#" class="nav-icon-item dropdown-toggle"
										id="userDropdown" data-bs-toggle="dropdown"
										aria-expanded="false" style="font-size: 14px; padding: 3px;">
										<i class="icon icon-account"></i> <span>${pageContext.request.userPrincipal.name}</span>
									</a>
									<ul class="dropdown-menu dropdown-menu-end"
										aria-labelledby="userDropdown">
										<li><a class="dropdown-item"
											href="<c:url value='/profile/${pageContext.request.userPrincipal.name}'/>">Profile</a>
										</li>
										<li><a class="dropdown-item"
											href="/profile/checkorderlist/${pageContext.request.userPrincipal.name}">My
												Orders</a></li>
										<li><a class="dropdown-item" href="/settings">Settings</a></li>
										<li>
											<hr class="dropdown-divider">
										</li>
										<li><a class="dropdown-item"
											href="<c:url value='/logout' />">Logout</a></li>
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<a href="#login" data-bs-toggle="modal" class="nav-icon-item"
									style="font-size: 16px; padding: 3px;"> <i
									class="icon icon-account"></i>
								</a>
							</c:otherwise>
						</c:choose></li>

					<!-- Các phần khác: wishlist, cart -->
					<li class="nav-wishlist"><a href="wishlist.html"
						class="nav-icon-item" style="font-size: 16px; padding: 3px;">
							<i class="icon icon-heart"></i><span class="count-box bg-dark"
							style="font-size: 10px; width: 16px; height: 16px;">0</span>
					</a></li>
					<li class="nav-cart"><a href="#shoppingCart"
						data-bs-toggle="modal" class="nav-icon-item"
						style="font-size: 16px; padding: 3px;"> <i
							class="icon icon-bag"></i><span class="count-box bg-dark"
							style="font-size: 10px; width: 16px; height: 16px;">2</span>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
</header>
<!-- /Header -->

<!-- canvasSearch -->
<div class="offcanvas offcanvas-end canvas-search" id="canvasSearch"
	style="width: 100% !important; max-width: 1000px; padding-top: 55px; margin: 0 auto; top: 20px; left: 0; border: 0 !important; transform: none;">
	<div class="canvas-wrapper">
		<header class="tf-search-head">
			<div class="title fw-5">
				Search our site
				<div class="close">
					<span class="icon-close icon-close-popup"
						data-bs-dismiss="offcanvas" aria-label="Close"></span>
				</div>
			</div>
			<div class="tf-search-sticky">
				<form action="${pageContext.request.contextPath}/products"
					class="tf-mini-search-frm" id="searchForm">
					<fieldset class="text">
						<input type="text" placeholder="Search" name="text"
							id="searchInput" required>
					</fieldset>
					<button class="" type="submit">
						<i class="icon-search"></i>
					</button>
				</form>
			</div>
		</header>
		<div class="canvas-body p-0">
			<div class="tf-search-content">
				<div class="tf-cart-hide-has-results">
					<div class="tf-col-quicklink">
						<div class="tf-search-content-title fw-5">Quick link</div>
						<ul class="tf-quicklink-list" id="quick-link">
							<!-- Danh sách danh mục sẽ được thêm vào đây -->
						</ul>
					</div>
					<div class="tf-col-content">
						<div class="tf-search-content-title fw-5">Need some
							inspiration?</div>
						<div class="tf-search-hidden-inner" id="product-suggestions">
							<!-- Các sản phẩm gợi ý sẽ được chèn vào đây -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /canvasSearch -->
<!-- modal login -->
<div class="modal modalCentered fade form-sign-in modal-part-content"
	id="login">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="header">
				<div class="demo-title">Log in</div>
				<span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
			</div>
			<div class="tf-login-form">
				<form class="" action="/login" method="post" accept-charset="utf-8">
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" " type="text"
							id="username" name="username" required> <label
							class="tf-field-label">Username *</label>
					</div>
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" "
							type="password" id="password" name="password" required> <label
							class="tf-field-label">Password *</label>
					</div>
					<div>
						<a href="#forgotPassword" data-bs-toggle="modal"
							class="btn-link link">Forgot your password?</a>
					</div>
					<div class="bottom">
						<div class="w-100">
							<button type="submit"
								class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center">
								<span>Log in</span>
							</button>
						</div>
						<div class="w-100">
							<a href="#register" data-bs-toggle="modal"
								class="btn-link fw-6 w-100 link"> New customer? Create your
								account <i class="icon icon-arrow1-top-left"></i>
							</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="modal modalCentered fade form-sign-in modal-part-content"
	id="forgotPassword">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="header">
				<div class="demo-title">Reset your password</div>
				<span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
			</div>
			<div class="tf-login-form">
				<form class="">
					<div>
						<p>Sign up for early Sale access plus tailored new arrivals,
							trends and promotions. To opt out, click unsubscribe in our
							emails</p>
					</div>
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" "
							type="email" name=""> <label class="tf-field-label">Email
							*</label>
					</div>
					<div>
						<a href="#login" data-bs-toggle="modal" class="btn-link link">Cancel</a>
					</div>
					<div class="bottom">
						<div class="w-100">
							<button type="submit"
								class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center">
								<span>Reset password</span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="modal modalCentered fade form-sign-in modal-part-content"
	id="register">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="header">
				<div class="demo-title">Register</div>
				<span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
			</div>
			<div class="tf-login-form">
				<form class="">
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" " type="text"
							name=""> <label class="tf-field-label">First name</label>
					</div>
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" " type="text"
							name=""> <label class="tf-field-label">Last name</label>
					</div>
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" "
							type="email" name=""> <label class="tf-field-label">Email
							*</label>
					</div>
					<div class="tf-field style-1">
						<input class="tf-field-input tf-input" placeholder=" "
							type="password" name=""> <label class="tf-field-label">Password
							*</label>
					</div>
					<div class="bottom">
						<div class="w-100">
							<a href="register.html"
								class="tf-btn btn-fill animate-hover-btn radius-3 w-100 justify-content-center"><span>Register</span></a>
						</div>
						<div class="w-100">
							<a href="#login" data-bs-toggle="modal"
								class="btn-link fw-6 w-100 link"> Already have an account?
								Log in here <i class="icon icon-arrow1-top-left"></i>
							</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	function openCanvasSearch() {
		const canvasSearch = new bootstrap.Offcanvas(document
				.getElementById('canvasSearch'));
		canvasSearch.show();
	}
</script>

<script type="text/javascript" src="/web/js/jquery.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						// Tải danh sách danh mục từ server
						$
								.ajax({
									url : '/api/categories',
									method : 'GET',
									dataType : 'json',
									success : function(categories) {
										// Hiển thị danh sách danh mục
										categories
												.forEach(function(category) {
													$('#category-list')
															.append(
																	' <li class="category-item" data-category-id="' + category.id + '" data-category-slug="' + category.slug + '">'
																			+ '<a href="/products/' + category.slug + '">'
																			+ category.name
																			+ '</a> </li>');
												});
										categories
												.forEach(function(category) {
													$('#quick-link')
															.append(
																	'<li class="tf-quicklink-item" data-category-id="' + category.id + '" data-category-slug="' + category.slug + '" style="border: 0; border-top: 1px solid #ccc; margin: 10px 0;">'
																			+ '<a href="/products/' + category.slug + '">'
																			+ category.name
																			+ '</a>'
																			+ '</li>');
												});
									},
									error : function(xhr, status, error) {
										console.log("Error:", status, error); // In ra lỗi nếu có
									}
								});
					});
	$(document)
			.ready(
					function() {
						// Lắng nghe sự kiện khi người dùng gõ vào ô tìm kiếm
						$('#searchInput')
								.on(
										'input',
										function() {
											var query = $(this).val(); // Lấy giá trị của ô tìm kiếm

											if (query.length >= 2) {
												// Gọi API tìm kiếm gợi ý sản phẩm
												$
														.ajax({
															url : '/api/products', // Địa chỉ API tìm kiếm
															method : 'GET',
															data : {
																query : query
															},
															success : function(
																	data) {
																var suggestions = '';
																if (data.length > 0) {
																	// Hiển thị sản phẩm gợi ý
																	var limitedProducts = data
																			.slice(
																					0,
																					3);
																	limitedProducts
																			.forEach(function(
																					product) {
																				suggestions += '<div class="tf-loop-item">';
																				suggestions += '<div class="image">';
																				suggestions += '<a href="/products/' + product.id + '">';
																				suggestions += '<img src="' + product.imageUrl + '" alt="' + product.name + '">';
																				suggestions += '</a></div>';
																				suggestions += '<div class="content">';
																				suggestions += '<a href="/products/' + product.id + '">'
																						+ product.name
																						+ '</a>';
																				suggestions += '<div class="tf-product-info-price">';
																				suggestions += '<div class="price fw-6">$'
																						+ product.price
																						+ '</div>';
																				suggestions += '</div></div></div>';
																			});
																} else {
																	suggestions = '<div>No products found</div>';
																}

																// Cập nhật các sản phẩm gợi ý vào phần tử #product-suggestions
																$(
																		'#product-suggestions')
																		.html(
																				suggestions);
															},
														});
											} else {
												// Xóa kết quả gợi ý nếu chuỗi tìm kiếm quá ngắn
												$('#product-suggestions')
														.empty();
											}
										});

					});
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/websocket/js/main.js" defer></script>

<!-- Modal cho Live Chat -->
<!-- Modal cho Live Chat -->
<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <!-- Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="chatModalLabel">Live Chat</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Body -->
            <div class="modal-body">
               <div id="chat-page" class="chat-container" data-username="${pageContext.request.userPrincipal.name}">
                    <!-- Header Chat -->
                    
                    <div class="chat-header">
                        <h5>Welcome, ${pageContext.request.userPrincipal.name}! Start chatting with us!</h5>
                    </div>
                    <!-- Connecting Info -->
                    <div class="connecting">Connecting...</div>
                    <!-- Message Area -->
                    <ul id="messageArea"></ul>
                    <!-- Message Form -->
					<form id="messageForm" name="messageForm" onsubmit="return false;">
					    <div class="form-group">
					        <div class="input-group clearfix">
					            <input type="text" id="message" placeholder="Type your message..." autocomplete="off" class="form-control" />
					            <button type="submit" class="btn btn-dark">Send</button>
					        </div>
					    </div>
					</form>

                </div>
            </div>
        </div>
    </div>
</div>



