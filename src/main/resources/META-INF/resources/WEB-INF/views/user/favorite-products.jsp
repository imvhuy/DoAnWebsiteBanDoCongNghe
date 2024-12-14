<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp" %>
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
                <div class="heading text-center">Your Favorite Products </div>
            </div>
        </div>
        <!-- /page-title -->
        <!-- Section Product -->
        <section class="flat-spacing-2">
            <div class="container">
                <div class="grid-layout wrapper-shop" data-grid="grid-4">
                    <!-- card product  list-->
                     <c:forEach var="product" items="${products}">
                    <div class="card-product">
                        <div class="card-product-wrapper">
                            <a href="product-detail.html" class="product-img">
                                <img class="lazyload img-product" data-src="/admin/images/products/${product.image}" src="/admin/images/products/${product.image}" alt="image-product" style = " object-fit: contain;">
                                <img class="lazyload img-hover" data-src="/admin/images/products/${product.image}" src="/admin/images/products/${product.image}" alt="image-product" alt="image-product" style = " object-fit: contain;">
                            </a>
                            <div class="list-product-btn type-wishlist">
                                <a href="javascript:void(0);" class="box-icon bg_white wishlist"  onclick="removeFromFavoriteProducts (${product.id})">
                                    <span class="tooltip">Remove Wishlist</span>
                                    <span class="icon icon-delete"></span>
                                </a>
                            </div>
                        </div>
                        <div class="card-product-info text-center" >
                            <a href="${pageContext.request.contextPath}/product-detail/${product.id}" class="title link">${product.name}</a>
                            <span class="price"><fmt:formatNumber
											value="${product.price}" type="number" maxFractionDigits="0" />
										VND</span>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- /Section Product -->
    </div>

    <!-- gotop -->
    <div class="progress-wrap">
        <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
        <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" style="transition: stroke-dashoffset 10ms linear 0s; stroke-dasharray: 307.919, 307.919; stroke-dashoffset: 286.138;"></path>
        </svg>
    </div>
    <!-- /gotop -->
    
    <!-- toolbar-bottom -->
    <div class="tf-toolbar-bottom type-1150">
        <div class="toolbar-item">
            <a href="#toolbarShopmb" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft">
                <div class="toolbar-icon">
                    <i class="icon-shop"></i>
                </div>
                <div class="toolbar-label">Shop</div>
            </a>
        </div>
        
        <div class="toolbar-item">
            <a href="#canvasSearch" data-bs-toggle="offcanvas" aria-controls="offcanvasLeft">
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
	    function removeFromFavoriteProducts(productId) {
	        // Tạo đối tượng dữ liệu gửi lên server
	        const data = { productId: productId};
	
	        // Gửi yêu cầu POST tới API của Spring Boot
	        fetch('/remove-favorite-product', {
	            method: 'POST', // Sử dụng phương thức POST
	            headers: {
	                'Content-Type': 'application/json' // Đảm bảo dữ liệu gửi lên là JSON
	            },
	            body: JSON.stringify(data) // Chuyển đổi đối tượng dữ liệu thành chuỗi JSON
	        })
	        .then(response => {
	            if (response.ok) {
	                return response.json(); // Parse dữ liệu JSON từ response
	            }
	            throw new Error('Network response was not ok');
	        })
	        .then(data => {
	            // Kiểm tra kết quả trả về từ server
	            if (data.success) {
	                console.log('Product removed from favorite product!');
	                window.location.reload(); // load lai trang hien tai
	                // Có thể thay đổi giao diện sau khi thêm vào wishlist (ví dụ: đổi icon hoặc cập nhật số lượng)
	            } else {
	            	console.log('Failed to remove from favorite product.');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	        });
	    }
    </script>
