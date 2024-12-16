<!-- section-menu-left -->
<div class="section-menu-left">
	<div class="box-logo">
		<a href="${pageContext.request.contextPath}/admin/home" id="site-logo-inner"> <img class=""
			id="logo_header" alt=""
			src="https://themesflat.co/html/ecomus/images/logo/logo.svg"
			data-light="../images/logo/logo.svg"
			data-dark="https://themesflat.co/html/ecomus/images/logo/logo-white.svg">
		</a>
		<div class="button-show-hide">
			<i class="icon-chevron-left"></i>
		</div>
	</div>
	<div class="section-menu-left-wrap">
		<div class="center">
			<div class="center-item">
				<ul class="">
					<li class="menu-item"><a href="${pageContext.request.contextPath}/admin/home" class="">
							<div class="icon">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
									xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
										clip-rule="evenodd"
										d="M12.2652 3.57566C12.1187 3.42921 11.8813 3.42921 11.7348 3.57566L5.25 10.0605V19.8748C5.25 20.0819 5.41789 20.2498 5.625 20.2498H9V16.1248C9 15.0893 9.83947 14.2498 10.875 14.2498H13.125C14.1605 14.2498 15 15.0893 15 16.1248V20.2498H18.375C18.5821 20.2498 18.75 20.0819 18.75 19.8748V10.0605L12.2652 3.57566ZM20.25 11.5605L21.2197 12.5302C21.5126 12.8231 21.9874 12.8231 22.2803 12.5302C22.5732 12.2373 22.5732 11.7624 22.2803 11.4695L13.3258 2.51499C12.5936 1.78276 11.4064 1.78276 10.6742 2.515L1.71967 11.4695C1.42678 11.7624 1.42678 12.2373 1.71967 12.5302C2.01256 12.8231 2.48744 12.8231 2.78033 12.5302L3.75 11.5605V19.8748C3.75 20.9104 4.58947 21.7498 5.625 21.7498H18.375C19.4105 21.7498 20.25 20.9104 20.25 19.8748V11.5605ZM13.5 20.2498H10.5V16.1248C10.5 15.9177 10.6679 15.7498 10.875 15.7498H13.125C13.3321 15.7498 13.5 15.9177 13.5 16.1248V20.2498Z"
										fill="#111111" />
                                </svg>
							</div>
							<div class="text">Ecommerce</div>
					</a></li>

					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<i class="icon-file-plus"></i>
							</div>
							<div class="text">Product</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a
								href="<c:url value = '/admin/products'/>">
									<div class="text">All Products</div>
							</a></li>
							<li class="sub-menu-item"><a
								href="<c:url value = '/admin/products/add'/>">
									<div class="text">Add Product</div>
							</a></li>
						</ul></li>
					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<i class="icon-layers"></i>
							</div>
							<div class="text">Category</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a href="/admin/categories"
								class="">
									<div class="text">Category list</div>
							</a></li>
							<li class="sub-menu-item"><a href="/admin/categories/add"
								class="">
									<div class="text">New category</div>
							</a></li>
						</ul></li>


					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<i class="icon-user"></i>
							</div>
							<div class="text">Users</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a href="/admin/users" class="">
									<div class="text">All user</div>
							</a></li>
							<li class="sub-menu-item"><a href="add-new-user.html"
								class="">
									<div class="text">Add new user</div>
							</a></li>
							<li class="sub-menu-item"><a href="login.html" class="">
									<div class="text">Login</div>
							</a></li>
							<li class="sub-menu-item"><a href="sign-up.html" class="">
									<div class="text">Sign up</div>
							</a></li>
						</ul></li>
					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none"
									viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
									class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
										d="M8.25 18.75a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 0 1-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 0 0-3.213-9.193 2.056 2.056 0 0 0-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 0 0-10.026 0 1.106 1.106 0 0 0-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12" />
</svg>

							</div>
							<div class="text">Carriers</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a href="/admin/carriers" class="">
									<div class="text">All Carriers</div>
							</a></li>
							<li class="sub-menu-item"><a href="/admin/carriers/add"
								class="">
									<div class="text">Add Carriers</div>
							</a></li>
						</ul></li>
					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none"
									viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
									width="24" height="24">
  <path stroke-linecap="round" stroke-linejoin="round"
										d="M13.5 21v-7.5a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 .75.75V21m-4.5 0H2.36m11.14 0H18m0 0h3.64m-1.39 0V9.349M3.75 21V9.349m0 0a3.001 3.001 0 0 0 3.75-.615A2.993 2.993 0 0 0 9.75 9.75c.896 0 1.7-.393 2.25-1.016a2.993 2.993 0 0 0 2.25 1.016c.896 0 1.7-.393 2.25-1.015a3.001 3.001 0 0 0 3.75.614m-16.5 0a3.004 3.004 0 0 1-.621-4.72l1.189-1.19A1.5 1.5 0 0 1 5.378 3h13.243a1.5 1.5 0 0 1 1.06.44l1.19 1.189a3 3 0 0 1-.621 4.72M6.75 18h3.75a.75.75 0 0 0 .75-.75V13.5a.75.75 0 0 0-.75-.75H6.75a.75.75 0 0 0-.75.75v3.75c0 .414.336.75.75.75Z" />
</svg>

							</div>
							<div class="text">Online Stores</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a href="/admin/stores" class="">
									<div class="text">View Store</div>
							</a></li>
						</ul></li>
					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none"
									viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
									class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
										d="M8.25 6.75h12M8.25 12h12m-12 5.25h12M3.75 6.75h.007v.008H3.75V6.75Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0ZM3.75 12h.007v.008H3.75V12Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm-.375 5.25h.007v.008H3.75v-.008Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
</svg>


							</div>
							<div class="text">Promotions</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a href="/admin/promotions"
								class="">
									<div class="text">All Promotion</div>
							</a></li>
							<li class="sub-menu-item"><a href="/admin/promotions/add"
								class="">
									<div class="text">Add Promotion</div>
							</a></li>
						</ul></li>
					<li class="menu-item has-children"><a
						href="javascript:void(0);" class="menu-item-button">
							<div class="icon">
								<svg class="w-6 h-6 text-gray-800 dark:text-white"
									aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
									width="24" height="24" fill="none" viewBox="0 0 24 24">
  <path stroke="currentColor" stroke-linecap="round" stroke-width="1"
										d="M2.9917 4.9834V18.917M9.96265 4.9834V18.917M15.9378 4.9834V18.917m2.9875-13.9336V18.917" />
  <path stroke="currentColor" stroke-linecap="round"
										d="M5.47925 4.4834V19.417m1.9917-14.9336V19.417M21.4129 4.4834V19.417M13.4461 4.4834V19.417" />
</svg>

							</div>
							<div class="text">Commissions</div>
					</a>
						<ul class="sub-menu">
							<li class="sub-menu-item"><a href="/admin/commissions"
								class="">
									<div class="text">All Commissions</div>
							</a></li>
							<li class="sub-menu-item"><a href="/admin/commissions/add"
								class="">
									<div class="text">Add Commissions</div>
							</a></li>
						</ul></li>
<%--					<li class="menu-item"><a href="report.html" class="">--%>
<%--							<div class="icon">--%>
<%--								<i class="icon-pie-chart"></i>--%>
<%--							</div>--%>
<%--							<div class="text">Report</div>--%>
<%--					</a></li>--%>

				</ul>
			</div>
		</div>
	</div>
</div>

<script>

document.addEventListener('DOMContentLoaded', function() {
    // Lấy URL hiện tại của trang
    const currentPath = window.location.pathname;
    
    // Lấy tất cả các liên kết trong thanh menu (cả menu chính và sub-menu)
    const menuLinks = document.querySelectorAll('.menu-item a');
    
    // Duyệt qua tất cả các liên kết để tìm liên kết nào khớp với URL hiện tại
    menuLinks.forEach(link => {
        const linkHref = link.getAttribute('href');

        // Nếu URL hiện tại hoàn toàn khớp với href của liên kết
        if (currentPath === linkHref) {
            // Tắt tất cả các mục đang active
            menuLinks.forEach(link => {
                link.classList.remove('active');
            });

            // Đánh dấu mục hiện tại là active
            link.classList.add('active');
            
            // Nếu mục này có sub-menu, mở sub-menu đó
            const subMenu = link.closest('.menu-item').querySelector('.sub-menu');
            if (subMenu) {
                subMenu.classList.add('show');
            }

            // Đánh dấu mục cha (ví dụ: "Product", "Users") là active nếu có sub-menu
            const parentMenuItem = link.closest('.menu-item.has-children');
            if (parentMenuItem) {
                parentMenuItem.classList.add('active');
            }

            return; // Dừng vòng lặp khi đã tìm thấy mục phù hợp
        } 

        // Nếu đường dẫn hiện tại chứa URL của liên kết (sub-menu)
        else if (currentPath.includes(linkHref)) {
            link.classList.add('active');
            
            // Nếu mục này có sub-menu, mở sub-menu đó
            const subMenu = link.closest('.menu-item').querySelector('.sub-menu');
            if (subMenu) {
                subMenu.classList.add('show');
            }

            // Đánh dấu mục cha (ví dụ: "Product", "Users") là active nếu có sub-menu
            const parentMenuItem = link.closest('.menu-item.has-children');
            if (parentMenuItem) {
                parentMenuItem.classList.add('active');
            }
        }
    });
});








</script>



<!-- /section-menu-left -->
<div class="section-content-right">
	<!-- header-dashboard -->
	<div class="header-dashboard">
		<div class="wrap">
			<div class="header-left">
				<a href="index.html"> <img class="" id="logo_header_mobile"
					alt="" src="https://themesflat.co/html/ecomus/images/logo/logo.svg"
					data-light="../images/logo/logo.svg"
					data-dark="https://themesflat.co/html/ecomus/images/logo/logo-white.svg">
				</a>
				<div class="button-show-hide">
					<i class="icon-chevron-left"></i>
				</div>
				<form class="form-search flex-grow">
					<fieldset class="name">
						<input type="text" placeholder="Search" class="show-search"
							name="name" tabindex="2" value="" aria-required="true"
							required="">
					</fieldset>
					<div class="button-submit">
						<button class="" type="submit">
							<i class="icon-search"></i>
						</button>
					</div>
					<div class="box-content-search" id="box-content-search">
						<ul class="mb-24">
							<li class="mb-14">
								<div class="body-title">Top selling product</div>
							</li>
							<li class="mb-14">
								<div class="divider"></div>
							</li>
							<li>
								<ul>
									<li class="product-item gap14 mb-10">
										<div class="image no-bg">
											<img src="images/products/product-1.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">Neptune
													Longsleeve</a>
											</div>
										</div>
									</li>
									<li class="mb-10">
										<div class="divider"></div>
									</li>
									<li class="product-item gap14 mb-10">
										<div class="image no-bg">
											<img src="images/products/product-2.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">Ribbed
													Tank Top</a>
											</div>
										</div>
									</li>
									<li class="mb-10">
										<div class="divider"></div>
									</li>
									<li class="product-item gap14">
										<div class="image no-bg">
											<img src="images/products/product-3.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">Ribbed
													modal T-shirt</a>
											</div>
										</div>
									</li>
								</ul>
							</li>
						</ul>
						<ul class="">
							<li class="mb-14">
								<div class="body-title">Order product</div>
							</li>
							<li class="mb-14">
								<div class="divider"></div>
							</li>
							<li>
								<ul>
									<li class="product-item gap14 mb-10">
										<div class="image no-bg">
											<img src="images/products/product-4.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">Oversized
													Motif T-shirt</a>
											</div>
										</div>
									</li>
									<li class="mb-10">
										<div class="divider"></div>
									</li>
									<li class="product-item gap14 mb-10">
										<div class="image no-bg">
											<img src="images/products/product-5.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">V-neck
													linen T-shirt</a>
											</div>
										</div>
									</li>
									<li class="mb-10">
										<div class="divider"></div>
									</li>
									<li class="product-item gap14 mb-10">
										<div class="image no-bg">
											<img src="images/products/product-6.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">Jersey
													thong body</a>
											</div>
										</div>
									</li>
									<li class="mb-10">
										<div class="divider"></div>
									</li>
									<li class="product-item gap14">
										<div class="image no-bg">
											<img src="images/products/product-7.jpg" alt="">
										</div>
										<div class="flex items-center justify-between gap20 flex-grow">
											<div class="name">
												<a href="product-list.html" class="body-text">Jersey
													thong body</a>
											</div>
										</div>
									</li>
								</ul>
							</li>
						</ul>
					</div>
				</form>
			</div>
			<div class="header-grid">
				<div class="header-item country">
					<select class="image-select no-text">
						<option data-thumbnail="images/country/1.png">ENG</option>
						<option data-thumbnail="images/country/9.png">VIE</option>
					</select>
				</div>
				<div class="header-item button-dark-light">
					<i class="icon-moon"></i>
				</div>
				<div class="popup-wrap noti type-header">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="dropdownMenuButton1" data-bs-toggle="dropdown"
							aria-expanded="false">
							<span class="header-item"> <span class="text-tiny">1</span>
								<i class="icon-bell"></i>
							</span>
						</button>
						<ul class="dropdown-menu dropdown-menu-end has-content"
							aria-labelledby="dropdownMenuButton1">
							<li>
								<h6>Notifications</h6>
							</li>
							<li>
								<div class="noti-item w-full wg-user active">
									<div class="image">
										<img src="images/customers/customer-1.jpg" alt="">
									</div>
									<div class="flex-grow">
										<div class="flex items-center justify-between">
											<a href="#" class="body-title">Cameron Williamson</a>
											<div class="time">10:13 PM</div>
										</div>
										<div class="text-tiny">Hello?</div>
									</div>
								</div>
							</li>
							<li>
								<div class="noti-item w-full wg-user active">
									<div class="image">
										<img src="images/customers/customer-2.jpg" alt="">
									</div>
									<div class="flex-grow">
										<div class="flex items-center justify-between">
											<a href="#" class="body-title">Ralph Edwards</a>
											<div class="time">10:13 PM</div>
										</div>
										<div class="text-tiny">Are you there? interested i
											this...</div>
									</div>
								</div>
							</li>
							<li>
								<div class="noti-item w-full wg-user active">
									<div class="image">
										<img src="images/customers/customer-3.jpg" alt="">
									</div>
									<div class="flex-grow">
										<div class="flex items-center justify-between">
											<a href="#" class="body-title">Eleanor Pena</a>
											<div class="time">10:13 PM</div>
										</div>
										<div class="text-tiny">Interested in this loads?</div>
									</div>
								</div>
							</li>
							<li>
								<div class="noti-item w-full wg-user active">
									<div class="image">
										<img src="images/customers/customer-1.jpg" alt="">
									</div>
									<div class="flex-grow">
										<div class="flex items-center justify-between">
											<a href="#" class="body-title">Jane Cooper</a>
											<div class="time">10:13 PM</div>
										</div>
										<div class="text-tiny">Okay...Do we have a deal?</div>
									</div>
								</div>
							</li>
							<li><a href="#" class="tf-button w-full">View all</a></li>
						</ul>
					</div>
				</div>
				<div class="popup-wrap message type-header">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="dropdownMenuButton2" data-bs-toggle="dropdown"
							aria-expanded="false">
							<span class="header-item"> <span class="text-tiny">1</span>
								<i class="icon-message-square"></i>
							</span>
						</button>
						<ul class="dropdown-menu dropdown-menu-end has-content"
							aria-labelledby="dropdownMenuButton2">
							<li>
								<h6>Message</h6>
							</li>
							<li>
								<div class="message-item item-1">
									<div class="image">
										<i class="icon-noti-1"></i>
									</div>
									<div>
										<div class="body-title-2">Discount available</div>
										<div class="text-tiny">Morbi sapien massa, ultricies at
											rhoncus at, ullamcorper nec diam</div>
									</div>
								</div>
							</li>
							<li>
								<div class="message-item item-2">
									<div class="image">
										<i class="icon-noti-2"></i>
									</div>
									<div>
										<div class="body-title-2">Account has been verified</div>
										<div class="text-tiny">Mauris libero ex, iaculis vitae
											rhoncus et</div>
									</div>
								</div>
							</li>
							<li>
								<div class="message-item item-3">
									<div class="image">
										<i class="icon-noti-3"></i>
									</div>
									<div>
										<div class="body-title-2">Order shipped successfully</div>
										<div class="text-tiny">Integer aliquam eros nec
											sollicitudin sollicitudin</div>
									</div>
								</div>
							</li>
							<li>
								<div class="message-item item-4">
									<div class="image">
										<i class="icon-noti-4"></i>
									</div>
									<div>
										<div class="body-title-2">
											Order pending: <span>ID 305830</span>
										</div>
										<div class="text-tiny">Ultricies at rhoncus at
											ullamcorper</div>
									</div>
								</div>
							</li>
							<li><a href="#" class="tf-button w-full">View all</a></li>
						</ul>
					</div>
				</div>
				<div class="header-item button-zoom-maximize">
					<div class="">
						<i class="icon-maximize"></i>
					</div>
				</div>
				<div class="popup-wrap apps type-header">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="dropdownMenuButton4" data-bs-toggle="dropdown"
							aria-expanded="false">
							<span class="header-item"> <svg width="14" height="14"
									viewBox="0 0 14 14" fill="none"
									xmlns="http://www.w3.org/2000/svg">
                                                    <path
										d="M3.625 0.812501C3.06874 0.812501 2.52497 0.977451 2.06246 1.28649C1.59995 1.59553 1.23946 2.03479 1.02659 2.5487C0.813719 3.06262 0.758022 3.62812 0.866543 4.17369C0.975064 4.71926 1.24293 5.2204 1.63626 5.61374C2.0296 6.00707 2.53074 6.27494 3.07631 6.38346C3.62188 6.49198 4.18738 6.43628 4.7013 6.22341C5.21522 6.01054 5.65447 5.65006 5.96351 5.18754C6.27255 4.72503 6.4375 4.18126 6.4375 3.625C6.4375 2.87908 6.14118 2.16371 5.61374 1.63626C5.08629 1.10882 4.37092 0.812501 3.625 0.812501ZM3.625 5.3125C3.29125 5.3125 2.96498 5.21353 2.68748 5.02811C2.40997 4.84268 2.19368 4.57913 2.06595 4.27078C1.93823 3.96243 1.90481 3.62313 1.96993 3.29579C2.03504 2.96844 2.19576 2.66776 2.43176 2.43176C2.66776 2.19576 2.96844 2.03504 3.29579 1.96993C3.62313 1.90481 3.96243 1.93823 4.27078 2.06595C4.57913 2.19368 4.84268 2.40997 5.02811 2.68748C5.21353 2.96498 5.3125 3.29125 5.3125 3.625C5.3125 4.07255 5.13471 4.50178 4.81824 4.81824C4.50178 5.13471 4.07255 5.3125 3.625 5.3125ZM10.375 6.4375C10.9313 6.4375 11.475 6.27255 11.9375 5.96351C12.4001 5.65447 12.7605 5.21522 12.9734 4.7013C13.1863 4.18738 13.242 3.62188 13.1335 3.07631C13.0249 2.53074 12.7571 2.0296 12.3637 1.63626C11.9704 1.24293 11.4693 0.975064 10.9237 0.866543C10.3781 0.758022 9.81262 0.813719 9.2987 1.02659C8.78479 1.23946 8.34553 1.59995 8.03649 2.06246C7.72745 2.52497 7.5625 3.06874 7.5625 3.625C7.5625 4.37092 7.85882 5.08629 8.38626 5.61374C8.91371 6.14118 9.62908 6.4375 10.375 6.4375ZM10.375 1.9375C10.7088 1.9375 11.035 2.03647 11.3125 2.2219C11.59 2.40732 11.8063 2.67087 11.934 2.97922C12.0618 3.28757 12.0952 3.62687 12.0301 3.95422C11.965 4.28156 11.8042 4.58224 11.5682 4.81824C11.3322 5.05425 11.0316 5.21496 10.7042 5.28008C10.3769 5.34519 10.0376 5.31177 9.72922 5.18405C9.42087 5.05633 9.15732 4.84003 8.9719 4.56253C8.78647 4.28502 8.6875 3.95876 8.6875 3.625C8.6875 3.17745 8.86529 2.74823 9.18176 2.43176C9.49823 2.11529 9.92745 1.9375 10.375 1.9375ZM3.625 7.5625C3.06874 7.5625 2.52497 7.72745 2.06246 8.03649C1.59995 8.34553 1.23946 8.78479 1.02659 9.2987C0.813719 9.81262 0.758022 10.3781 0.866543 10.9237C0.975064 11.4693 1.24293 11.9704 1.63626 12.3637C2.0296 12.7571 2.53074 13.0249 3.07631 13.1335C3.62188 13.242 4.18738 13.1863 4.7013 12.9734C5.21522 12.7605 5.65447 12.4001 5.96351 11.9375C6.27255 11.475 6.4375 10.9313 6.4375 10.375C6.4375 9.62908 6.14118 8.91371 5.61374 8.38626C5.08629 7.85882 4.37092 7.5625 3.625 7.5625ZM3.625 12.0625C3.29125 12.0625 2.96498 11.9635 2.68748 11.7781C2.40997 11.5927 2.19368 11.3291 2.06595 11.0208C1.93823 10.7124 1.90481 10.3731 1.96993 10.0458C2.03504 9.71844 2.19576 9.41776 2.43176 9.18176C2.66776 8.94576 2.96844 8.78504 3.29579 8.71993C3.62313 8.65481 3.96243 8.68823 4.27078 8.81595C4.57913 8.94368 4.84268 9.15997 5.02811 9.43748C5.21353 9.71498 5.3125 10.0412 5.3125 10.375C5.3125 10.8226 5.13471 11.2518 4.81824 11.5682C4.50178 11.8847 4.07255 12.0625 3.625 12.0625ZM10.375 7.5625C9.81874 7.5625 9.27497 7.72745 8.81246 8.03649C8.34995 8.34553 7.98946 8.78479 7.77659 9.2987C7.56372 9.81262 7.50802 10.3781 7.61654 10.9237C7.72506 11.4693 7.99293 11.9704 8.38626 12.3637C8.7796 12.7571 9.28074 13.0249 9.82631 13.1335C10.3719 13.242 10.9374 13.1863 11.4513 12.9734C11.9652 12.7605 12.4045 12.4001 12.7135 11.9375C13.0226 11.475 13.1875 10.9313 13.1875 10.375C13.1875 9.62908 12.8912 8.91371 12.3637 8.38626C11.8363 7.85882 11.1209 7.5625 10.375 7.5625ZM10.375 12.0625C10.0412 12.0625 9.71498 11.9635 9.43748 11.7781C9.15997 11.5927 8.94368 11.3291 8.81595 11.0208C8.68823 10.7124 8.65481 10.3731 8.71993 10.0458C8.78504 9.71844 8.94576 9.41776 9.18176 9.18176C9.41776 8.94576 9.71844 8.78504 10.0458 8.71993C10.3731 8.65481 10.7124 8.68823 11.0208 8.81595C11.3291 8.94368 11.5927 9.15997 11.7781 9.43748C11.9635 9.71498 12.0625 10.0412 12.0625 10.375C12.0625 10.8226 11.8847 11.2518 11.5682 11.5682C11.2518 11.8847 10.8226 12.0625 10.375 12.0625Z"
										fill="#0A0A0C" />
                                                </svg>
							</span>
						</button>
						<ul class="dropdown-menu dropdown-menu-end has-content"
							aria-labelledby="dropdownMenuButton4">
							<li>
								<h6>Related apps</h6>
							</li>
							<li>
								<ul class="list-apps">
									<li class="item">
										<div class="image">
											<img src="images/apps/item-1.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Photoshop</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-2.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">illustrator</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-3.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Sheets</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-4.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Gmail</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-5.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Messenger</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-6.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Youtube</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-7.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Flaticon</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-8.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">Instagram</div>
									</a>
									</li>
									<li class="item">
										<div class="image">
											<img src="images/apps/item-9.png" alt="">
										</div> <a href="#">
											<div class="text-tiny">PDF</div>
									</a>
									</li>
								</ul>
							</li>
							<li><a href="#" class="tf-button w-full">View all app</a></li>
						</ul>
					</div>
				</div>
				<div class="popup-wrap user type-header">
					<div class="dropdown">
						<button class="btn btn-secondary dropdown-toggle" type="button"
							id="dropdownMenuButton3" data-bs-toggle="dropdown"
							aria-expanded="false">
							<span class="header-user wg-user"> <span class="image">
									<img src="images/avatar/user-1.png" alt="">
							</span> <span class="flex flex-column"> <!-- Hiá»n thá» tÃªn ngÆ°á»i dÃ¹ng ÄÄng nháº­p -->
									<span class="body-text text-main-dark"> <c:choose>
											<c:when test="${pageContext.request.userPrincipal != null}">
												<c:out value="${pageContext.request.userPrincipal.name}" />
											</c:when>
										</c:choose>
								</span> <span class="text-tiny">Admin</span>
							</span>
							</span>
						</button>
						<ul class="dropdown-menu dropdown-menu-end has-content"
							aria-labelledby="dropdownMenuButton3">
							<li>
								<!-- Sá»­ dá»¥ng c:url Äá» táº¡o URL logout cá»§a Spring Security -->
								<a href="<c:url value='/logout' />" class="user-item">
									<div class="icon">
										<i class="icon-log-out"></i>
									</div>
									<div class="body-title-2">Log out</div>
							</a>
							</li>
						</ul>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- /header-dashboard -->