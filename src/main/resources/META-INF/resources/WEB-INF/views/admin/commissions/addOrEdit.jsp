<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!-- main-content -->
<div class="main-content">
	<!-- main-content-wrap -->
	<div class="main-content-inner">
		<!-- main-content-wrap -->
		<div class="main-content-wrap">
			<div class="flex items-center flex-wrap justify-between gap20 mb-30">
				<h3>${commission.id == null ? 'Add New Commission' : 'Edit Commission'}</h3>
				<ul
					class="breadcrumbs flex items-center flex-wrap justify-start gap10">
					<li><a href="index.html"><div class="text-tiny">Ecommerce</div></a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><a href="/admin/commissions" class="text-tiny">Commissions</a></li>
					<li><i class="icon-chevron-right"></i></li>
					<li><div class="text-tiny">${commission.id == null ? 'Add New Commission' : 'Edit Commission'}</div></li>
				</ul>
			</div>

			<!-- add-or-edit-commission -->
			<form class="form-add-or-edit-commission form-style-2" method="POST"
				action="/admin/commissions/saveOrUpdate">
				<!-- CSRF Token for security -->
				<input type="hidden" name="_csrf" value="${_csrf.token}">

				<!-- Hidden ID field for Edit -->
				<input type="hidden" name="id"
					value="${commission.id != null ? commission.id : ''}">

				<div class="wg-box">
					<div class="left">
						<h5 class="mb-4">Commission Details</h5>
						<div class="body-text">Fill in the information below to add
							or edit a commission</div>
					</div>
					<div class="right flex-grow">
						<!-- Commission Name -->
						<fieldset class="name mb-24">
							<div class="body-title mb-10">Commission Name</div>
							<input class="flex-grow" type="text"
								placeholder="Commission Name" name="name"
								value="${commission.name}" required>
						</fieldset>

						<!-- Commission Cost -->
						<fieldset class="cost mb-24">
							<div class="body-title mb-10">Cost</div>
							<input class="flex-grow" type="number" placeholder="Cost"
								name="cost" value="${commission.cost}" required>
						</fieldset>

						<!-- Commission Description -->
						<fieldset class="description mb-24">
							<div class="body-title mb-10">Description</div>
							<textarea class="flex-grow"
								placeholder="Description of the commission" name="description"
								rows="4" required>${commission.description}</textarea>
						</fieldset>
						<!-- Is Deleted -->
						<c:if test="${commission.id != null}">
						<fieldset class="isDeleted mb-24">
							<div class="body-title mb-10">Is Deleted?</div>
							<input type="checkbox" name="isDeleted" value="true"
								${commission.isDeleted ? 'checked' : ''}>
						</fieldset>
						</c:if>
						<!-- Select Store -->
						<fieldset class="store mb-24">
							<div class="body-title mb-10">Select Store</div>
							<select class="flex-grow" name="storeId"
								${commission.id != null ? 'disabled' : ''} required>
								<option value="" disabled ${commission.store==null ? 'selected' : ''}>Choose
									a Store</option>
								<c:forEach var="store" items="${storeList}">
									<c:if
										test="${store.commission == null || store.id == commission.store.id}">
										<option value="${store.id}"
											${store.id == (commission.store != null ? commission.store.id : null) ? 'selected' : ''}>
											${store.storeName}</option>
									</c:if>
								</c:forEach>
							</select>
							<!-- Thêm trường hidden để đảm bảo giá trị storeId được gửi đi -->
							<input type="hidden" name="storeId"
								value="${commission.store != null ? commission.store.id : ''}">
						</fieldset>

					</div>
				</div>

				<c:if test="${param.view != 'true'}">
					<div class="bot">
						<button class="tf-button w180" type="submit">${commission.id == null ? 'Add Commission' : 'Update Commission'}</button>
					</div>
				</c:if>
			</form>
			<!-- /add-or-edit-commission -->
		</div>
		<!-- /main-content-wrap -->
	</div>

	<!-- bottom-page -->
	<div class="bottom-page">
		<div class="body-text">
			Copyright © 2024 <a
				href="https://themesflat.co/html/ecomus/index.html">Ecomus</a>.
			Design by Themesflat All rights reserved
		</div>
	</div>
	<!-- /bottom-page -->
</div>
<!-- /main-content -->
