<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="col-lg-9">
	<div class="wd-form-order">
		<div class="order-head">
			<figure class="img-product">
				<img src="${order.user.avatar}" alt="product">
			</figure>
			<div class="content">
				<div class="badge">${order.status}</div>
				<h6 class="mt-8 fw-5">Order #${order.id}</h6>
			</div>
		</div>
		<div class="tf-grid-layout md-col-2 gap-15">
			<div class="item">
				<div class="text-2 text_black-2">Items</div>
				<div class="text-2 mt_4 fw-6">
					<c:forEach var="item" items="${orderItems}">
		            - ${item.product.name} (Quantity: ${item.count})<br />
					</c:forEach>
				</div>
			</div>

			<div class="item">
				<div class="text-2 text_black-2">Courier</div>
				<div class="text-2 mt_4 fw-6">${order.delivery.carrier.name}-
					${order.delivery.deliveryName}</div>
			</div>
			<div class="item">
				<div class="text-2 text_black-2">Start Time</div>
				<div class="text-2 mt_4 fw-6">
					<fmt:formatDate value="${order.createdDate}"
						pattern="MMMM d, yyyy hh:mm:ss a" />
				</div>

			</div>
			<div class="item">
				<div class="text-2 text_black-2">Address</div>
				<div class="text-2 mt_4 fw-6">${order.address}</div>
			</div>
		</div>
		<div class="widget-tabs style-has-border widget-order-tab">
			<ul class="widget-menu-tab">
				<li class="item-title active"><span class="inner">Order
						History</span></li>
				<li class="item-title"><span class="inner">Item Details</span>
				</li>

				<li class="item-title"><span class="inner">Courier</span></li>
				<c:if test="${order.status == 'đã vận chuyển'}">
					<li class="item-title"><span class="inner">Receiver</span></li>
				</c:if>
			</ul>
			<div class="widget-content-tab">
				<div class="widget-content-inner active">
					<div class="widget-timeline">
						<ul class="timeline">
							<li>
								<div class="timeline-badge success"></div>
								<div class="timeline-box">
									<a class="timeline-panel" href="javascript:void(0);">
										<div class="text-2 fw-6">Product Ordered</div> <span><strong>Date:</strong> <fmt:formatDate value="${order.createdDate}"
										pattern="MMMM d, yyyy hh:mm:ss a" /></span>
									</a>
									<p>
										<strong>Courier Service : </strong>${order.delivery.carrier.name}-
										${order.delivery.deliveryName}
									</p>									
								</div>
							</li>
							<li>
								<div class="timeline-badge success"></div>
								<div class="timeline-box">
									<a class="timeline-panel" href="javascript:void(0);">
										<div class="text-2 fw-6">Product Shipped</div> 
									</a>
									<p>
										<strong>Tracking Number : </strong> ${trackingCode}
									</p>
									<p>
										<strong>Warehouse : </strong>Kho Tổng Miền Nam ${order.delivery.carrier.name}
									</p>
									<p>
										<strong>Estimated Delivery Date : </strong> Three or Four Day....
									</p>
								</div>
							</li>
							<li>
							    <div class="<c:out value='${order.status == "đã vận chuyển" ? "timeline-badge success" : "timeline-badge"}' />"></div>
							    <div class="timeline-box">
							        <a class="timeline-panel" href="javascript:void(0);">
							            <div class="text-2 fw-6">Order Placed</div>
							          	  <c:if test="${order.status == 'đã vận chuyển'}">
								                <strong>Date:</strong>  
								                <span>
								                    <fmt:formatDate value="${order.modifiedDate}" pattern="MMMM d, yyyy hh:mm:ss a" />
								                </span>
								            </c:if>
							        </a>
							    </div>
							</li>

						</ul>
					</div>
				</div>
				<div class="widget-content-inner">
					<c:set var="subtotal" value="0" />
					<c:forEach var="orderItem" items="${order.orderItems}">
						<div class="row align-items-center">
							<!-- Phần Order Head -->
							<div class="col-md-6 order-head d-flex">
								<c:forEach var="gallery"
									items="${orderItem.product.galleryEntities}">
									<c:if test="${gallery.type == 'left'}">
										<img src="/admin/images/products/${gallery.image}"
											alt="Front Image" class="image" style="max-width: 200px;" />
									</c:if>
								</c:forEach>
								<div class="content ms-3">
									<div class="text-2 fw-6">${orderItem.product.name}</div>
									<div class="mt_4">
										<span class="fw-6">Price :</span>
										<fmt:formatNumber value="${orderItem.product.price}"
											pattern="#,###" />
										VNĐ
									</div>
									<div class="mt_4">
										<span class="fw-6">Quantity :</span> ${orderItem.count}
									</div>
								</div>
							</div>

							<!-- Phần Item Total -->
							<div class="col-md-6">
								<ul>
									<li class="d-flex justify-content-between text-2"><span
										class="fw-7"> Item Total: <fmt:formatNumber
												value="${orderItem.product.price * orderItem.count}"
												pattern="#,###" /> VNĐ
									</span></li>
								</ul>
							</div>
						</div>

						<!-- Cập nhật subtotal -->
						<c:set var="subtotal"
							value="${subtotal + (orderItem.product.price * orderItem.count)}" />
					</c:forEach>
					<c:set var="discountTotal"
						value="${subtotal - order.amountFromUser}" />
					<!-- Hiển thị tổng subtotal sau khi vòng lặp kết thúc -->
					<ul>
						<li class="d-flex justify-content-between text-2"><span>Total
								Price</span> <span class="fw-7"> <fmt:formatNumber
									value="${subtotal}" pattern="#,###" /> VNĐ
						</span></li>
					</ul>
					<ul>
						<li class="d-flex justify-content-between text-2 mt_4 pb_8 line"><span>Discount
								Total</span> <span class="fw-7"> <fmt:formatNumber
									value=" ${discountTotal}" pattern="#,###" /> VNĐ
						</span></li>
					</ul>
					<ul>
						<li class="d-flex justify-content-between text-2 mt_4 pb_8"><span>Order
								Total</span> <span class="fw-7"> <fmt:formatNumber
									value="${order.amountFromUser}" pattern="#,###" /> VNĐ
						</span></li>
					</ul>
				</div>



				<div class="widget-content-inner">
					<p>Our courier service is dedicated to providing fast,
						reliable, and secure delivery solutions tailored to meet your
						needs. Whether you're sending documents, parcels, or larger
						shipments, our team ensures that your items are handled with the
						utmost care and delivered on time. With a commitment to customer
						satisfaction, real-time tracking, and a wide network of routes, we
						make it easy for you to send and receive packages both locally and
						internationally. Choose our service for a seamless and efficient
						delivery experience.</p>
				</div>
				<c:if test="${order.status == 'đã vận chuyển'}">
					<div class="widget-content-inner">
						<p class="text-2 text_success">Thank you Your order has been
							received</p>
						<ul class="mt_20">
							<li>Order Number : <span class="fw-7">#${order.id}</span></li>
							<li>Date : <span class="fw-7"><fmt:formatDate
										value="${order.modifiedDate}"
										pattern="MMMM d, yyyy hh:mm:ss a" /></span></li>
							<li>Total : <span class="fw-7"> <fmt:formatNumber
										value="${order.amountFromUser}" pattern="#,###" /> VNĐ
							</span>
							</li>
							<li>Payment Methods : <span class="fw-7">${order.transaction.payment.method}</span></li>
						</ul>
					</div>
				</c:if>

				
			</div>
		</div>
	</div>
</div>


