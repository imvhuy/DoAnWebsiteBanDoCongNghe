<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<body>
    <!-- Liên kết tới Bootstrap 5 và FontAwesome -->
    <style>
        body {
            background-color: #f7f9fc;
            font-family: 'Arial', sans-serif;
            color: #333;
        }

        h2, h4 {
            color: #333;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
        }

        /* Thêm hiệu ứng cho card */
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            background-color: #fff;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        /* Thanh điều hướng */
        .navbar {
            background-color: #007bff;
            color: #fff;
            padding: 15px;
            border-radius: 0 0 15px 15px;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .navbar-nav .nav-link {
            color: #fff !important;
            margin-left: 20px;
            font-size: 1.1rem;
        }

        .navbar-nav .nav-link:hover {
            text-decoration: underline;
        }

        .card-header {
            background-color: #007bff;
            color: #fff;
            font-size: 1.1rem;
            font-weight: 600;
            text-align: center;
            padding: 15px;
        }

        .card-body {
            padding: 30px;
            text-align: center;
        }

        .number {
            font-size: 3rem;
            font-weight: 600;
            color: #007bff;
        }

        .chart-container {
            position: relative;
            height: 400px;
            width: 100%;
        }

        /* Hiệu ứng toast thông báo */
        .toast {
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1050;
            max-width: 300px;
        }

        /* Chế độ tối */
        .dark-mode {
            background-color: #212529;
            color: white;
        }

        .dark-mode .navbar {
            background-color: #1d1d1d;
        }

        .dark-mode .card {
            background-color: #343a40;
            color: white;
        }

        .dark-mode .number {
            color: #1e90ff;
        }

        .dark-mode .card-header {
            background-color: #007bff;
        }
    </style>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Shipper Dashboard</a>
        <div class="d-flex">
            <button class="btn btn-light" id="toggleModeBtn"><i class="fas fa-moon"></i> Dark Mode</button>
        </div>
    </div>
</nav>

<!-- Toast Notification (Mẫu) -->
<div id="toastNotification" class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
        <strong class="me-auto">New Update</strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div id="notificationsContainerLastest" class="list-group">

    </div>
</div>

<div class="container mt-5">

    <!-- Tổng quan công việc -->
    <div class="row">
        <!-- Tổng số đơn hàng đang giao -->
        <div class="col-md-4">
            <div class="card animate__animated animate__fadeInUp">
                <div class="card-header">
                    Total Orders in Progress
                </div>
                <div class="card-body">
                    <div class="number">${inProgressCount}</div>
                </div>
            </div>
        </div>
        <!-- Tổng số đơn hàng đã giao -->
        <div class="col-md-4">
            <div class="card animate__animated animate__fadeInUp">
                <div class="card-header">
                    Total Orders Delivered
                </div>
                <div class="card-body">
                    <div class="number">${deliveredCount}</div>
                </div>
            </div>
        </div>
        <!-- Tổng số đơn hàng chờ giao -->
        <div class="col-md-4">
            <div class="card animate__animated animate__fadeInUp">
                <div class="card-header">
                    Total Orders Pending
                </div>
                <div class="card-body">
                    <div class="number">${pendingCount}</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Biểu đồ thống kê công việc -->
    <div class="row mt-5 justify-content-center">
        <div class="col-md-6">
            <div class="card pie-chart">
                <div class="card-header">
                    Work Summary
                </div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="workSummaryChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Thông báo cập nhật mới -->
    <!-- Thông báo cập nhật mới -->
    <div class="row mt-5">
        <div class="col-md-12">
            <h4>Recent Notifications</h4>
            <div id="notificationsContainer" class="list-group">
                <!-- Thông báo mới sẽ được thêm ở đây -->

            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        const fetchOrders = () => {
            $.ajax({
                url: '/shipper/notifications', // Endpoint để lấy danh sách đơn hàng
                method: 'GET',
                success: function (orders) {
                    const container = $('#notificationsContainer');
                    container.empty(); // Xóa thông báo cũ
                    // Thêm thông báo mới
                    orders.forEach(order => {
                        container.append(
                            '<div class="list-group-item notification-item">' +
                            '<p>You have a new order to deliver to ' + order.address + ' (' + order.status + ').</p>' +
                            '<i class="fas fa-truck"></i>' +
                            '</div>'
                        );
                    });
                },
                error: function (err) {
                    console.error('Failed to fetch orders', err);
                }
            });
        };

        // Gọi hàm mỗi 10 giây để kiểm tra đơn hàng mới
        setInterval(fetchOrders, 10000);

        // Gọi lần đầu để tải thông báo khi trang được tải
        fetchOrders();

    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        const fetchLatestOrder = () => {
            $.ajax({
                url: '/shipper/latest-order', // Endpoint để lấy đơn hàng gần nhất
                method: 'GET',
                success: function (order) {
                    if (order) { // Kiểm tra nếu dữ liệu trả về hợp lệ
                        const container = $('#notificationsContainerLastest');
                        container.empty(); // Xóa thông báo cũ
                        // Thêm thông báo mới với thông tin order gần nhất
                        container.append(
                            '<div class="list-group-item notification-item">' +
                            '<p>Latest order: Deliver to ' + order.address +
                            ' (' + order.status + ') on ' + order.createdDate + '.</p>' +
                            '<i class="fas fa-truck"></i>' +
                            '</div>'
                        );
                    } else {
                        console.warn('No recent orders found');
                    }
                },
                error: function (err) {
                    console.error('Failed to fetch the latest order', err);
                }
            });
        };

        // Gọi hàm mỗi 10 giây để kiểm tra đơn hàng mới
        setInterval(fetchLatestOrder, 10000);

        // Gọi lần đầu để tải thông báo khi trang được tải
        fetchLatestOrder();
    </script>



</div>

<!-- Đoạn script cho biểu đồ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script>
    const ctx = document.getElementById('workSummaryChart').getContext('2d');

    const dataLabels = ['In Progress', 'Delivered', 'Pending'];
    const dataValues = [
        ${inProgressCount},
        ${deliveredCount},
        ${pendingCount}
    ];

    const workSummaryChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: dataLabels,
            datasets: [{
                data: dataValues,
                backgroundColor: ['#ffc107', '#28a745', '#007bff'],
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
                        label: function(tooltipItem) {
                            return tooltipItem.label + ": " + tooltipItem.raw;
                        }
                    }
                }
            }
        }
    });

    // Chuyển chế độ tối
    document.getElementById('toggleModeBtn').addEventListener('click', function() {
        document.body.classList.toggle('dark-mode');
        const buttonText = document.body.classList.contains('dark-mode') ? 'Light Mode' : 'Dark Mode';
        this.innerHTML = `<i class="fas fa-sun"></i> ${buttonText}`;
    });
</script>
</body>
</html>
