<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipper Dashboard</title>
    <!-- Link tới Bootstrap 5 và FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /* Tùy chỉnh giao diện */
        .card {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .card-header {
            background-color: #007bff;
            color: #fff;
            font-size: 1.2rem;
        }

        .dashboard-card .number {
            font-size: 2rem;
            color: #007bff;
            font-weight: bold;
        }

        .btn-custom {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
        }

        .btn-custom:hover {
            background-color: #0056b3;
            color: #fff;
        }

        .notification-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e1e1e1;
            padding: 10px 0;
        }

        .notification-item i {
            color: #28a745;
        }

        .notification-item p {
            margin-bottom: 0;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2>Welcome to Your Shipper Dashboard</h2>

    <!-- Tổng quan công việc -->
    <div class="row mt-4">
        <!-- Tổng số đơn hàng đang giao -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    Total Orders in Progress
                </div>
                <div class="card-body text-center">
                    <div class="number">5</div>
                </div>
            </div>
        </div>
        <!-- Tổng số đơn hàng đã giao -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    Total Orders Delivered
                </div>
                <div class="card-body text-center">
                    <div class="number">15</div>
                </div>
            </div>
        </div>
        <!-- Tổng số đơn hàng chờ giao -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    Total Orders Pending
                </div>
                <div class="card-body text-center">
                    <div class="number">3</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách đơn hàng gần nhất -->
    <div class="row mt-5">
        <div class="col-12">
            <h4>Latest Orders</h4>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Amount</th>
                    <th>Estimated Delivery Time</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>123 Main Street</td>
                    <td><span class="badge bg-success">In Progress</span></td>
                    <td>$15.00</td>
                    <td>2:30 PM</td>
                    <td>
                        <button class="btn btn-sm btn-custom">View</button>
                        <button class="btn btn-sm btn-warning">Update</button>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>456 Elm Avenue</td>
                    <td><span class="badge bg-warning">Pending</span></td>
                    <td>$25.00</td>
                    <td>3:00 PM</td>
                    <td>
                        <button class="btn btn-sm btn-custom">View</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Biểu đồ thống kê công việc -->
    <div class="row mt-5">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    Work Summary
                </div>
                <div class="card-body">
                    <canvas id="workSummaryChart"></canvas>
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
            </div>
        </div>
    </div>

    <!-- Báo cáo thu nhập -->
    <div class="row mt-5">
        <div class="col-md-12">
            <h4>Income Report</h4>
            <div class="card">
                <div class="card-header">
                    Today's Earnings
                </div>
                <div class="card-body text-center">
                    <div class="number">$75.00</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Đoạn script cho biểu đồ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    var ctx = document.getElementById('workSummaryChart').getContext('2d');
    var workSummaryChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Completed', 'Pending'],
            datasets: [{
                data: [70, 30],
                backgroundColor: ['#28a745', '#ffc107'],
                borderWidth: 1
            }]
        }
    });
</script>
</body>
</html>
