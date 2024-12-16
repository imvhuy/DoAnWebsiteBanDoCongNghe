<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<div class="col-lg-9">
    <div class="my-account-content account-order">
        <div class="wrap-account-order">
            <table>
                <thead>
                    <tr>
                        <th class="fw-6">Order</th>
                        <th class="fw-6">Date</th>
                        <th class="fw-6">Status</th>
                        <th class="fw-6">Total</th>
                        <th class="fw-6">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr class="tf-order-item">
                            <td>#${order.id}</td>
                            <td><fmt:formatDate value="${order.createdDate}" pattern="MMMM d, yyyy" /></td>
                            <td>${order.status}</td>
                            <td><fmt:formatNumber value="${order.amountFromUser}" pattern="#,###" /> VNĐ</td>
                            <td>
                                <a href="<c:url value='/profile/ordersdetails/${order.id}' />"
                                   class="tf-btn btn-fill animate-hover-btn rounded-0 justify-content-center">
                                    <span>View</span>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
		


    </div>
</div>
