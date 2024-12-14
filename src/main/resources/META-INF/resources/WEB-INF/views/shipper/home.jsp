<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<body>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipper Dashboard</title>
    <!-- Liên kết tới Bootstrap 5 và FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
    <div class="toast-body">
        New order for delivery to 789 Oak Street!
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
    <div class="row mt-5">
        <div class="col-md-12">
            <h4>Recent Notifications</h4>
            <div class="list-group">
                <div class="list-group-item notification-item">
                    <p>Your order for 123 Main Street is now on the way!</p>
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="list-group-item notification-item">
                    <p>You have a new order to deliver to 456 Elm Avenue.</p>
                    <i class="fas fa-info-circle"></i>
                </div>
                <div class="list-group-item notification-item">
                    <p>Your order to 789 Oak Street has been delivered.</p>
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Đoạn script cho biểu đồ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
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
