
<!-- page-title -->
<div class="tf-page-title style-2">
    <div class="container-full">
        <div class="heading text-center">Log in</div>
    </div>
</div>
<!-- /page-title -->

<%--<c:if test="${message != null}" >--%>
<%--<div class="container">--%>
<%--    <!-- <h1 class="form-heading">login Form</h1> -->--%>
<%--    <div class="login-form">--%>
<%--        <div class="main-div">--%>
<%--            <div class="alert alert-danger">--%>
<%--                ${message}--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</c:if>--%>
<section class="flat-spacing-10">
    <div class="container">
        <div class="tf-grid-layout lg-col-2 tf-login-wrap">
            <div class="tf-login-form">
                <div id="recover">
                    <h5 class="mb_24">Reset your password</h5>
                    <p class="mb_30">We will send you an email to reset your password</p>
                    <div>
                        <form class="" id="forget-form" action="#" method="post" accept-charset="utf-8" data-mailchimp="true">
                            <div class="tf-field style-1 mb_15">
                                <input class="tf-field-input tf-input" placeholder="" type="email" id="email" name="email">
                                <label class="tf-field-label fw-4 text_black-2" for="email">Email *</label>
                            </div>
                            <div class="mb_20">
                                <a href="#login" class="tf-btn btn-line">Cancel</a>
                            </div>
                            <div class="">
                                <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center">Reset password</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div id="login">
                    <h5 class="mb_36">Log in</h5>
                    <div>
                        <form class="" id="login-form" action="/login" method="post" accept-charset="utf-8">
                            <div class="tf-field style-1 mb_15">
                                <input class="tf-field-input tf-input" placeholder="" type="text" id="username" name="username" required>
                                <label class="tf-field-label fw-4 text_black-2" for="username">Username *</label>
                            </div>
                            <div class="tf-field style-1 mb_30">
                                <input class="tf-field-input tf-input" placeholder="" type="password" id="password" name="password" required>
                                <label class="tf-field-label fw-4 text_black-2" for="password">Password *</label>
                            </div>
                            <div class="mb_20">
                                <a href="#recover" class="tf-btn btn-line">Forgot your password?</a>
                            </div>
                            <div class="">
                                <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center">Log in</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="tf-login-content">
                <h5 class="mb_36">I'm new here</h5>
                <p class="mb_20">Sign up for early Sale access plus tailored new arrivals, trends and promotions. To opt out, click unsubscribe in our emails.</p>
                <a href="register.html" class="tf-btn btn-line">Register<i class="icon icon-arrow1-top-left"></i></a>
            </div>
        </div>
    </div>
</section>
