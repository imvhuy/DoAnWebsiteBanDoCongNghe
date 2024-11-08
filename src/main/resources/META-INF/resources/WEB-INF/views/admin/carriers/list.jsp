<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- section-content-right -->
    <!-- main-content -->
    <div class="main-content">
        <!-- main-content-wrap -->
        <div class="main-content-inner">
            <!-- main-content-wrap -->
            <div class="main-content-wrap">
                <div class="flex items-center flex-wrap justify-between gap20 mb-30">
                    <h3>All Carrier</h3>
                    <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                        <li>
                            <a href="index.html">
                                <div class="text-tiny">Dashboard</div>
                            </a>
                        </li>
                        <li>
                            <i class="icon-chevron-right"></i>
                        </li>
                        <li>
                            <a href="#">
                                <div class="text-tiny">Carrier</div>
                            </a>
                        </li>
                        <li>
                            <i class="icon-chevron-right"></i>
                        </li>
                        <li>
                            <div class="text-tiny">All Carriers</div>
                        </li>
                    </ul>
                </div>
                <!-- all-carrier -->
                <div class="wg-box">
                    <div class="flex items-center justify-between gap10 flex-wrap">
                        <div class="wg-filter flex-grow">
                            <div class="show">
                                <div class="text-tiny">Showing</div>
                                    <div class="select">
                                        <form method="GET" action="/admin/carriers/searchpaginated">
                                            <div class="flex items-center justify-between flex-wrap gap10">
                                                <div class="text-tiny">
                                                    <select name="size" id="size" onchange="this.form.submit()">
                                                        <option value="3" <c:if test="${carrierPage.size == 3}">selected</c:if>>3</option>
                                                        <option value="5" <c:if test="${carrierPage.size == 5}">selected</c:if>>5</option>
                                                        <option value="10" <c:if test="${carrierPage.size == 10}">selected</c:if>>10</option>
                                                        <option value="15" <c:if test="${carrierPage.size == 15}">selected</c:if>>15</option>
                                                        <option value="20" <c:if test="${carrierPage.size == 20}">selected</c:if>>20</option>
                                                    </select>
                                                </div>
                                                <input type="hidden" name="name" value="${name}"/>
                                                <input type="hidden" name="page" value="${carrierPage.number + 1}"/>
                                            </div>
                                        </form>

                                    </div>
                                <div class="text-tiny">entries</div>
                                </div>
                            <form class="form-search">
                                <fieldset class="name">
                                    <input type="text" placeholder="Search here..." class="" name="name" tabindex="2"
                                           value="" >
                                </fieldset>
                                <!-- Hidden fields để giữ lại các thông tin như kích thước trang và số trang -->
                                <input type="hidden" name="size" value="${carrierPage.size}" />
                                <input type="hidden" name="page" value="1" /> <!-- Đặt lại về trang đầu khi tìm kiếm mới -->
                                <div class="button-submit">
                                    <button class="" type="submit"><i class="icon-search"></i></button>
                                </div>
                            </form>
                        </div>
                        <a class="tf-button style-1 w208" href= "<c:url value = '/admin/carriers/add'/>">
                            <i class="icon-plus"></i>Add New Carrier
                        </a>
                    </div>
                    <div class="wg-table table-all-attribute">
                        <!-- Table Header -->
                        <ul class="table-title flex gap20 mb-14">
                            <li><div class="body-title">Carrier ID</div></li>
                            <li><div class="body-title">Carrier Name</div></li>
                            <li><div class="body-title">Price</div></li>
                            <li><div class="body-title">Action</div></li>
                        </ul>

                        <!-- Table Body -->
                        <ul class="flex flex-column">
                            <c:forEach var="carrier" items="${carrierPage.content}">
                                <li class="attribute-item item-row flex items-center justify-between gap20">
                                    <div class="name">
                                        <a href="add-attributes.html" class="body-title-2">${carrier.id}</a>
                                    </div>
                                    <div class="name">
                                        <a href="add-attributes.html" class="body-title-2">${carrier.name}</a>
                                    </div>
                                    <div class="body-text">${carrier.price}</div>

                                    <!-- Action Buttons -->
                                    <div class="list-icon-function">
                                        <div class="item eye">
                                            <a href="<c:url value='/admin/carriers/view/${carrier.id}'/>">
                                                <i class="icon-eye"></i>
                                            </a>
                                        </div>
                                        <div class="item edit">
                                            <a href="<c:url value='/admin/carriers/edit/${carrier.id}'/>">
                                                <i class="icon-edit-3"></i>
                                            </a>
                                        </div>
                                        <div class="item trash">
                                            <!-- Trigger modal with delete confirmation -->
                                            <a href="#" data-toggle="modal" data-target="#deleteModal" data-id="${carrier.id}">
                                                <i class="icon-trash-2"></i>
                                            </a>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <!-- Bootstrap Modal for Delete Confirmation -->
                        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <!-- Header với nền #ff6f1b và chữ trắng -->
                                    <div class="modal-header" style="background-color: #ffab3e; color: white; font-size: 1.5rem;">
                                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
                                    </div>

                                    <!-- Body với nền #ffe4e1 và chữ màu đen -->
                                    <div class="modal-body" style="background-color: #ffe4e1; color: black; font-size: 1.5rem;">
                                        Are you sure you want to delete this item?
                                    </div>

                                    <!-- Footer với nút Cancel màu cam và chữ trắng -->
                                    <div class="modal-footer" style="background-color: #ffe4e1;">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color: #ffab53; color: white;">Cancel</button>
                                        <a href="#" id="confirmDelete" class="btn btn-danger" style="background-color: #ff6f1b; color: white;">Delete</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- JavaScript to set the delete link dynamically -->
                        <script type="text/javascript">
                            document.addEventListener("DOMContentLoaded", function() {
                                // Get all delete links
                                var deleteButtons = document.querySelectorAll("[data-target='#deleteModal']");

                                // Loop over each button to add click event listener
                                deleteButtons.forEach(function(button) {
                                    button.addEventListener("click", function() {
                                        var carrierId = button.getAttribute("data-id");
                                        var deleteUrl = "/admin/carriers/delete/" + carrierId;
                                        document.getElementById("confirmDelete").setAttribute("href", deleteUrl);

                                        // Show the delete modal
                                        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
                                        deleteModal.show();
                                    });
                                });
                            });
                        </script>


                    </div>
                    <!-- Pagination -->
                    <div class="divider"></div>
                    <div class="flex items-center justify-between flex-wrap gap10">
                        <div class="text-tiny">Showing ${carrierPage.size} entries</div>

                        <c:if test="${carrierPage.totalPages > 0}">
                            <ul class="wg-pagination">
                                <!-- Previous Page Link -->
                                <li>
                                    <a href="<c:url value='/admin/carriers/searchpaginated'>
                            <c:param name='name' value='${name}'/>
                            <c:param name='size' value='${carrierPage.size}'/>
                            <c:param name='page' value='${carrierPage.number > 1 ? carrierPage.number : 1}'/>
                        </c:url>">
                                        <i class="icon-chevron-left"></i>
                                    </a>
                                </li>

                                <!-- Page Numbers -->
                                <c:forEach var="pageNumber" items="${pageNumbers}">
                                    <li class="<c:if test='${pageNumber == carrierPage.number + 1}'>active</c:if>">
                                        <a href="<c:url value='/admin/carriers/searchpaginated'>
                                <c:param name='name' value='${name}'/>
                                <c:param name='size' value='${carrierPage.size}'/>
                                <c:param name='page' value='${pageNumber}'/>
                            </c:url>">${pageNumber}</a>
                                    </li>
                                </c:forEach>

                                <!-- Next Page Link -->
                                <li>
                                    <a href="<c:url value='/admin/carriers/searchpaginated'>
                            <c:param name='name' value='${name}'/>
                            <c:param name='size' value='${carrierPage.size}'/>
                            <c:param name='page' value='${carrierPage.number + 2 <= carrierPage.totalPages ? carrierPage.number + 2 : carrierPage.totalPages}'/>
                        </c:url>">
                                        <i class="icon-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </c:if>
                    </div>
                </div>
                <!-- /all-attribute -->
            </div>
            <!-- /main-content-wrap -->
        </div>
        <!-- /main-content-wrap -->
        <!-- bottom-page -->
        <div class="bottom-page">
            <div class="body-text">Copyright © 2024 <a href="https://themesflat.co/html/ecomus/index.html">Ecomus</a>.
                Design by Themesflat All rights reserved
            </div>
        </div>
        <!-- /bottom-page -->
    </div>
    <!-- /main-content -->
</div>
<!-- /section-content-right -->
