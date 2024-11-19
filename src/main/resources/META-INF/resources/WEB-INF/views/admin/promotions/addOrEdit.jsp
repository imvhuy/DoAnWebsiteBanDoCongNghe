<!-- main-content -->
<div class="main-content">
    <!-- main-content-wrap -->
    <div class="main-content-inner">
        <!-- main-content-wrap -->
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-30">
                <h3>${voucher.id == null ? 'Add New Promotion' : 'Edit Promotion'}</h3>
                <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                    <li><a href="index.html"><div class="text-tiny">Ecommerce</div></a></li>
                    <li><i class="icon-chevron-right"></i></li>
                    <li><a href="/admin/promotions" class="text-tiny">Promotions</a></li>
                    <li><i class="icon-chevron-right"></i></li>
                    <li><div class="text-tiny">${voucher.id == null ? 'Add New Promotion' : 'Edit Promotion'}</div></li>
                </ul>
            </div>
            
            <!-- add-new-promotion -->
            <form class="form-add-new-promotion form-style-2" method="POST" action="/admin/promotions/saveOrUpdate">
                <!-- CSRF Token for security -->
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                
                <!-- Hidden ID field for Edit -->
                <input type="hidden" name="id" value="${voucher.id != null ? voucher.id : ''}">
                
                <div class="wg-box">
                    <div class="left">
                        <h5 class="mb-4">Promotion Details</h5>
                        <div class="body-text">Fill in the information below to add or edit a promotion</div>
                    </div>
                    <div class="right flex-grow">
                        <fieldset class="description-promotion mb-24">
                            <div class="body-title mb-10">Promotion Description</div>
                            <textarea class="flex-grow" placeholder="Description of the promotion" name="description" rows="4" tabindex="0" required>${voucher.description}</textarea>
                        </fieldset>
                        <fieldset class="discount mb-24">
                            <div class="body-title mb-10">Discount</div>
                            <input class="flex-grow" type="text" placeholder="Discount (e.g. 10%)" name="discount" tabindex="0" value="${voucher.discount}" required>
                        </fieldset>
                        <fieldset class="minimum-price mb-24">
                            <div class="body-title mb-10">Minimum Price</div>
                            <input class="flex-grow" type="number" placeholder="Minimum Price" name="minimumPrice" tabindex="0" value="${voucher.minimumPrice}" required>
                        </fieldset>
                        <fieldset class="quantity mb-24">
                            <div class="body-title mb-10">Quantity</div>
                            <input class="flex-grow" type="number" placeholder="Quantity" name="quantity" tabindex="0" value="${voucher.quantity}" required>
                        </fieldset>
						<fieldset class="start-date mb-24">
    						<div class="body-title mb-10">Start Date</div>
   							 <!-- Ensure that 'mfgDate' is formatted as 'yyyy-MM-dd' -->
   							 <input class="flex-grow" type="date" name="mfgDate" tabindex="0" value="${voucher.mfgDate != null ? voucher.mfgDate : ''}" required>
							 </fieldset>
						<fieldset class="end-date mb-24">
    							<div class="body-title mb-10">End Date</div>
    							<!-- Ensure that 'expDate' is formatted as 'yyyy-MM-dd' -->
    							<input class="flex-grow" type="date" name="expDate" tabindex="0" value="${voucher.expDate != null ? voucher.expDate : ''}" required>
						</fieldset>


                    		</div>
               		 </div>

                <div class="bot">
                    <button class="tf-button w180" type="submit">Save</button>
                </div>
            </form>
            <!-- /add-new-promotion -->
        </div>
        <!-- /main-content-wrap -->
    </div>

    <!-- bottom-page -->
    <div class="bottom-page">
        <div class="body-text">Copyright © 2024 <a href="https://themesflat.co/html/ecomus/index.html">Ecomus</a>. Design by Themesflat All rights reserved</div>
    </div>
    <!-- /bottom-page -->
</div>
<!-- /main-content -->
