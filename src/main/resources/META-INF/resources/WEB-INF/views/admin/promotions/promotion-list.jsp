<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- section-content-right -->
<!-- main-content -->
<div class="main-content">
    <!-- main-content-wrap -->
    <div class="main-content-inner">
        <!-- main-content-wrap -->
        <div class="main-content-wrap">
            <div class="flex items-center flex-wrap justify-between gap20 mb-30">
                <h3>All Promotions</h3>
                <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                    <li>
                        <a href="/admin">
                            <div class="text-tiny">Dashboard</div>
                        </a>
                    </li>
                    <li>
                        <i class="icon-chevron-right"></i>
                    </li>
                    <li>
                        <a href="#">
                            <div class="text-tiny">Promotions</div>
                        </a>
                    </li>
                    <li>
                        <i class="icon-chevron-right"></i>
                    </li>
                    <li>
                        <div class="text-tiny">All Promotions</div>
                    </li>
                </ul>
            </div>
            <!-- all-promotion -->
            <div class="wg-box">
                <div class="flex items-center justify-between gap10 flex-wrap">
                    <div class="wg-filter flex-grow">
                        <div class="show">
                            <div class="text-tiny">Showing</div>
                            <div class="select">
                                <form method="GET" action="/admin/promotions">
                                    <div class="flex items-center justify-between flex-wrap gap10">
                                        <input type="hidden" name="name" value="${name}"/>
                                        <input type="hidden" name="page" value="${promotionPage.number}"/>
                                    </div>
                                </form>
                            </div>
                            <div class="text-tiny">entries</div>
                        </div>
                        <form class="form-search" method="GET" action="/admin/promotions">
    							<fieldset class="name">
       						 <input type="text" placeholder="Search here..." class="" name="name" tabindex="2" value="${name}">
   								 </fieldset>
    									<input type="hidden" name="size" value="5" />
    								<input type="hidden" name="page" value="0" />
    									<div class="button-submit">
        									<button class="" type="submit"><i class="icon-search"></i></button>
    								</div>
								</form>

                    </div>
                    <a class="tf-button style-1 w208" href="<c:url value='/admin/promotions/add'/>">
                        <i class="icon-plus"></i>Add New Promotion
                    </a>
                </div>
                <div class="wg-table table-all-attribute">
                    <!-- Table Header -->
                    <ul class="table-title flex gap20 mb-14">
                        <li><div class="body-title">Voucher ID</div></li>
                        <li><div class="body-title">Description</div></li>
                        <li><div class="body-title">Discount</div></li>
                        <li><div class="body-title">Minimum Price</div></li>
                        <li><div class="body-title">Quantity</div></li>
                        <li><div class="body-title">Start Date</div></li>
                        <li><div class="body-title">End Date</div></li>
                        <li><div class="body-title">Action</div></li>
                    </ul>

                    <!-- Table Body -->
                    <ul class="flex flex-column">
                        <c:forEach var="voucher" items="${promotions}">
                            <li class="attribute-item item-row flex items-center justify-between gap20">
                                <div class="name">
                                    <a href="<c:url value='/admin/promotions/edit/${voucher.id}'/>" class="body-title-2">${voucher.id}</a>
                                </div>
                                <div class="name">
                                    <a href="<c:url value='/admin/promotions/edit/${voucher.id}'/>" class="body-title-2">${voucher.description}</a>
                                </div>
                                <div class="body-text">${voucher.discount}%</div>
                                <div class="body-text">${voucher.minimumPrice}</div>
                                <div class="body-text">${voucher.quantity}</div>
                                <div class="body-text">${voucher.mfgDate}</div>
                                <div class="body-text">${voucher.expDate}</div>

                                <!-- Action Buttons -->
                                <div class="list-icon-function">
                                    <div class="item eye">
                                        <a href="<c:url value='/admin/promotions/view/${voucher.id}'/>">
                                            <i class="icon-eye"></i>
                                        </a>
                                    </div>
                                    <div class="item edit">
                                        <a href="<c:url value='/admin/promotions/edit/${voucher.id}'/>">
                                            <i class="icon-edit-3"></i>
                                        </a>
                                    </div>
                                    <div class="item trash">
                                        <a href="<c:url value='/admin/promotions/delete/${voucher.id}'/>">
                                            <i class="icon-trash-2"></i>
                                        </a>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                    <!-- Modal for Delete Confirmation -->
                    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <!-- Modal Header -->
                                <div class="modal-header" style="background-color: #ffab3e; color: white; font-size: 1.5rem;">
                                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
                                </div>

                                <!-- Modal Body -->
                                <div class="modal-body" style="background-color: #ffe4e1; color: black; font-size: 1.5rem;">
                                    Are you sure you want to delete this promotion?
                                </div>

                                <!-- Modal Footer -->
                                <div class="modal-footer" style="background-color: #ffe4e1;">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color: #ffab53; color: white;">Cancel</button>
                                    <a href="#" id="confirmDelete" class="btn btn-danger" style="background-color: #ff6f1b; color: white;">Delete</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- JavaScript for Delete Modal -->
                    <script type="text/javascript">
                        document.addEventListener("DOMContentLoaded", function() {
                            var deleteButtons = document.querySelectorAll("[data-target='#deleteModal']");
                            deleteButtons.forEach(function(button) {
                                button.addEventListener("click", function() {
                                    var voucherId = button.getAttribute("data-id");
                                    var deleteUrl = "/admin/promotions/delete/" + voucherId;
                                    document.getElementById("confirmDelete").setAttribute("href", deleteUrl);
                                });
                            });
                        });
                    </script>
                </div>
                <!-- Pagination -->
                <div class="divider"></div>
                <div class="flex items-center justify-between flex-wrap gap10">
                    <div class="text-tiny">Showing ${promotionPage.size} entries</div>

                    <c:if test="${promotionPage.totalPages > 0}">
                        <ul class="wg-pagination">
                            <!-- Previous Page Link -->
                            <li>
                                <a href="<c:url value='/admin/promotions'>
                                    <c:param name='name' value='${name}'/>
                                    <c:param name='size' value='5'/>
                                    <c:param name='page' value='${promotionPage.number > 0 ? promotionPage.number - 1 : 0}'/>
                                </c:url>">
                                    <i class="icon-chevron-left"></i>
                                </a>
                            </li>

                            <!-- Page Numbers -->
                            <c:forEach begin="1" end="${promotionPage.totalPages}" var="pageNumber">
                                <li class="<c:if test='${pageNumber == promotionPage.number + 1}'>active</c:if>">
                                    <a href="<c:url value='/admin/promotions'>
                                        <c:param name='name' value='${name}'/>
                                        <c:param name='size' value='5'/>
                                        <c:param name='page' value='${pageNumber - 1}'/>
                                    </c:url>">${pageNumber}</a>
                                </li>
                            </c:forEach>

                            <!-- Next Page Link -->
                            <li>
                                <a href="<c:url value='/admin/promotions'>
                                    <c:param name='name' value='${name}'/>
                                    <c:param name='size' value='5'/>
                                    <c:param name='page' value='${promotionPage.number + 1 < promotionPage.totalPages ? promotionPage.number + 1 : promotionPage.totalPages - 1}'/>
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
<!-- /section-content-right -->

