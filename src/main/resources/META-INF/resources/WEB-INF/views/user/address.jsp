<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="col-lg-9">
    <div class="my-account-content account-address">
        <div class="text-center widget-inner-address">
            <!-- Button to Open Modal -->
            <button type="button" class="tf-btn btn-fill animate-hover-btn btn-address mb_20" data-bs-toggle="modal"
                    data-bs-target="#addressModal" onclick="resetForm();">
                Add New Address
            </button>

            <div class="list-account-address">
                <c:forEach var="address" items="${addresses}">
                    <div class="account-address-item border p-3 mb-3"
                         data-fullname="${address.fullName}"
                         data-address="${address.address}"
                         data-phone="${address.phone}"
                         data-default="${address.isDefault}">

                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <p hidden="hidden">${address.id} </p>
                            <p class="fw-bold m-0">${address.fullName}</p>
                            <c:choose>
                                <c:when test="${address.isDefault}">
                                    <span class="badge bg-primary">Default</span>
                                </c:when>
                            </c:choose>
                        </div>

                        <div class="address-details">
                            <p class="m-0">Address: ${address.address}</p>
                            <p class="m-0">Phone: ${address.phone}</p>
                        </div>

                        <div class="d-flex gap-2 mt-3">
                            <div class="address-item">
                                <button type="button" class="tf-btn btn-fill animate-hover-btn btn-edit-address"
                                        data-bs-toggle="modal"
                                        data-bs-target="#addressModal"
                                        data-id="${address.id}"
                                        data-fullname="${address.fullName}"
                                        data-street="${address.street}"
                                        data-province="${address.province}"
                                        data-district="${address.district}"
                                        data-ward="${address.ward}"
                                        data-phone="${address.phone}"
                                        data-isdefault="${address.isDefault}" onclick="populateAddressModal(this)">
                                    Edit
                                </button>
                            </div>
                            <!-- Nút Delete -->
                            <button type="button" class="tf-btn btn-outline animate-hover-btn"
                                    onclick="confirmDelete(${address.id})">
                                <span>Delete</span>
                            </button>

                            <!-- Modal Xác Nhận Xóa -->
                            <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <!-- Header Modal -->
                                        <div class="modal-header" style="background-color: white; color: white;">
                                            <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Delete</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                                                    style="filter: invert(1);"></button>
                                        </div>

                                        <!-- Nội dung Modal -->
                                        <div class="modal-body" style="background-color: white; color: black;">
                                            Are you sure you want to delete this address?
                                        </div>

                                        <!-- Footer Modal -->
                                        <div class="modal-footer" style="background-color: white;">
                                            <button type="button" class="tf-btn btn-fill animate-hover-btn"
                                                    style="background-color: black; color: white;" data-bs-dismiss="modal">
                                                Cancel
                                            </button>
                                            <button type="button" class="tf-btn btn-fill animate-hover-btn"
                                                    style="background-color: black; color: white;" onclick="deleteAddress()">
                                                Confirm
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Modal (Add/Edit) -->
            <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addressModalLabel">Add a New Address</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form class="show-form-address wd-form-address" id="formAddress"
                                  action="/profile/saveOrUpdate/${pageContext.request.userPrincipal.name}"
                                  method="POST">
                                <input type="hidden" name="id" id="addressId" value=""/>
                                <div class="box-field mb-3">
                                    <div class="tf-field style-1">
                                        <input type="text" name="fullName" class="tf-field-input tf-input"
                                               placeholder=" "
                                               id="fullName" value=""/>
                                        <label class="tf-field-label fw-4 text_black-2" for="fullName">Full Name</label>
                                    </div>
                                </div>
                                <div class="box-field mb-3">
                                    <div class="tf-field style-1">
                                        <input type="text" name="street" class="tf-field-input tf-input" placeholder=" "
                                               id="street" value=""/>
                                        <label class="tf-field-label fw-4 text_black-2" for="street">Street</label>
                                    </div>
                                </div>
                                <div class="box-field mb-3">
                                    <label for="province"
                                           class="mb_10 fw-4 text-start d-block text_black-2">Province</label>
                                    <div class="select-custom">
                                        <select name="province" class="tf-select w-100" id="province"
                                                onchange="updateDistricts();">
                                            <option value="">Select Province</option>
                                            <c:forEach var="prov" items="${provinces}">
                                                <option value="${prov.code_with_type}">${prov.name_with_type}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="box-field mb-3">
                                    <label for="district"
                                           class="mb_10 fw-4 text-start d-block text_black-2">District</label>
                                    <div class="select-custom">
                                        <select name="district" class="tf-select w-100" id="district"
                                                onchange="updateWards();">
                                            <option value="">Select District</option>
                                            <c:forEach var="dist" items="${districts}">
                                                <option value="${dist.code_with_type}">${dist.name_with_type}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="box-field mb-3">
                                    <label for="ward" class="mb_10 fw-4 text-start d-block text_black-2">Ward</label>
                                    <div class="select-custom">
                                        <select name="ward" class="tf-select w-100" id="ward" onchange="updateSelectedLocation()">
                                            <option value="">Select Ward</option>
                                            <c:forEach var="ward" items="${wards}" >
                                                <option value="${ward.code_with_type}">${ward.name_with_type}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="box-field mb-3">
                                    <div class="tf-field style-1">
                                        <input type="text" name="phone" class="tf-field-input tf-input" placeholder=" "
                                               id="phone" value=""/>
                                        <label class="tf-field-label fw-4 text_black-2" for="phone">Phone</label>
                                    </div>
                                </div>
                                <div class="box-field text-start mb-3">
                                    <div class="box-checkbox fieldset-radio d-flex align-items-center gap-8">
                                        <input type="checkbox" name="isDefault" id="check-new-address"
                                               class="tf-check"/>
                                        <label for="check-new-address" class="text_black-2 fw-4">Set as default
                                            address</label>
                                    </div>
                                </div>
                                <input type="hidden" name="address" id="address"/>
                                <div class="d-flex align-items-center justify-content-center gap-20"
                                     style="height: 60px;">
                                    <button type="button" class="tf-btn btn-fill animate-hover-btn"
                                            onclick="updateSelectedLocation(); document.getElementById('formAddress').submit();">
                                        <span id="formActionLabel">Add Address</span>
                                    </button>
                                    <span class="tf-btn btn-fill animate-hover-btn btn-hide-address"
                                          data-bs-dismiss="modal">Cancel</span>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Modal -->


        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let provincesData = {};
    let districtsData = {};
    let wardsData = {};

    async function loadData() {
        try {
            const provincesResponse = await fetch('/api/province');
            provincesData = await provincesResponse.json();

            const districtsResponse = await fetch('/api/district');
            districtsData = await districtsResponse.json();

            const wardsResponse = await fetch('/api/ward');
            wardsData = await wardsResponse.json();

            populateProvinces();
        } catch (error) {
            console.error("Error loading data:", error);
        }
    }


    function populateProvinces() {
        const provinceSelect = document.getElementById("province");
        provinceSelect.innerHTML = '<option value="">Province</option>';

        for (const code in provincesData) {
            const option = document.createElement("option");
            option.value = code;
            option.text = provincesData[code].name_with_type;
            provinceSelect.add(option);
        }
    }

    function updateDistricts() {
        const provinceCode = document.getElementById("province").value;
        const districtSelect = document.getElementById("district");
        const wardSelect = document.getElementById("ward");

        districtSelect.innerHTML = '<option value="">District</option>';
        wardSelect.innerHTML = '<option value="">Ward</option>';

        for (const code in districtsData) {
            if (districtsData[code].parent_code === provinceCode) {
                const option = document.createElement("option");
                option.value = code;
                option.text = districtsData[code].name_with_type;
                districtSelect.add(option);
            }
        }
    }

    function updateWards() {
        const districtCode = document.getElementById("district").value;
        const wardSelect = document.getElementById("ward");

        wardSelect.innerHTML = '<option value="">Ward</option>';

        for (const code in wardsData) {
            if (wardsData[code].parent_code === districtCode) {
                const option = document.createElement("option");
                option.value = code;
                option.text = wardsData[code].name_with_type;
                wardSelect.add(option);
            }
        }
    }

    function updateSelectedLocation() {
        const streetInput = document.getElementById("street").value.trim();
        const wardSelect = document.getElementById("ward");
        const districtSelect = document.getElementById("district");
        const provinceSelect = document.getElementById("province");

        const wardCode = wardSelect.value;
        const districtCode = districtSelect.value;
        const provinceCode = provinceSelect.value;

        const wardName = wardCode ? wardsData[wardCode].name_with_type : '';
        const districtName = districtCode ? districtsData[districtCode].name_with_type : '';
        const provinceName = provinceCode ? provincesData[provinceCode].name_with_type : '';

        const fullAddress = streetInput + ', ' + wardName + ', ' + districtName + ', ' + provinceName;
        document.getElementById("address").value = fullAddress;
    }

    function convertNameToCode(nameWithType, data) {
        for (const code in data) {
            if (data[code].name_with_type === nameWithType) {
                return code;
            }
        }
        return null; // Trả về null nếu không tìm thấy
    }

    function setDropdownValue(dropdownId, value) {
        const dropdown = document.getElementById(dropdownId);
        if (dropdown) {
            for (let i = 0; i < dropdown.options.length; i++) {
                if (dropdown.options[i].value.trim() === value.trim()) {
                    dropdown.selectedIndex = i;
                    break;
                }
            }
        }
    }

    function populateAddressModal(button) {
        const $button = $(button);
        resetForm();  // Clear the form each time the modal is opened for adding or editing

        // Extract data from "Edit" button if editing, otherwise skip
        const id = $button.data('id');
        const fullName = $button.data('fullname');
        const street = $button.data('street');
        const province = $button.data('province');
        const district = $button.data('district');
        const ward = $button.data('ward');
        const phone = $button.data('phone');
        const isDefault = $button.data('isdefault');

        if (id) {  // Populate fields if editing
            $('#addressId').val(id);
            $('#formActionLabel').text('Update Address');
            $('#fullName').val(fullName);
            $('#street').val(street);
            $('#phone').val(phone);
            $('#check-new-address').prop('checked', isDefault);
            const provinceCode = convertNameToCode(province, provincesData)
            const districtCode = convertNameToCode(district, districtsData)
            const wardCode = convertNameToCode(ward, wardsData)
            setDropdownValue('province', provinceCode);
            updateDistricts();
            setDropdownValue('district', districtCode);
            updateWards();
            setDropdownValue('ward', wardCode);
        } else {
            $('#formActionLabel').text('Add Address');
        }
    }

    $('#addressModal').on('show.bs.modal', function (event) {
        const button = $(event.relatedTarget); // Button that triggered the modal
        if (button.hasClass('btn-edit-address')) {
            populateAddressModal(button);
        } else {
            resetForm();  // Reset form for "Add" functionality to clear fields
        }
    });

    function resetForm() {
        // Clear input fields and reset selections
        $('#addressId').val('');
        $('#fullName').val('');
        $('#street').val('');
        $('#phone').val('');
        $('#check-new-address').prop('checked', false);

        // Reset dropdowns
        setDropdownValue('province', '');
        setDropdownValue('district', '');
        setDropdownValue('ward', '');

        // Reset form action label
        $('#formActionLabel').text('Add Address');
    }

    let deleteAddressId;

    // Hàm hiển thị modal xác nhận xóa
    function confirmDelete(addressId) {
        deleteAddressId = addressId; // Lưu lại ID của địa chỉ cần xóa
        var confirmModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
        confirmModal.show();
    }

    // Hàm xóa địa chỉ
    function deleteAddress() {
        // Thực hiện yêu cầu xóa bằng cách gọi API hoặc chuyển hướng đến URL xử lý xóa với RequestParam
        window.location.href = `/profile/address/delete?username=${username}&addressId=` + deleteAddressId;
    }

    document.addEventListener("DOMContentLoaded", loadData);
</script>