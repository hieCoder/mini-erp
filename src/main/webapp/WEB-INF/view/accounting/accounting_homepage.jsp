<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/10/2023
  Time: 10:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accounting 2023/01</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="datePicker">Chọn ngày:</label>
                <input type="date" id="datePicker" class="form-control">
            </div>
            <button class="btn btn-primary">Filter</button>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="pageCount">Số lượng mục trên trang:</label>
                <select id="pageCount" class="form-control">
                    <option value="10">10</option>
                    <option value="15">15</option>
                    <option value="20">20</option>
                </select>
            </div>
        </div>
    </div>
    <table class="table mt-4">
        <thead>
        <tr>
            <th scope="col">NO.</th>
            <th scope="col">TRANSACTION ID</th>
            <th scope="col">CREATED DATE</th>
            <th scope="col">TITLE</th>
            <th scope="col">REVENUE</th>
            <th scope="col">EXPENSE</th>
            <th scope="col">BALANCE</th>
            <th scope="col">CREATED BY</th>
        </tr>
        </thead>
        <tbody>
        <!-- Dữ liệu của bảng sẽ được hiển thị ở đây -->
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item active" aria-current="page">
                <a class="page-link" href="#">3</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item">
                <a class="page-link" href="#">Next</a>
            </li>
        </ul>
    </nav>
    <table class="table mt-4">
        <tbody>
        <tr>
            <td>Total Revenue</td>
            <td><!-- Tổng doanh thu sẽ được hiển thị ở đây --></td>
        </tr>
        <tr>
            <td>Total Expense</td>
            <td><!-- Tổng chi phí sẽ được hiển thị ở đây --></td>
        </tr>
        <tr>
            <td>Total Balance</td>
            <td><!-- Tổng số dư sẽ được hiển thị ở đây --></td>
        </tr>
        <tr>
            <td>Page 3</td>
            <td><!-- Dòng Page 3 sẽ được hiển thị ở đây --></td>
        </tr>
        <tr>
            <td>Total in Month</td>
            <td><!-- Tổng trong tháng sẽ được hiển thị ở đây --></td>
        </tr>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

