<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<body>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    #pieChart {
        width: 200px; /* Điều chỉnh chiều rộng */
        height: 200px; /* Điều chỉnh chiều cao */
    }
</style>

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

    <!-- Line Chart for Total Money (Replaces Pie Chart) -->
    <div class="my-5">
        <canvas id="lineChart"></canvas>
        <p class="text-center mt-2">Order Status and Total Amount</p>
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

        // Data for the Line Chart (Money instead of Orders)
        const moneyData = [];
        <c:forEach var="stat" items="${statistics2}">
        // Giả sử bạn có tổng tiền cho từng trạng thái đơn hàng
        moneyData.push(${stat.totalMoney});  // Sử dụng dữ liệu tiền, ví dụ: totalMoney là tổng tiền theo từng trạng thái đơn hàng
        </c:forEach>

        // Line Chart Configuration (for Money Data)
        const ctxLine = document.getElementById('lineChart').getContext('2d');
        new Chart(ctxLine, {
            type: 'line',
            data: {
                labels: labels,  // Sử dụng nhãn trạng thái đơn hàng
                datasets: [{
                    label: 'Total Money (VNĐ)',  // Dữ liệu về tiền
                    data: moneyData,
                    borderColor: 'rgba(75, 192, 192, 1)',  // Màu sắc đường biểu đồ
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',  // Màu nền dưới đường biểu đồ
                    fill: true,  // Đổ màu dưới đường
                    borderWidth: 2
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
                        text: 'Order Status and Total Amount',
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
</html>
