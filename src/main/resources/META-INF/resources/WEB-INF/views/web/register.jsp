<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-- Form đăng ký -->
<section class="flat-spacing-10">
    <div class="container">
        <div class="form-register-wrap">
            <div class="flat-title align-items-start gap-0 mb_30 px-0">
                <h5 class="mb_18">Register</h5>
                <p class="text_black-2">Sign up for early Sale access plus tailored new arrivals, trends, and promotions. To opt out, click unsubscribe in our emails</p>
            </div>
            <div>
                <form id="register-form"  accept-charset="utf-8">
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" id="property1" name="fullName" required>
                        <label class="tf-field-label fw-4 text_black-2" for="property1">Full name</label>
                    </div>
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" id="property2" name="username" required>
                        <label class="tf-field-label fw-4 text_black-2" for="property2">Username *</label>
                    </div>
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" placeholder=" " type="email" id="property3" name="email" required>
                        <label class="tf-field-label fw-4 text_black-2" for="property3">Email *</label>
                    </div>
                    <div class="tf-field style-1 mb_30">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" id="property4" name="password" required>
                        <label class="tf-field-label fw-4 text_black-2" for="property4">Password *</label>
                    </div>
                    <div class="mb_20">
                        <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center">Send OTP</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Form nhập OTP (bị ẩn cho đến khi gửi OTP thành công) -->
<section class="flat-spacing-10" id="otp-section" style="display: none;">
    <div class="container">
        <div class="form-register-wrap">
            <div class="flat-title align-items-start gap-0 mb_30 px-0">
                <h5 class="mb_18">Verify OTP</h5>
                <p class="text_black-2">Please enter the OTP sent to your email.</p>
            </div>
            <div>
                <form id="otp-form" accept-charset="utf-8">
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" placeholder=" " type="text" id="otp" name="otp" required>
                        <label class="tf-field-label fw-4 text_black-2" for="otp">OTP *</label>
                    </div>
                    <div class="mb_20">
                        <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center">Verify OTP</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function() {
        // Xử lý gửi form đăng ký
        $('#register-form').on('submit', function(event) {
            event.preventDefault(); // Ngăn không cho form tải lại trang

            var formData = $(this).serializeArray(); // Chuyển form thành array
            var dataObject = {};  // Tạo đối tượng để lưu dữ liệu

            // Chuyển đổi dữ liệu từ mảng thành đối tượng JSON
            formData.forEach(function(field) {
                dataObject[field.name] = field.value;
            });

            // Gửi yêu cầu gửi OTP qua AJAX
            $.ajax({
                url: 'api/auth/send-otp',  // API gửi OTP
                type: 'POST',
                contentType: 'application/json',  // Gửi dữ liệu dưới dạng JSON
                data: JSON.stringify(dataObject),  // Chuyển đối tượng thành JSON
                success: function(response) {
                    // Nếu gửi OTP thành công, hiển thị form OTP
                    $('#register-form').hide();  // Ẩn form đăng ký
                    $('#otp-section').show();    // Hiển thị form OTP
                },
                error: function(xhr, status, error) {
                    // Nếu có lỗi (bao gồm 400 Bad Request)
                    if (xhr.status === 400) {
                        var errorMessage = xhr.responseText || "Có lỗi xảy ra khi gửi yêu cầu.";
                        alert(errorMessage); // Hiển thị thông báo lỗi từ server
                    } else {
                        alert("Có lỗi không xác định: " + error);
                    }
                }
            });
        });

        // Xử lý xác thực OTP
        $('#otp-form').on('submit', function(event) {
            event.preventDefault(); // Ngăn không cho form tải lại trang

            var otp = $('#otp').val(); // Lấy giá trị OTP

            // Gửi yêu cầu xác thực OTP qua AJAX
            $.ajax({
                url: 'api/auth/verifyOtp',  // API xác thực OTP
                type: 'POST', // Gửi dữ liệu dưới dạng JSON
                data: { otp: otp }, // Gửi OTP dưới dạng JSON
                success: function(response) {
                    // Nếu OTP hợp lệ, chuyển hướng đến trang đăng ký
                    alert("Đăng ký thành công, ấn ok chuyển về trang đăng nhập");
                    window.location.href = '/login';  // Điều hướng đến trang đăng ký
                },
                error: function(xhr, status, error) {
                    // Nếu OTP không hợp lệ
                    alert('OTP không đúng hoặc đã hết hạn. Vui lòng thử lại.');
                }
            });
        });
    });


</script>