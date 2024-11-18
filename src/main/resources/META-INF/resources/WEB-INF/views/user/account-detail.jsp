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
                <div class="account-field mb_15">
                    <label class="field-label fw-4 text_black-2">ID:</label>
                    <span class="field-value">${user.id}</span>
                </div>

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

                <!-- Roles -->
                <div class="account-field mb_15">
                    <label class="field-label fw-4 text_black-2">Roles:</label>
                    <span class="field-value">
                        <c:forEach var="role" items="${user.roles}">
                            ${role.name}
                            <c:if test="${!role.last}">, </c:if>
                        </c:forEach>
                    </span>
                </div>
            </div>

            <!-- Nút mở modal để sửa -->
            <div class="mb_20">
                <button type="button" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center" data-bs-toggle="modal" data-bs-target="#editAccountModal">
                    Edit Account
                </button>
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
                <h5 class="modal-title" id="editAccountModalLabel">Edit Account Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
            </div>

            <!-- Body Modal -->
            <div class="modal-body" style="background-color: white; color: black;">
                <form id="form-edit-account" action="/profile/updateAccount" method="POST">
                    <!-- Full Name -->
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" type="text" id="editFullName" name="fullName" value="${user.fullName}">
                        <label class="tf-field-label fw-4 text_black-2" for="editFullName">Full Name</label>
                    </div>

                    <!-- Email -->
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" type="email" id="editEmail" name="email" value="${user.email}">
                        <label class="tf-field-label fw-4 text_black-2" for="editEmail">Email</label>
                    </div>

                    <!-- Avatar -->
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" type="text" id="editAvatar" name="avatar" value="${user.avatar}">
                        <label class="tf-field-label fw-4 text_black-2" for="editAvatar">Avatar</label>
                    </div>

                    <!-- Roles -->
                    <div class="tf-field style-1 mb_15">
                        <input class="tf-field-input tf-input" type="text" id="editRoles" name="roles" value="${user.roles}">
                        <label class="tf-field-label fw-4 text_black-2" for="editRoles">Roles</label>
                    </div>

                    <!-- Nút Lưu -->
                    <div class="mb_20">
                        <button type="submit" class="tf-btn w-100 radius-3 btn-fill animate-hover-btn justify-content-center" style="background-color: #333; color: white;">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

