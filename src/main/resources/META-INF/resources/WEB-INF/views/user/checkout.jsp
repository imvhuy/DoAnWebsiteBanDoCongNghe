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
						<div class="box grid-2">
							<fieldset class="fieldset">
								<label for="first-name">First Name</label> <input type="text"
									id="first-name" placeholder="Themesflat">
							</fieldset>
							<fieldset class="fieldset">
								<label for="last-name">Last Name</label> <input type="text"
									id="last-name">
							</fieldset>
						</div>
						<fieldset class="box fieldset">
							<label for="country">Country/Region</label>
							<div class="select-custom">
								<select class="tf-select w-100" id="country"
									name="address[country]" data-default="">
									<option value="---" data-provinces="[]">---</option>
									<option value="Australia"
										data-provinces="[['Australian Capital Territory','Australian Capital Territory'],['New South Wales','New South Wales'],['Northern Territory','Northern Territory'],['Queensland','Queensland'],['South Australia','South Australia'],['Tasmania','Tasmania'],['Victoria','Victoria'],['Western Australia','Western Australia']]">Australia</option>
									<option value="Austria" data-provinces="[]">Austria</option>
									<option value="Belgium" data-provinces="[]">Belgium</option>
									<option value="Canada"
										data-provinces="[['Alberta','Alberta'],['British Columbia','British Columbia'],['Manitoba','Manitoba'],['New Brunswick','New Brunswick'],['Newfoundland and Labrador','Newfoundland and Labrador'],['Northwest Territories','Northwest Territories'],['Nova Scotia','Nova Scotia'],['Nunavut','Nunavut'],['Ontario','Ontario'],['Prince Edward Island','Prince Edward Island'],['Quebec','Quebec'],['Saskatchewan','Saskatchewan'],['Yukon','Yukon']]">Canada</option>
									<option value="Czech Republic" data-provinces="[]">Czechia</option>
									<option value="Denmark" data-provinces="[]">Denmark</option>
									<option value="Finland" data-provinces="[]">Finland</option>
									<option value="France" data-provinces="[]">France</option>
									<option value="Germany" data-provinces="[]">Germany</option>
									<option value="Hong Kong"
										data-provinces="[['Hong Kong Island','Hong Kong Island'],['Kowloon','Kowloon'],['New Territories','New Territories']]">Hong
										Kong SAR</option>
									<option value="Ireland"
										data-provinces="[['Carlow','Carlow'],['Cavan','Cavan'],['Clare','Clare'],['Cork','Cork'],['Donegal','Donegal'],['Dublin','Dublin'],['Galway','Galway'],['Kerry','Kerry'],['Kildare','Kildare'],['Kilkenny','Kilkenny'],['Laois','Laois'],['Leitrim','Leitrim'],['Limerick','Limerick'],['Longford','Longford'],['Louth','Louth'],['Mayo','Mayo'],['Meath','Meath'],['Monaghan','Monaghan'],['Offaly','Offaly'],['Roscommon','Roscommon'],['Sligo','Sligo'],['Tipperary','Tipperary'],['Waterford','Waterford'],['Westmeath','Westmeath'],['Wexford','Wexford'],['Wicklow','Wicklow']]">Ireland</option>
									<option value="Israel" data-provinces="[]">Israel</option>
									<option value="Italy"
										data-provinces="[['Agrigento','Agrigento'],['Alessandria','Alessandria'],['Ancona','Ancona'],['Aosta','Aosta Valley'],['Arezzo','Arezzo'],['Ascoli Piceno','Ascoli Piceno'],['Asti','Asti'],['Avellino','Avellino'],['Bari','Bari'],['Barletta-Andria-Trani','Barletta-Andria-Trani'],['Belluno','Belluno'],['Benevento','Benevento'],['Bergamo','Bergamo'],['Biella','Biella'],['Bologna','Bologna'],['Bolzano','South Tyrol'],['Brescia','Brescia'],['Brindisi','Brindisi'],['Cagliari','Cagliari'],['Caltanissetta','Caltanissetta'],['Campobasso','Campobasso'],['Carbonia-Iglesias','Carbonia-Iglesias'],['Caserta','Caserta'],['Catania','Catania'],['Catanzaro','Catanzaro'],['Chieti','Chieti'],['Como','Como'],['Cosenza','Cosenza'],['Cremona','Cremona'],['Crotone','Crotone'],['Cuneo','Cuneo'],['Enna','Enna'],['Fermo','Fermo'],['Ferrara','Ferrara'],['Firenze','Florence'],['Foggia','Foggia'],['Forlì-Cesena','Forlì-Cesena'],['Frosinone','Frosinone'],['Genova','Genoa'],['Gorizia','Gorizia'],['Grosseto','Grosseto'],['Imperia','Imperia'],['Isernia','Isernia'],['L'Aquila','L’Aquila'],['La Spezia','La Spezia'],['Latina','Latina'],['Lecce','Lecce'],['Lecco','Lecco'],['Livorno','Livorno'],['Lodi','Lodi'],['Lucca','Lucca'],['Macerata','Macerata'],['Mantova','Mantua'],['Massa-Carrara','Massa and Carrara'],['Matera','Matera'],['Medio Campidano','Medio Campidano'],['Messina','Messina'],['Milano','Milan'],['Modena','Modena'],['Monza e Brianza','Monza and Brianza'],['Napoli','Naples'],['Novara','Novara'],['Nuoro','Nuoro'],['Ogliastra','Ogliastra'],['Olbia-Tempio','Olbia-Tempio'],['Oristano','Oristano'],['Padova','Padua'],['Palermo','Palermo'],['Parma','Parma'],['Pavia','Pavia'],['Perugia','Perugia'],['Pesaro e Urbino','Pesaro and Urbino'],['Pescara','Pescara'],['Piacenza','Piacenza'],['Pisa','Pisa'],['Pistoia','Pistoia'],['Pordenone','Pordenone'],['Potenza','Potenza'],['Prato','Prato'],['Ragusa','Ragusa'],['Ravenna','Ravenna'],['Reggio Calabria','Reggio Calabria'],['Reggio Emilia','Reggio Emilia'],['Rieti','Rieti'],['Rimini','Rimini'],['Roma','Rome'],['Rovigo','Rovigo'],['Salerno','Salerno'],['Sassari','Sassari'],['Savona','Savona'],['Siena','Siena'],['Siracusa','Syracuse'],['Sondrio','Sondrio'],['Taranto','Taranto'],['Teramo','Teramo'],['Terni','Terni'],['Torino','Turin'],['Trapani','Trapani'],['Trento','Trentino'],['Treviso','Treviso'],['Trieste','Trieste'],['Udine','Udine'],['Varese','Varese'],['Venezia','Venice'],['Verbano-Cusio-Ossola','Verbano-Cusio-Ossola'],['Vercelli','Vercelli'],['Verona','Verona'],['Vibo Valentia','Vibo Valentia'],['Vicenza','Vicenza'],['Viterbo','Viterbo']]">Italy</option>
									<option value="Japan"
										data-provinces="[['Aichi','Aichi'],['Akita','Akita'],['Aomori','Aomori'],['Chiba','Chiba'],['Ehime','Ehime'],['Fukui','Fukui'],['Fukuoka','Fukuoka'],['Fukushima','Fukushima'],['Gifu','Gifu'],['Gunma','Gunma'],['Hiroshima','Hiroshima'],['Hokkaidō','Hokkaido'],['Hyōgo','Hyogo'],['Ibaraki','Ibaraki'],['Ishikawa','Ishikawa'],['Iwate','Iwate'],['Kagawa','Kagawa'],['Kagoshima','Kagoshima'],['Kanagawa','Kanagawa'],['Kumamoto','Kumamoto'],['Kyōto','Kyoto'],['Kōchi','Kochi'],['Mie','Mie'],['Miyagi','Miyagi'],['Miyazaki','Miyazaki'],['Nagano','Nagano'],['Nagasaki','Nagasaki'],['Nara','Nara'],['Niigata','Niigata'],['Okayama','Okayama'],['Okinawa','Okinawa'],['Saga','Saga'],['Saitama','Saitama'],['Shiga','Shiga'],['Shimane','Shimane'],['Shizuoka','Shizuoka'],['Tochigi','Tochigi'],['Tokushima','Tokushima'],['Tottori','Tottori'],['Toyama','Toyama'],['Tōkyō','Tokyo'],['Wakayama','Wakayama'],['Yamagata','Yamagata'],['Yamaguchi','Yamaguchi'],['Yamanashi','Yamanashi'],['Ōita','Oita'],['Ōsaka','Osaka']]">Japan</option>
									<option value="Malaysia"
										data-provinces="[['Johor','Johor'],['Kedah','Kedah'],['Kelantan','Kelantan'],['Kuala Lumpur','Kuala Lumpur'],['Labuan','Labuan'],['Melaka','Malacca'],['Negeri Sembilan','Negeri Sembilan'],['Pahang','Pahang'],['Penang','Penang'],['Perak','Perak'],['Perlis','Perlis'],['Putrajaya','Putrajaya'],['Sabah','Sabah'],['Sarawak','Sarawak'],['Selangor','Selangor'],['Terengganu','Terengganu']]">Malaysia</option>
									<option value="Netherlands" data-provinces="[]">Netherlands</option>
									<option value="New Zealand"
										data-provinces="[['Auckland','Auckland'],['Bay of Plenty','Bay of Plenty'],['Canterbury','Canterbury'],['Chatham Islands','Chatham Islands'],['Gisborne','Gisborne'],['Hawke's Bay','Hawke’s Bay'],['Manawatu-Wanganui','Manawatū-Whanganui'],['Marlborough','Marlborough'],['Nelson','Nelson'],['Northland','Northland'],['Otago','Otago'],['Southland','Southland'],['Taranaki','Taranaki'],['Tasman','Tasman'],['Waikato','Waikato'],['Wellington','Wellington'],['West Coast','West Coast']]">New
										Zealand</option>
									<option value="Norway" data-provinces="[]">Norway</option>
									<option value="Poland" data-provinces="[]">Poland</option>
									<option value="Portugal"
										data-provinces="[['Aveiro','Aveiro'],['Açores','Azores'],['Beja','Beja'],['Braga','Braga'],['Bragança','Bragança'],['Castelo Branco','Castelo Branco'],['Coimbra','Coimbra'],['Faro','Faro'],['Guarda','Guarda'],['Leiria','Leiria'],['Lisboa','Lisbon'],['Madeira','Madeira'],['Portalegre','Portalegre'],['Porto','Porto'],['Santarém','Santarém'],['Setúbal','Setúbal'],['Viana do Castelo','Viana do Castelo'],['Vila Real','Vila Real'],['Viseu','Viseu'],['Évora','Évora']]">Portugal</option>
									<option value="Singapore" data-provinces="[]">Singapore</option>
									<option value="South Korea"
										data-provinces="[['Busan','Busan'],['Chungbuk','North Chungcheong'],['Chungnam','South Chungcheong'],['Daegu','Daegu'],['Daejeon','Daejeon'],['Gangwon','Gangwon'],['Gwangju','Gwangju City'],['Gyeongbuk','North Gyeongsang'],['Gyeonggi','Gyeonggi'],['Gyeongnam','South Gyeongsang'],['Incheon','Incheon'],['Jeju','Jeju'],['Jeonbuk','North Jeolla'],['Jeonnam','South Jeolla'],['Sejong','Sejong'],['Seoul','Seoul'],['Ulsan','Ulsan']]">South
										Korea</option>
									<option value="Spain"
										data-provinces="[['A Coruña','A Coruña'],['Albacete','Albacete'],['Alicante','Alicante'],['Almería','Almería'],['Asturias','Asturias Province'],['Badajoz','Badajoz'],['Balears','Balears Province'],['Barcelona','Barcelona'],['Burgos','Burgos'],['Cantabria','Cantabria Province'],['Castellón','Castellón'],['Ceuta','Ceuta'],['Ciudad Real','Ciudad Real'],['Cuenca','Cuenca'],['Cáceres','Cáceres'],['Cádiz','Cádiz'],['Córdoba','Córdoba'],['Girona','Girona'],['Granada','Granada'],['Guadalajara','Guadalajara'],['Guipúzcoa','Gipuzkoa'],['Huelva','Huelva'],['Huesca','Huesca'],['Jaén','Jaén'],['La Rioja','La Rioja Province'],['Las Palmas','Las Palmas'],['León','León'],['Lleida','Lleida'],['Lugo','Lugo'],['Madrid','Madrid Province'],['Melilla','Melilla'],['Murcia','Murcia'],['Málaga','Málaga'],['Navarra','Navarra'],['Ourense','Ourense'],['Palencia','Palencia'],['Pontevedra','Pontevedra'],['Salamanca','Salamanca'],['Santa Cruz de Tenerife','Santa Cruz de Tenerife'],['Segovia','Segovia'],['Sevilla','Seville'],['Soria','Soria'],['Tarragona','Tarragona'],['Teruel','Teruel'],['Toledo','Toledo'],['Valencia','Valencia'],['Valladolid','Valladolid'],['Vizcaya','Biscay'],['Zamora','Zamora'],['Zaragoza','Zaragoza'],['Álava','Álava'],['Ávila','Ávila']]">Spain</option>
									<option value="Sweden" data-provinces="[]">Sweden</option>
									<option value="Switzerland" data-provinces="[]">Switzerland</option>
									<option value="United Arab Emirates"
										data-provinces="[['Abu Dhabi','Abu Dhabi'],['Ajman','Ajman'],['Dubai','Dubai'],['Fujairah','Fujairah'],['Ras al-Khaimah','Ras al-Khaimah'],['Sharjah','Sharjah'],['Umm al-Quwain','Umm al-Quwain']]">United
										Arab Emirates</option>
									<option value="United Kingdom"
										data-provinces="[['British Forces','British Forces'],['England','England'],['Northern Ireland','Northern Ireland'],['Scotland','Scotland'],['Wales','Wales']]">United
										Kingdom</option>
									<option value="United States"
										data-provinces="[['Alabama','Alabama'],['Alaska','Alaska'],['American Samoa','American Samoa'],['Arizona','Arizona'],['Arkansas','Arkansas'],['Armed Forces Americas','Armed Forces Americas'],['Armed Forces Europe','Armed Forces Europe'],['Armed Forces Pacific','Armed Forces Pacific'],['California','California'],['Colorado','Colorado'],['Connecticut','Connecticut'],['Delaware','Delaware'],['District of Columbia','Washington DC'],['Federated States of Micronesia','Micronesia'],['Florida','Florida'],['Georgia','Georgia'],['Guam','Guam'],['Hawaii','Hawaii'],['Idaho','Idaho'],['Illinois','Illinois'],['Indiana','Indiana'],['Iowa','Iowa'],['Kansas','Kansas'],['Kentucky','Kentucky'],['Louisiana','Louisiana'],['Maine','Maine'],['Marshall Islands','Marshall Islands'],['Maryland','Maryland'],['Massachusetts','Massachusetts'],['Michigan','Michigan'],['Minnesota','Minnesota'],['Mississippi','Mississippi'],['Missouri','Missouri'],['Montana','Montana'],['Nebraska','Nebraska'],['Nevada','Nevada'],['New Hampshire','New Hampshire'],['New Jersey','New Jersey'],['New Mexico','New Mexico'],['New York','New York'],['North Carolina','North Carolina'],['North Dakota','North Dakota'],['Northern Mariana Islands','Northern Mariana Islands'],['Ohio','Ohio'],['Oklahoma','Oklahoma'],['Oregon','Oregon'],['Palau','Palau'],['Pennsylvania','Pennsylvania'],['Puerto Rico','Puerto Rico'],['Rhode Island','Rhode Island'],['South Carolina','South Carolina'],['South Dakota','South Dakota'],['Tennessee','Tennessee'],['Texas','Texas'],['Utah','Utah'],['Vermont','Vermont'],['Virgin Islands','U.S. Virgin Islands'],['Virginia','Virginia'],['Washington','Washington'],['West Virginia','West Virginia'],['Wisconsin','Wisconsin'],['Wyoming','Wyoming']]">United
										States</option>
									<option value="Vietnam" data-provinces="[]">Vietnam</option>
								</select>
							</div>
						</fieldset>
						<fieldset class="box fieldset">
							<label for="city">Town/City</label> <input type="text" id="city">
						</fieldset>
						<fieldset class="box fieldset">
							<div class="select-custom">
								<label for="address">Address</label> <select id="address-select"
									name="address" class="tf-select w-100"
									onchange="updateHiddenAddress()">
									<c:forEach var="address" items="${addresses}">
										<option value="${address.id}">Name:
											${address.fullName}, Phone: ${address.phone}, Address:
											${address.address}</option>
									</c:forEach>
								</select>
							</div>
						</fieldset>
						<fieldset class="box fieldset">
							<label for="phone">Phone Number</label> <input type="number"
								id="phone">
						</fieldset>
						<fieldset class="box fieldset">
							<label for="email">Email</label> <input type="email" id="email">
						</fieldset>
						<fieldset class="box fieldset">
							<label for="note">Order notes (optional)</label>
							<textarea name="note" id="note"></textarea>
						</fieldset>
					</form>
				</div>
				<div class="tf-page-cart-footer">
					<div class="tf-cart-footer-inner">
						<h5 class="fw-5 mb_20">Your order</h5>
						<form class="tf-page-cart-checkout widget-wrap-checkout"
							action="/user/cart/checkout/placeOrder" method="post">

							<ul class="wrap-checkout-product">
								<c:set var="totalAmount" value="0" />
								<!-- Khởi tạo tổng ban đầu -->
								<c:forEach var="cartProduct" items="${cartProducts}">
									<!-- Cập nhật tổng giá trị sản phẩm -->
									<c:set var="totalAmount"
										value="${totalAmount + (cartProduct.price * cartProduct.quantity)}" />
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
											<span class="price"><fmt:formatNumber
													value="${cartProduct.price * cartProduct.quantity}"
													type="number" maxFractionDigits="0" /> VND</span>
										</div>
									</li>
								</c:forEach>
							</ul>
							<div class="coupon-box">
								<select id="coupon-select" name="coupon-select"
									class="tf-select w-100">
									<option value=0
											data-discount=""></option>
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
									<c:forEach var="carrier" items="${carrieres}">
										<option value="${carrier.id}" data-price="${carrier.price}">
											${carrier.name}</option>
									</c:forEach>
								</select> <span class="total fw-5" id="shippingFee"> <fmt:formatNumber
										value="${carrieres[0].price + 50000}" type="number"
										maxFractionDigits="0" /> VND
								</span>
							</div>
							<div class="d-flex justify-content-between line pb_20">
								<h6 class="fw-5">Total</h6>
								<h6 class="total fw-5" id="total">
									<fmt:formatNumber value="${totalAmount + carrieres[0].price + 50000}" type="number"
										maxFractionDigits="0" />
									VND
								</h6>
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
							<button type="submit"
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
</script>
