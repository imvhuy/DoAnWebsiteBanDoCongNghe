<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
	.reply-comment-wrap {
		margin-top: 20px;
	}

	.reply-comment-item {
		margin-bottom: 15px;
		padding: 10px;
		border: 1px solid #ddd;
		border-radius: 8px;
		display: flex; /* Đặt phần tử thành flex container */
		flex-direction: column;
		/* Chỉ định các phần tử con (nút, content) sắp xếp theo cột */
	}

	.reply-comment-item p {
		font-size: 14px;
		line-height: 1.6;
		margin-top: 10px;
	}

	.type-reply {
		margin-left: 30px;
		background-color: #f9f9f9;
		border-left: 3px solid #ddd;
	}

	.reply-form {
		margin-top: 10px;
		border-top: 1px solid #ddd;
		padding-top: 10px;
	}

	.reply-form textarea {
		width: 100%;
		padding: 8px;
		border: 1px solid #ddd;
		border-radius: 4px;
		resize: vertical;
	}

	.reply-form button {
		margin-top: 5px;
		padding: 5px 15px;
		background-color: #0069d9;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
	}

	.reply-form button:hover {
		background-color: #0056b3;
	}

	.btn-reply {
		padding: 2px 4px; /* Thay đổi kích thước nút */
		font-size: 6px; /* Giảm kích thước chữ */
		background-color: #28a745; /* Màu nền của nút */
		color: white; /* Màu chữ */
		border: none; /* Bỏ viền */
		border-radius: 4px; /* Bo góc nút */
		cursor: pointer; /* Con trỏ chuột khi hover */
		display: inline-block; /* Đảm bảo nút không chiếm hết chiều rộng */
		width: 50px;
		height: 22px;
		align-self: flex-end;
	}

	.btn-reply:hover {
		background-color: #218838; /* Màu nền khi hover */
	}

	/* Đảm bảo form trả lời và button không bị chồng lên nhau */
	.reply-comment-item {
		position: relative; /* Thiết lập vị trí của review item */
		margin-bottom: 20px; /* Tạo không gian phía dưới review */
	}

	/* Nút "Trả lời" ở dưới content review */
	.reply-comment-item .btn-reply {
		display: inline-block;
		/* Đảm bảo nó không bị dính vào các phần tử khác */
		margin-top: 10px; /* Khoảng cách từ content của review */
		padding: 8px 15px;
		font-size: 14px;
		background-color: #007bff;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		float: right !important;
	}
</style>
<!-- preload -->
<div class="preload preload-container">
	<div class="preload-logo">
		<div class="spinner"></div>
	</div>
</div>
<!-- /preload -->
<div id="wrapper">
	<!-- breadcrumb -->
	<div class="tf-breadcrumb">
		<div class="container">
			<div
					class="tf-breadcrumb-wrap d-flex justify-content-between flex-wrap align-items-center"
					style="visibility: hidden;">
				<div class="tf-breadcrumb-prev-next">
					<a href="#" class="tf-breadcrumb-prev hover-tooltip center"> <i
							class="icon icon-arrow-left"></i> <!-- <span class="tooltip">Cotton jersey top</span> -->
					</a> <a href="#" class="tf-breadcrumb-back hover-tooltip center"> <i
						class="icon icon-shop"></i> <!-- <span class="tooltip">Back to Women</span> -->
				</a> <a href="#" class="tf-breadcrumb-next hover-tooltip center"> <i
						class="icon icon-arrow-right"></i> <!-- <span class="tooltip">Cotton jersey top</span> -->
				</a>
				</div>
			</div>
		</div>
	</div>
	<!-- /breadcrumb -->
	<!-- default -->
	<section class="flat-spacing-4 pt_0">
		<div class="tf-main-product section-image-zoom">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="tf-product-media-wrap sticky-top">
							<div class="thumbs-slider">
								<div dir="ltr"
									 class="swiper tf-product-media-thumbs other-image-zoom"
									 data-direction="vertical">
									<div class="swiper-wrapper stagger-wrap">
										<!-- beige -->
										<!-- front -->
										<c:if test="${not empty product.galleries}">
											<c:forEach var="gallery" items="${product.galleries}">
												<div class="swiper-slide stagger-item" data-color="beige">
													<div class="item">
														<img class="lazyload"
															 src="/admin/images/products/${gallery.image}"
															 alt="img-product">
													</div>
												</div>
											</c:forEach>
										</c:if>
										<iframe width="100%" height="auto"
												style="max-width: 544px; max-height: 846px; margin-top: 170px; object-fit: contain; border: none;"
												src="${product.video}" frameborder="0"
												allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
												allowfullscreen></iframe>
									</div>
								</div>
								<div dir="ltr" class="swiper tf-product-media-main"
									 id="gallery-swiper-started">
									<div class="swiper-wrapper">
										<!-- Video Slide -->
										<div class="swiper-slide" data-color="beige">
											<iframe
													style="width: 100%; height: 100%; max-width: 700px; margin-top: 170px; max-height: 500px; object-fit: contain; border: none;"
													src="${product.video}" frameborder="0"
													allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
													allowfullscreen> </iframe>
										</div>
										<!-- product -->
										<c:if test="${not empty product.galleries}">
											<c:forEach var="gallery" items="${product.galleries}">
												<!-- begin image -->
												<div class="swiper-slide" data-color="beige">
													<a target="_blank" class="item" data-pswp-width="770px"
													   data-pswp-height="1075px"> <img
															class="tf-image-zoom lazyload"
															src="/admin/images/products/${gallery.image}" alt=""
															style="object-fit: contain;">
													</a>
												</div>
											</c:forEach>
										</c:if>

										<!-- end image -->
										<!--end  product -->
									</div>
									<div class="swiper-button-next button-style-arrow thumbs-next"></div>
									<div class="swiper-button-prev button-style-arrow thumbs-prev"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="tf-product-info-wrap position-relative">
							<div class="tf-zoom-main"></div>
							<div class="tf-product-info-list other-image-zoom">
								<div class="tf-product-info-title">
									<h5>${product.name }</h5>
								</div>
								<div class="tf-product-info-badges">
									<div class="badges">Best seller</div>
									<div class="product-status-content">
										<i class="icon-lightning"></i>
										<p class="fw-6">Selling fast! 56 people have this in their
											carts.</p>
									</div>
								</div>
								<div class="tf-product-info-price">

									<div class="price-on-sale-1">
										<fmt:formatNumber value="${product.promotionalPrice}"
														  type="number" maxFractionDigits="0" />
										VND
									</div>
									<div class="compare-at-price">
										<fmt:formatNumber value="${product.price}" type="number"
														  maxFractionDigits="0" />
										VND
									</div>

									<div class="badges-on-sale">
										<c:choose>
											<c:when test="${not empty product.promotionalPrice}">

												<span><fmt:formatNumber
														value="${100 - product.promotionalPrice/product.price * 100}"
														type="number" maxFractionDigits="0" /></span>% OFF
											</c:when>
											<c:otherwise>
												<span>0</span>% OFF
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<div class="tf-product-info-variant-picker"></div>
								<div class="tf-product-info-quantity">
									<div class="quantity-title fw-6">Quantity</div>
									<div class="wg-quantity">
										<span class="btn-quantity btn-decrease">-</span> <input
											type="text" class="quantity-product-1" name="number"
											value="1"> <span class="btn-quantity btn-increase">+</span>
									</div>
								</div>
								<div class="tf-product-info-buy-button">
									<form class="">
										<a href="javascript:void(0);"
										   class="tf-btn btn-fill justify-content-center fw-6 fs-16 flex-grow-1 animate-hover-btn btn-add-to-cart"
										   data-product-id="${product.id}"><span>Add to cart
												-&nbsp;</span><span class="tf-qty-price total-price-1"><fmt:formatNumber
												value="${product.promotionalPrice}" type="number"
												maxFractionDigits="0" /> VND</span></a> <a href="javascript:void(0);"
																						   class="tf-product-btn-wishlist hover-tooltip box-icon bg_white wishlist btn-icon-action"
																						   onclick="toggleWishlistIcon(this, ${product.id})"> <span
											class="icon icon-heart"></span> <span class="tooltip">Add
												to Wishlist</span> <span class="icon icon-delete"></span>
									</a>
										<div class="w-100">
											<a href="#" class="btns-full btn-buy-product"
											   data-product-id="${product.id}">Buy</a> <a href="#"
																						  class="payment-more-option">More payment options</a>
										</div>

									</form>
								</div>
								<div class="tf-product-info-extra-link">
									<a href="#ask_question" data-bs-toggle="modal"
									   class="tf-product-extra-icon">
										<div class="icon">
											<i class="icon-question"></i>
										</div>
										<div class="text fw-6">Ask a question</div>
									</a> <a href="#delivery_return" data-bs-toggle="modal"
											class="tf-product-extra-icon">
									<div class="icon">
										<svg class="d-inline-block"
											 xmlns="http://www.w3.org/2000/svg" width="22" height="18"
											 viewBox="0 0 22 18" fill="currentColor">
											<path
													d="M21.7872 10.4724C21.7872 9.73685 21.5432 9.00864 21.1002 8.4217L18.7221 5.27043C18.2421 4.63481 17.4804 4.25532 16.684 4.25532H14.9787V2.54885C14.9787 1.14111 13.8334 0 12.4255 0H9.95745V1.69779H12.4255C12.8948 1.69779 13.2766 2.07962 13.2766 2.54885V14.5957H8.15145C7.80021 13.6052 6.85421 12.8936 5.74468 12.8936C4.63515 12.8936 3.68915 13.6052 3.33792 14.5957H2.55319C2.08396 14.5957 1.70213 14.2139 1.70213 13.7447V2.54885C1.70213 2.07962 2.08396 1.69779 2.55319 1.69779H9.95745V0H2.55319C1.14528 0 0 1.14111 0 2.54885V13.7447C0 15.1526 1.14528 16.2979 2.55319 16.2979H3.33792C3.68915 17.2884 4.63515 18 5.74468 18C6.85421 18 7.80021 17.2884 8.15145 16.2979H13.423C13.7742 17.2884 14.7202 18 15.8297 18C16.9393 18 17.8853 17.2884 18.2365 16.2979H21.7872V10.4724ZM16.684 5.95745C16.9494 5.95745 17.2034 6.08396 17.3634 6.29574L19.5166 9.14894H14.9787V5.95745H16.684ZM5.74468 16.2979C5.27545 16.2979 4.89362 15.916 4.89362 15.4468C4.89362 14.9776 5.27545 14.5957 5.74468 14.5957C6.21392 14.5957 6.59575 14.9776 6.59575 15.4468C6.59575 15.916 6.21392 16.2979 5.74468 16.2979ZM15.8298 16.2979C15.3606 16.2979 14.9787 15.916 14.9787 15.4468C14.9787 14.9776 15.3606 14.5957 15.8298 14.5957C16.299 14.5957 16.6809 14.9776 16.6809 15.4468C16.6809 15.916 16.299 16.2979 15.8298 16.2979ZM18.2366 14.5957C17.8853 13.6052 16.9393 12.8936 15.8298 12.8936C15.5398 12.8935 15.252 12.943 14.9787 13.04V10.8511H20.0851V14.5957H18.2366Z"></path></svg>
									</div>
									<div class="text fw-6">Delivery & Return</div>
								</a>
								</div>
								<div class="tf-product-info-delivery-return">
									<div class="row">
										<div class="col-xl-6 col-12">
											<div class="tf-product-delivery">
												<div class="icon">
													<i class="icon-delivery-time"></i>
												</div>
												<p>
													Estimate delivery times: <span class="fw-7">12-26
														days</span> (International), <span class="fw-7">3-6 days</span>
													(United States).
												</p>
											</div>
										</div>
										<div class="col-xl-6 col-12">
											<div class="tf-product-delivery mb-0">
												<div class="icon">
													<i class="icon-return-order"></i>
												</div>
												<p>
													Return within <span class="fw-7">30 days</span> of
													purchase. Duties & taxes are non-refundable.
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="tf-product-info-trust-seal">
									<div class="tf-product-trust-mess">
										<i class="icon-safe"></i>
										<p class="fw-6">
											Guarantee Safe <br> Checkout
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- /default -->
	<!-- tabs -->
	<section class="flat-spacing-17 pt_0">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="widget-tabs style-has-border">
						<ul class="widget-menu-tab">
							<li class="item-title active"><span class="inner">Configuration</span>
							</li>
							<li class="item-title"><span class="inner">Description</span></li>
							<li class="item-title"><span class="inner">Review</span></li>
							<li class="item-title"><span class="inner">Shipping</span></li>
							<li class="item-title"><span class="inner">Return
									Policies</span></li>
						</ul>
						<div class="widget-content-tab">
							<div class="widget-content-inner active">
								<div class="product-configuration" id="product-configuration">
									<table
											style="width: 100%; border-collapse: collapse; border: 1px solid #ddd; text-align: left; font-family: Arial, sans-serif;">
										<tbody>
										<!-- Duyệt qua configList và tạo các dòng bảng -->
										<c:forEach var="config" items="${configList}">
											<tr style="border: 1px solid #ddd;">
												<td
														style="padding: 10px 15px; border-left: 1px solid #ddd;">${config.key}</td>
												<td
														style="padding: 10px 15px; border-left: 1px solid #ddd;">${config.value}</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="widget-content-inner">
								<pre>${product.description }</pre>
							</div>
							<div class="widget-content-inner">
								<div class="tab-reviews write-cancel-review-wrap">
									<div class="tab-reviews-heading">
										<div class="top">
											<div class="text-center">
												<h1 class="number fw-6">${averageRating }</h1>
												<div class="list-star">
													<i class="icon icon-star"></i> <i class="icon icon-star"></i>
													<i class="icon icon-star"></i> <i class="icon icon-star"></i>
													<i class="icon icon-star"></i>
												</div>
											</div>
											<!-- Số lượng review theo rating -->
											<div class="rating-score">
												<c:forEach var="rating" items="${ratingMap}">
													<div class="item">
														<div class="number-1 text-caption-1">${rating.key}</div>
														<i class="icon icon-star"></i>
														<div class="line-bg">
															<div style="width: ${rating.value / totalReviews * 100}%"></div>
														</div>
														<div class="number-2 text-caption-1">${rating.value}</div>
													</div>
												</c:forEach>
											</div>
										</div>
										<div>
											<div
													class="tf-btn btn-outline-dark fw-6 btn-comment-review btn-cancel-review">Cancel
												Review</div>
											<div
													class="tf-btn btn-outline-dark fw-6 btn-comment-review btn-write-review"
													onclick="toggleReviewForm()">Write a review</div>
										</div>
									</div>
									<div class="reply-comment cancel-review-wrap">
										<div
												class="d-flex mb_24 gap-20 align-items-center justify-content-between flex-wrap">
											<h5 class="">${totalReviews}Comments</h5>
										</div>
										<!-- Nút ẩn/hiện phần bình luận -->
										<button class="btn-toggle-comments" onclick="toggleComments()">Hide
											comments</button>
										<div class="reply-comment-wrap">

											<!-- Duyệt qua các review chính -->
											<c:forEach var="review" items="${reviews}">
												<!-- Kiểm tra xem đây có phải là review chính hay không (parent_id == null) -->
												<c:if test="${review.parent_id == null}">
													<!-- Hiển thị Review chính -->
													<div class="reply-comment-item">
														<div class="user">
															<div class="image">
																<img src="https://thumbs.dreamstime.com/b/businessman-avatar-line-icon-vector-illustration-design-79327237.jpg" alt="">
															</div>

															<div>
																<h6>
																	<a href="#" class="link">${review.user.fullName}</a>
																</h6>
																<div class="day text_black-3">
																	<fmt:formatDate value="${review.createdDate}"
																					pattern="dd-MM-yyyy" />
																</div>
															</div>
														</div>
														<p class="text_black-3">${review.content}</p>
														<!-- Hiển thị nút "Trả lời" cho review chính -->
														<button class="btn-reply"
																onclick="toggleReplyForm(${review.id})"
																style="width: 80px !important; height: 38px !important;">Trả
															lời</button>

														<!-- Form trả lời (ẩn khi chưa nhấn nút) -->
														<div class="reply-form" id="reply-form-${review.id}"
															 style="display: none;">
															<form
																	action="${pageContext.request.contextPath}/product-detail/submit-reply"
																	method="POST">
																<textarea name="replyContent"
																		  placeholder="Viết câu trả lời..." rows="3" required>@${review.user.fullName}:</textarea>
																<button type="submit" class="btn btn-secondary">Trả
																	lời</button>
																<input type="hidden" name="parentId"
																	   value="${review.id}" /> <input type="hidden"
																									  name="productId" value="${product.id}" />
															</form>
														</div>
														<!-- Hiển thị các reply cho review chính này -->
														<div class="replies">
															<c:forEach var="reply" items="${reviews}">
																<!-- Kiểm tra xem review có phải là reply của review chính không -->
																<c:if
																		test="${reply.parent_id != null && reply.parent_id == review.id}">
																	<div class="reply-comment-item type-reply">
																		<div class="user">
																			<div class="image">
																				<img src="https://thumbs.dreamstime.com/b/businessman-avatar-line-icon-vector-illustration-design-79327237.jpg" alt="">
																			</div>
																			<div>
																				<h6>
																					<a href="#" class="link">${reply.user.fullName}</a>
																				</h6>
																				<div class="day text_black-3">
																					<fmt:formatDate value="${reply.createdDate}"
																									pattern="dd-MM-yyyy" />
																				</div>
																			</div>
																		</div>
																		<p class="text_black-3">${reply.content}</p>
																		<!-- Nút "Trả lời" cho reply -->
																		<button class="btn-reply"
																				onclick="toggleReplyForm(${reply.id})"
																				style="width: 80px !important; height: 38px !important;">Trả
																			lời</button>

																		<!-- Form trả lời cho reply (ẩn khi chưa nhấn nút) -->
																		<div class="reply-form" id="reply-form-${reply.id}"
																			 style="display: none;">
																			<form
																					action="${pageContext.request.contextPath}/product-detail/submit-reply"
																					method="POST">
																				<textarea name="replyContent"
																						  placeholder="Viết câu trả lời..." rows="3" required>@${reply.user.fullName}:</textarea>
																				<button type="submit" class="btn btn-secondary">Trả
																					lời</button>
																				<input type="hidden" name="parentId"
																					   value="${review.id}" /> <input type="hidden"
																													  name="productId" value="${product.id}" />
																			</form>
																		</div>
																	</div>
																</c:if>
															</c:forEach>

														</div>
													</div>
												</c:if>
											</c:forEach>
										</div>

									</div>
									<form class="form-write-review write-review-wrap"
										  action="${pageContext.request.contextPath}/product-detail/submit-review"
										  method="POST">
										<div class="heading">
											<h5>Write a review:</h5>
											<div class="list-rating-check">
												<input type="radio" id="star5" name="rate" value="5" /> <label
													for="star5" title="text"></label> <input type="radio"
																							 id="star4" name="rate" value="4" /> <label for="star4"
																																		title="text"></label> <input type="radio" id="star3"
																																									 name="rate" value="3" /> <label for="star3" title="text"></label>
												<input type="radio" id="star2" name="rate" value="2" /> <label
													for="star2" title="text"></label> <input type="radio"
																							 id="star1" name="rate" value="1" /> <label for="star1"
																																		title="text"></label>
											</div>
										</div>
										<div class="form-content">
											<fieldset class="box-field">
												<label class="label">Review</label>
												<textarea rows="4" placeholder="Write your comment here"
														  tabindex="2" aria-required="true" required=""
														  name="reviewContent"></textarea>
											</fieldset>
										</div>
										<input type="hidden" name="productId" value="${product.id}" />
										<div class="button-submit">
											<button class="tf-btn btn-fill animate-hover-btn"
													type="submit">Submit Reviews</button>
										</div>
									</form>
								</div>
							</div>
							<div class="widget-content-inner">
								<div class="tf-page-privacy-policy">
									<div class="title">The Company Private Limited Policy</div>
									<p>The Company Private Limited and each of their respective
										subsidiary, parent and affiliated companies is deemed to
										operate this Website (“we” or “us”) recognizes that you care
										how information about you is used and shared. We have created
										this Privacy Policy to inform you what information we collect
										on the Website, how we use your information and the choices
										you have about the way your information is collected and used.
										Please read this Privacy Policy carefully. Your use of the
										Website indicates that you have read and accepted our privacy
										practices, as outlined in this Privacy Policy.</p>
									<p>Please be advised that the practices described in this
										Privacy Policy apply to information gathered by us or our
										subsidiaries, affiliates or agents: (i) through this Website,
										(ii) where applicable, through our Customer Service Department
										in connection with this Website, (iii) through information
										provided to us in our free standing retail stores, and (iv)
										through information provided to us in conjunction with
										marketing promotions and sweepstakes.</p>
									<p>We are not responsible for the content or privacy
										practices on any websites.</p>
									<p>We reserve the right, in our sole discretion, to modify,
										update, add to, discontinue, remove or otherwise change any
										portion of this Privacy Policy, in whole or in part, at any
										time. When we amend this Privacy Policy, we will revise the
										“last updated” date located at the top of this Privacy Policy.</p>
									<p>If you provide information to us or access or use the
										Website in any way after this Privacy Policy has been changed,
										you will be deemed to have unconditionally consented and
										agreed to such changes. The most current version of this
										Privacy Policy will be available on the Website and will
										supersede all previous versions of this Privacy Policy.</p>
									<p>If you have any questions regarding this Privacy Policy,
										you should contact our Customer Service Department by email at
										marketing@company.com</p>
								</div>
							</div>
							<div class="widget-content-inner">
								<ul class="d-flex justify-content-center mb_18">
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M8.7 30.7h22.7c.3 0 .6-.2.7-.6l4-25.3c-.1-.4-.3-.7-.7-.8s-.7.2-.8.6L34 8.9l-3-1.1c-2.4-.9-5.1-.5-7.2 1-2.3 1.6-5.3 1.6-7.6 0-2.1-1.5-4.8-1.9-7.2-1L6 8.9l-.7-4.3c0-.4-.4-.7-.7-.6-.4.1-.6.4-.6.8l4 25.3c.1.3.3.6.7.6zm.8-21.6c2-.7 4.2-.4 6 .8 1.4 1 3 1.5 4.6 1.5s3.2-.5 4.6-1.5c1.7-1.2 4-1.6 6-.8l3.3 1.2-3 19.1H9.2l-3-19.1 3.3-1.2zM32 32H8c-.4 0-.7.3-.7.7s.3.7.7.7h24c.4 0 .7-.3.7-.7s-.3-.7-.7-.7zm0 2.7H8c-.4 0-.7.3-.7.7s.3.6.7.6h24c.4 0 .7-.3.7-.7s-.3-.6-.7-.6zm-17.9-8.9c-1 0-1.8-.3-2.4-.6l.1-2.1c.6.4 1.4.6 2 .6.8 0 1.2-.4 1.2-1.3s-.4-1.3-1.3-1.3h-1.3l.2-1.9h1.1c.6 0 1-.3 1-1.3 0-.8-.4-1.2-1.1-1.2s-1.2.2-1.9.4l-.2-1.9c.7-.4 1.5-.6 2.3-.6 2 0 3 1.3 3 2.9 0 1.2-.4 1.9-1.1 2.3 1 .4 1.3 1.4 1.3 2.5.3 1.8-.6 3.5-2.9 3.5zm4-5.5c0-3.9 1.2-5.5 3.2-5.5s3.2 1.6 3.2 5.5-1.2 5.5-3.2 5.5-3.2-1.6-3.2-5.5zm4.1 0c0-2-.1-3.5-.9-3.5s-1 1.5-1 3.5.1 3.5 1 3.5c.8 0 .9-1.5.9-3.5zm4.5-1.4c-.9 0-1.5-.8-1.5-2.1s.6-2.1 1.5-2.1 1.5.8 1.5 2.1-.5 2.1-1.5 2.1zm0-.8c.4 0 .7-.5.7-1.2s-.2-1.2-.7-1.2-.7.5-.7 1.2.3 1.2.7 1.2z">
										</path>
									</svg></li>
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M36.7 31.1l-2.8-1.3-4.7-9.1 7.5-3.5c.4-.2.6-.6.4-1s-.6-.5-1-.4l-7.5 3.5-7.8-15c-.3-.5-1.1-.5-1.4 0l-7.8 15L4 15.9c-.4-.2-.8 0-1 .4s0 .8.4 1l7.5 3.5-4.7 9.1-2.8 1.3c-.4.2-.6.6-.4 1 .1.3.4.4.7.4.1 0 .2 0 .3-.1l1-.4-1.5 2.8c-.1.2-.1.5 0 .8.1.2.4.3.7.3h31.7c.3 0 .5-.1.7-.4.1-.2.1-.5 0-.8L35.1 32l1 .4c.1 0 .2.1.3.1.3 0 .6-.2.7-.4.1-.3 0-.8-.4-1zm-5.1-2.3l-9.8-4.6 6-2.8 3.8 7.4zM20 6.4L27.1 20 20 23.3 12.9 20 20 6.4zm-7.8 15l6 2.8-9.8 4.6 3.8-7.4zm22.4 13.1H5.4L7.2 31 20 25l12.8 6 1.8 3.5z">
										</path>
									</svg></li>
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M5.9 5.9v28.2h28.2V5.9H5.9zM19.1 20l-8.3 8.3c-2-2.2-3.2-5.1-3.2-8.3s1.2-6.1 3.2-8.3l8.3 8.3zm-7.4-9.3c2.2-2 5.1-3.2 8.3-3.2s6.1 1.2 8.3 3.2L20 19.1l-8.3-8.4zM20 20.9l8.3 8.3c-2.2 2-5.1 3.2-8.3 3.2s-6.1-1.2-8.3-3.2l8.3-8.3zm.9-.9l8.3-8.3c2 2.2 3.2 5.1 3.2 8.3s-1.2 6.1-3.2 8.3L20.9 20zm8.4-10.2c-1.2-1.1-2.6-2-4.1-2.6h6.6l-2.5 2.6zm-18.6 0L8.2 7.2h6.6c-1.5.6-2.9 1.5-4.1 2.6zm-.9.9c-1.1 1.2-2 2.6-2.6 4.1V8.2l2.6 2.5zM7.2 25.2c.6 1.5 1.5 2.9 2.6 4.1l-2.6 2.6v-6.7zm3.5 5c1.2 1.1 2.6 2 4.1 2.6H8.2l2.5-2.6zm18.6 0l2.6 2.6h-6.6c1.4-.6 2.8-1.5 4-2.6zm.9-.9c1.1-1.2 2-2.6 2.6-4.1v6.6l-2.6-2.5zm2.6-14.5c-.6-1.5-1.5-2.9-2.6-4.1l2.6-2.6v6.7z">
										</path>
									</svg></li>
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M35.1 33.6L33.2 6.2c0-.4-.3-.7-.7-.7H13.9c-.4 0-.7.3-.7.7s.3.7.7.7h18l.7 10.5H20.8c-8.8.2-15.9 7.5-15.9 16.4 0 .4.3.7.7.7h28.9c.2 0 .4-.1.5-.2s.2-.3.2-.5v-.2h-.1zm-28.8-.5C6.7 25.3 13 19 20.8 18.9h11.9l1 14.2H6.3zm11.2-6.8c0 1.2-1 2.1-2.1 2.1s-2.1-1-2.1-2.1 1-2.1 2.1-2.1 2.1 1 2.1 2.1zm6.3 0c0 1.2-1 2.1-2.1 2.1-1.2 0-2.1-1-2.1-2.1s1-2.1 2.1-2.1 2.1 1 2.1 2.1z">
										</path>
									</svg></li>
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M20 33.8c7.6 0 13.8-6.2 13.8-13.8S27.6 6.2 20 6.2 6.2 12.4 6.2 20 12.4 33.8 20 33.8zm0-26.3c6.9 0 12.5 5.6 12.5 12.5S26.9 32.5 20 32.5 7.5 26.9 7.5 20 13.1 7.5 20 7.5zm-.4 15h.5c1.8 0 3-1.1 3-3.7 0-2.2-1.1-3.6-3.1-3.6h-2.6v10.6h2.2v-3.3zm0-5.2h.4c.6 0 .9.5.9 1.7 0 1.1-.3 1.7-.9 1.7h-.4v-3.4z">
										</path>
									</svg></li>
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M30.2 29.3c2.2-2.5 3.6-5.7 3.6-9.3s-1.4-6.8-3.6-9.3l3.6-3.6c.3-.3.3-.7 0-.9-.3-.3-.7-.3-.9 0l-3.6 3.6c-2.5-2.2-5.7-3.6-9.3-3.6s-6.8 1.4-9.3 3.6L7.1 6.2c-.3-.3-.7-.3-.9 0-.3.3-.3.7 0 .9l3.6 3.6c-2.2 2.5-3.6 5.7-3.6 9.3s1.4 6.8 3.6 9.3l-3.6 3.6c-.3.3-.3.7 0 .9.1.1.3.2.5.2s.3-.1.5-.2l3.6-3.6c2.5 2.2 5.7 3.6 9.3 3.6s6.8-1.4 9.3-3.6l3.6 3.6c.1.1.3.2.5.2s.3-.1.5-.2c.3-.3.3-.7 0-.9l-3.8-3.6z">
										</path>
									</svg></li>
									<li class=""><svg viewBox="0 0 40 40" width="35px"
													  height="35px" color="#222" margin="5px">
										<path fill="currentColor"
											  d="M34.1 34.1H5.9V5.9h28.2v28.2zM7.2 32.8h25.6V7.2H7.2v25.6zm13.5-18.3a.68.68 0 0 0-.7-.7.68.68 0 0 0-.7.7v10.9a.68.68 0 0 0 .7.7.68.68 0 0 0 .7-.7V14.5z">
										</path>
									</svg></li>
								</ul>
								<p class="text-center text-paragraph">LT01: 70% wool, 15%
									polyester, 10% polyamide, 5% acrylic 900 Grms/mt</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- /tabs -->
	<!-- product -->
	<section class="flat-spacing-1 pt_0">
		<div class="container">
			<div class="flat-title">
				<span class="title">Related Products</span>
			</div>
			<div class="hover-sw-nav hover-sw-2">
				<div dir="ltr" class="swiper tf-sw-product-sell wrap-sw-over"
					 data-preview="4" data-tablet="3" data-mobile="2" data-space-lg="30"
					 data-space-md="15" data-pagination="2" data-pagination-md="3"
					 data-pagination-lg="3">
					<div class="swiper-wrapper">
						<c:forEach var="relatedProduct" items="${relatedProducts}">
							<div class="swiper-slide" lazy="true">
								<div class="card-product">
									<div class="card-product-wrapper">
										<a
												href="${pageContext.request.contextPath}/product-detail/${relatedProduct.id}"
												class="product-img"> <img class="lazyload img-product"
																		  data-src="/admin/images/products/${relatedProduct.image}"
																		  src="/admin/images/products/${relatedProduct.image}"
																		  alt="image-product" style="object-fit: contain;"> <img
												class="lazyload img-hover"
												data-src="/admin/images/products/${relatedProduct.image}"
												src="/admin/images/products/${relatedProduct.image}"
												alt="image-product" style="object-fit: contain;">
										</a>
										<div class="list-product-btn">
											<a href="javascript:void(0);"
											   class="box-icon bg_white wishlist btn-icon-action"
											   onclick="toggleWishlistIcon(this, ${relatedProduct.id})">
												<span class="icon icon-heart"></span> <span class="tooltip">Add
													to Wishlist</span> <span class="icon icon-delete"></span>
											</a> <a
												href="${pageContext.request.contextPath}/product-detail/${relatedProduct.id}"
												data-bs-toggle="modal"
												class="box-icon bg_white quickview tf-btn-loading"> <span
												class="icon icon-view"></span> <span class="tooltip">View</span>
										</a>
										</div>
									</div>
									<div class="card-product-info text-center">
										<a
												href="${pageContext.request.contextPath}/product-detail/${relatedProduct.id}"
												class="title link">${relatedProduct.name}</a> <span
											class="price"><fmt:formatNumber
											value="${relatedProduct.price}" type="number"
											maxFractionDigits="0" /> VND</span>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div
						class="nav-sw nav-next-slider nav-next-product box-icon w_46 round">
					<span class="icon icon-arrow-left"></span>
				</div>
				<div
						class="nav-sw nav-prev-slider nav-prev-product box-icon w_46 round">
					<span class="icon icon-arrow-right"></span>
				</div>
			</div>

			<div
					class="sw-dots style-2 sw-pagination-product justify-content-center"></div>
		</div>
	</section>
</div>

<!-- modal delivery_return -->
<div
		class="modal modalCentered fade modalDemo tf-product-modal modal-part-content"
		id="delivery_return">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="header">
				<div class="demo-title">Shipping & Delivery</div>
				<span class="icon-close icon-close-popup" data-bs-dismiss="modal"></span>
			</div>
			<div class="overflow-y-auto">
				<div class="tf-product-popup-delivery">
					<div class="title">Delivery</div>
					<p class="text-paragraph">All orders shipped with UPS Express.</p>
					<p class="text-paragraph">Always free shipping for orders over
						US $250.</p>
					<p class="text-paragraph">All orders are shipped with a UPS
						tracking number.</p>
				</div>
				<div class="tf-product-popup-delivery">
					<div class="title">Returns</div>
					<p class="text-paragraph">Items returned within 14 days of
						their original shipment date in same as new condition will be
						eligible for a full refund or store credit.</p>
					<p class="text-paragraph">Refunds will be charged back to the
						original form of payment used for purchase.</p>
					<p class="text-paragraph">Customer is responsible for shipping
						charges when making returns and shipping/handling fees of original
						purchase is non-refundable.</p>
					<p class="text-paragraph">All sale items are final purchases.</p>
				</div>
				<div class="tf-product-popup-delivery">
					<div class="title">Help</div>
					<p class="text-paragraph">Give us a shout if you have any other
						questions and/or concerns.</p>
					<p class="text-paragraph">
						Email: <a href="mailto:contact@domain.com"
								  aria-describedby="a11y-external-message"><span
							class="__cf_email__">contact@domain.com</span></a>
					</p>
					<p class="text-paragraph mb-0">Phone: +1 (23) 456 789</p>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /modal delivery_return -->
<!-- gotop -->
<div class="progress-wrap">
	<svg class="progress-circle svg-content" width="100%" height="100%"
		 viewBox="-1 -1 102 102">
		<path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"
			  style="transition: stroke-dashoffset 10ms linear 0s; stroke-dasharray: 307.919, 307.919; stroke-dashoffset: 286.138;"></path>
	</svg>
</div>
<!-- /gotop -->

<script>
	var totalPriceVariant = function() {

		var basePrice = parseInt($(".price-on-sale-1").data("base-price-1"))
				|| parseInt($(".price-on-sale-1").text().replace("$", ""));
		var quantityInput = $(".quantity-product-1");

		$(".btn-increase").on("click", function() {
			var currentQuantity = parseInt(quantityInput.val());
			if (currentQuantity < ${totalAvailableQuantity}) {
				quantityInput.val(currentQuantity + 1);
				updateTotalPrice();
			}
		});

		$(".btn-decrease").on("click", function() {
			var currentQuantity = parseInt(quantityInput.val());
			if (currentQuantity > 1) {
				quantityInput.val(currentQuantity - 1);
				updateTotalPrice();
			}
		});

		function updateTotalPrice() {
			var currentPrice = parseInt($(".price-on-sale-1").text().replace(
					"VND", "").replace(/,/g, ""));
			var quantity = parseInt(quantityInput.val());
			var totalPrice = currentPrice * quantity;
			$(".total-price-1").text(
					Math.round(totalPrice).toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ",")
					+ " VND");
			console.log("currentPrice : " + currentPrice);
			console.log("totalPrice : " + totalPrice);
		}

	};

	totalPriceVariant();
	//swiper truot anh

	document.addEventListener("DOMContentLoaded", function() {
		// Khởi tạo Swiper cho thumbnails (ảnh thu nhỏ)
		var thumbsSwiper = new Swiper('.tf-product-media-thumbs', {
			direction: 'vertical', // Thumbs là chiều dọc
			slidesPerView: 4, // Số lượng ảnh thu nhỏ hiển thị mỗi lần
			spaceBetween: 10, // Khoảng cách giữa các thumbnail
			freeMode: true, // Cho phép di chuyển tự do
			watchSlidesVisibility: true, // Quan sát sự hiển thị của slides
			watchSlidesProgress: true, // Quan sát tiến độ các slide
		});

		// Khởi tạo Swiper cho gallery chính (ảnh lớn)
		var mainSwiper = new Swiper('.tf-product-media-main', {
			loop: true, // Cho phép vòng lặp các ảnh
			navigation: {
				nextEl: '.swiper-button-next', // Nút chuyển sang ảnh tiếp theo
				prevEl: '.swiper-button-prev', // Nút chuyển về ảnh trước
			},
			thumbs: {
				swiper: thumbsSwiper, // Liên kết Swiper chính với Swiper ảnh thu nhỏ
			},
			slidesPerView: 1, // Hiển thị 1 ảnh lớn mỗi lần
			spaceBetween: 10, // Khoảng cách giữa các slide
			pagination: {
				el: '.swiper-pagination', // Phân trang nếu cần
				clickable: true, // Cho phép click để chuyển trang
			},
		});
	});
	// them vao favorite product
	function toggleWishlistIcon(element, productId) {
		// Lấy các phần tử icon trong thẻ <a>
		var heartIcon = element.querySelector('.icon-heart');
		var deleteIcon = element.querySelector('.icon-delete');
		//console.log("display : ",window.getComputedStyle(heartIcon).getPropertyValue('display'));
		if (window.getComputedStyle(heartIcon).getPropertyValue('display') !== 'none') {
			console.log("productId111111111 : ", productId);
			addToFavoriteProducts(productId);

		} else {
			console.log("remove");
			removeFromFavoriteProducts(productId);
		}
	}
	function addToFavoriteProducts(productId) {
		const data = { productId: productId};

		// Gửi yêu cầu POST tới API của Spring Boot
		fetch('/product-detail/add-favorite-product', {
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
						console.log('Product added to favorite product!');
						// Có thể thay đổi giao diện sau khi thêm vào wishlist (ví dụ: đổi icon hoặc cập nhật số lượng)
					} else {
						console.log('Failed to add to favorite product.');
					}
				})
				.catch(error => {
					console.error('Error:', error);
					//alert('An error occurred while adding the product to wishlist.');
				});
	}

	function removeFromFavoriteProducts(productId) {
		// Tạo đối tượng dữ liệu gửi lên server
		const data = { productId: productId};

		// Gửi yêu cầu POST tới API của Spring Boot
		fetch('/product-detail/remove-favorite-product', {
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
						// Có thể thay đổi giao diện sau khi thêm vào wishlist (ví dụ: đổi icon hoặc cập nhật số lượng)
					} else {
						console.log('Failed to remove from favorite product.');
					}
				})
				.catch(error => {
					console.error('Error:', error);
				});
	}

	//nut tra loi comment
	function toggleReplyForm(id) {
		var form = document.getElementById("reply-form-" + id);
		// Kiểm tra xem form có đang hiển thị hay không, nếu có thì ẩn đi, nếu không thì hiển thị
		if (form.style.display === "none" || form.style.display === "") {
			form.style.display = "block";
		} else {
			form.style.display = "none";
		}
	}

	//nut tra loi comment
	function toggleReviewForm() {
		var form = document.getElementById("add-review");
		// Kiểm tra xem form có đang hiển thị hay không, nếu có thì ẩn đi, nếu không thì hiển thị
		if (form.style.display === "none" || form.style.display === "") {
			form.style.display = "block";
		} else {
			form.style.display = "none";
		}
	}
	// Hàm ẩn/hiện phần bình luận
	function toggleComments() {
		var commentWrap = document.querySelector('.reply-comment-wrap');
		var button = document.querySelector('.btn-toggle-comments');

		if (commentWrap.style.display === "none") {
			commentWrap.style.display = "block";
			button.innerText = "Hide comments"; // Đổi chữ thành "Ẩn Bình luận"
		} else {
			commentWrap.style.display = "none";
			button.innerText = "Show comments"; // Đổi chữ thành "Hiện Bình luận"
		}
	}
	//lắng nghe sự kiện click của button add to cart
	$(document).on("click", ".btn-add-to-cart", function (e) {
		e.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>

		// Lấy product ID từ thuộc tính data
		const productId = $(this).data("product-id");
		console.log("Product ID:", productId);
		// Lấy giá trị của trường input
		const quantityInput = document.querySelector(".quantity-product-1");
		const quantityValue = quantityInput.value;

		// Gửi yêu cầu AJAX đến controller
		$.ajax({
			url: "/product-detail/add-to-cart", // URL đến controller xử lý
			method: "POST", // Phương thức POST
			contentType: "application/json", // Loại dữ liệu gửi
			data: JSON.stringify({ productId: productId,
				quantity : quantityValue}), // Dữ liệu gửi đến server
			success: function (response) {
				console.log("Product added to cart successfully:", response);
				//alert("Product added to cart!");
				// Chuyển hướng đến một controller khác (URL khác)
				window.location.href = "/user/cart"; // URL đến trang mới
			},
			error: function (xhr, status, error) {
				if (xhr.status === 401) {
					// Nếu người dùng chưa đăng nhập, chuyển hướng tới trang login
					alert("You need to log in to add products to your cart.");
					window.location.href = "/login"; // URL của trang đăng nhập
					return;
				}
			}
		});
	});

	//lắng nghe sự kiện click của button buy product
	$(document).on("click", ".btn-buy-product", function (e) {
		e.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>

		// Lấy product ID từ thuộc tính data
		const productId = $(this).data("product-id");
		console.log("Product ID:", productId);
		// Lấy giá trị của trường input
		const quantityInput = document.querySelector(".quantity-product-1");
		const quantityValue = quantityInput.value;

		// Gửi yêu cầu AJAX đến controller
		$.ajax({
			url: "/product-detail/add-to-cart", // URL đến controller xử lý
			method: "POST", // Phương thức POST
			contentType: "application/json", // Loại dữ liệu gửi
			data: JSON.stringify({ productId: productId,
				quantity : quantityValue}), // Dữ liệu gửi đến server
			success: function (response) {
				console.log("Product added to cart successfully:", response);
				//alert("Product added to cart!");
				// Chuyển hướng đến một controller khác (URL khác)
				window.location.href = "/user/cart"; // URL đến trang mới
			},
			error: function (xhr, status, error) {
				console.log("status : ",status);
				console.log("xhr.status : ",xhr.status);
				if (xhr.status === 401) {
					// Nếu người dùng chưa đăng nhập, chuyển hướng tới trang login
					alert("You need to log in to add products to your cart.");
					window.location.href = "/login"; // URL của trang đăng nhập
					return;
				}
			}
		});
	});
</script>