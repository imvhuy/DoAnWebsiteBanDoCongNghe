<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div class="col-lg-9">
    <div class="my-account-content account-view text-center">
        <div class="account-details">

            <!-- Avatar -->
            <div class="account-avatar mb-4">
                <img src="${user.avatar}" alt="User Avatar" class="avatar-img">
            </div>

            <!-- Thông tin tài khoản -->
            <div class="account-info">
                <!-- ID -->
                <input class="tf-field-input tf-input" hidden type="text" id="id" name="id" value="${user.id}">
                <!-- Full Name -->
                <div class="account-field mb_15">
                    <label class="field-label fw-4 text_black-2">Full Name:</label>
                    <span class="field-value">${user.fullName}</span>
                </div>

                <!-- Email -->
                <div class="account-field mb_15">
                    <label class="field-label fw-4 text_black-2">Email:</label>
                    <span class="field-value">${user.email}</span>
                </div>

                <!-- Email Active Status -->
                <div class="account-field mb_15">
                    <label class="field-label fw-4 text_black-2">Email Status:</label>
                    <span class="field-value">${user.isEmailActive ? 'Active' : 'Inactive'}</span>
                </div>

                <!-- Nút mở modal để sửa -->
                <div class="mb_20">
                    <button type="button" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center" data-bs-toggle="modal" data-bs-target="#editAccountModal">
                        Change Password
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Modal Sửa Thông Tin Tài Khoản -->
<div class="modal fade" id="editAccountModal" tabindex="-1" aria-labelledby="editAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <!-- Header Modal -->
            <div class="modal-header" style="color: white;">
                <h5 class="modal-title" id="editAccountModalLabel">Change Password Account</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
            </div>

            <!-- Body Modal -->
            <div class="modal-body" style="background-color: white; color: black;">
                <form id="form-edit-account" action="${pageContext.request.contextPath}/profile/changePassword/${user.username}" method="POST">
                    <!-- Current Password -->
                    <div class="tf-field style-1 mb_30">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" id="currentPassword" name="currentPassword">
                        <label class="tf-field-label fw-4 text_black-2" for="currentPassword">Current password</label>
                    </div>

                    <!-- New Password -->
                    <div class="tf-field style-1 mb_30">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" id="newPassword" name="newPassword">
                        <label class="tf-field-label fw-4 text_black-2" for="newPassword">New password</label>
                    </div>

                    <!-- Confirm Password -->
                    <div class="tf-field style-1 mb_30">
                        <input class="tf-field-input tf-input" placeholder=" " type="password" id="confirmPassword" name="confirmPassword">
                        <label class="tf-field-label fw-4 text_black-2" for="confirmPassword">Confirm password</label>
                    </div>

                    <!-- Submit Button -->
                    <div class="mb_20">
                        <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

