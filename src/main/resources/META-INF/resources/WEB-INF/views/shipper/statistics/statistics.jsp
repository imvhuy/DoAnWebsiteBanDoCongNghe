<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<body>
<!-- Bootstrap CSS -->
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container my-4">
    <h2 class="text-center mb-4">Order Statistics</h2>
    <!-- Statistics Table -->
    <div class="card mb-4">
        <div class="card-body">
            <table class="table table-hover">
                <thead class="table-dark">
                <tr>
                    <th>Status</th>
                    <th>Total Orders</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="stat" items="${statistics}">
                    <tr>
                        <td>${stat.status}</td>
                        <td>${stat.totalOrders}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Total Delivery Amount -->
    <h3 class="text-center text-success">
        Total Delivery Amount:
        <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0" /> VNĐ
    </h3>

    <!-- Chart Section -->
    <div class="my-5">
        <!-- Biểu đồ Cột (Bar Chart) -->
        <canvas id="statisticsChart" width="400" height="250"></canvas>
        <p class="text-center mt-2">Total Orders by Status</p>
    </div>

    <!-- Biểu đồ Cột cho Doanh thu hàng tháng -->
    <div class="my-5">
        <canvas id="barChart"></canvas>
        <p class="text-center mt-2">Monthly Delivery Revenue</p>
    </div>
</div>

<!-- JavaScript for Chart -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Data for the Bar Chart
        const labels = [];
        const orderData = [];
        <c:forEach var="stat" items="${statistics}">
        labels.push('${stat.status}');
        orderData.push(${stat.totalOrders});
        </c:forEach>

        // Bar Chart Configuration
        const ctxBar = document.getElementById('statisticsChart').getContext('2d');
        new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total Orders',
                    data: orderData,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                return context.raw + ' Orders';
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: 'Total Orders by Status',
                        font: {
                            size: 16
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Data for the Bar Chart (Monthly Revenue)
        const months = [];
        const revenueData = [];
        <c:forEach var="stat" items="${monthlyRevenue}">
        months.push('${stat.month}');  // Tháng
        revenueData.push(${stat.totalRevenue});  // Doanh thu
        </c:forEach>

        // Biểu đồ Cột cho Doanh thu hàng tháng
        const ctxBarRevenue = document.getElementById('barChart').getContext('2d');
        new Chart(ctxBarRevenue, {
            type: 'bar',
            data: {
                labels: months,  // Các tháng
                datasets: [{
                    label: 'Total Revenue (VNĐ)',  // Dữ liệu về doanh thu
                    data: revenueData,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',  // Màu nền dưới cột
                    borderColor: 'rgba(75, 192, 192, 1)',  // Màu đường viền của cột
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                return context.raw.toLocaleString() + ' VNĐ';  // Hiển thị số tiền với đơn vị VNĐ
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: 'Monthly Delivery Revenue',
                        font: {
                            size: 16
                        }
                    }
                },
                scales: {
                    y: {
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString();  // Định dạng tiền tệ
                            }
                        },
                        beginAtZero: true
                    }
                }
            }
        });
    });
</script>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

