<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</head>
<body>
<c:set var="totalExpense" value="0" scope="page"/>
<c:set var="totalRevenue" value="0" scope="page"/>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-9">
            <div class="form-group">
                <label for="datePickerStart">Chọn ngày bắt đầu:</label>
                <input type="date" id="datePickerStart" class="form-control">
                <label for="datePickerEnd">Chọn ngày kết thúc:</label>
                <input type="date" id="datePickerEnd" class="form-control">
            </div>
            <button class="btn btn-primary">Filter</button>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="pageCount">Số lượng mục trên trang:</label>
                <select id="pageCount" class="form-control">
                    <option value="7">7</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>
        </div>
    </div>
    <table class="table table-bordered table-hover mt-4">
        <thead class="thead-dark">
        <tr>
            <th scope="col">NO.</th>
            <th scope="col">TRANSACTION ID</th>
            <th scope="col">CREATED DATE</th>
            <th scope="col">TITLE</th>
            <th scope="col">REVENUE</th>
            <th scope="col">EXPENSE</th>
            <th scope="col">BALANCE</th>
            <th scope="col">CREATED BY</th>
            <th scope="col">BILL</th>
        </tr>
        </thead>
        <tbody id="table-body">
        <c:forEach varStatus="loop" var="a" items="${requestScope.list.accountResponseList}">
            <tr>
                <th scope="row">${(list.pageNumber - 1) * list.pageSize + loop.index + 1}</th>
                <td><c:out value="${a.id}"/></td>
                <td><c:out value="${a.createdDate}"/></td>
                <td><c:out value="${a.title}"/></td>
                <td><c:out value="${a.revenue}"/></td>
                <td><c:out value="${a.expense}"/></td>
                <td><c:out value="${a.remain}"/></td>
                <td><c:out value="${a.user.fullname}"/></td>
                <td><c:out value="${a.bill}"/></td>
            </tr>
            <c:set var="totalExpense" value="${totalExpense + a.expense}" scope="page"/>
            <c:set var="totalRevenue" value="${totalRevenue + a.revenue}" scope="page"/>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul id="pagination" class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" onclick="loadPage(1,${list.pageSize})">
                    First
                </a>
            </li>
            <c:choose>
                <c:when test="${list.hasPrevious}">
                    <li class="page-item">
                        <a class="page-link" onclick="loadPage(${list.pageNumber - 1},${list.pageSize})" tabindex="-1" aria-disabled="true">Previous</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item disabled">
                        <a class="page-link" onclick="loadPage(${list.pageNumber - 1},${list.pageSize})" tabindex="-1" aria-disabled="true">Previous</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="page" begin="1" end="${list.totalPages}">
                <c:choose>
                    <c:when test="${page == list.pageNumber}">
                        <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" onclick="loadPage(${page},${list.pageSize})">${page}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${list.hasNext}">
                    <li class="page-item">
                        <a class="page-link" onclick="loadPage(${list.pageNumber + 1},${list.pageSize})" tabindex="-1" aria-disabled="true">Next</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item disabled">
                        <a class="page-link" onclick="loadPage(${list.pageNumber + 1},${list.pageSize})" tabindex="-1" aria-disabled="true">Next</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <li class="page-item">
                <a class="page-link" style="cursor: pointer" onclick="loadPage(${list.totalPages},${list.pageSize})">
                    Last
                </a>
            </li>
        </ul>
    </nav>
    <table class="table mt-4">
        <thead>
        <tr>
            <th></th>
            <th>Total Revenue</th>
            <th>Total Expense</th>
            <th>Total Balance</th>
        </tr>
        </thead>
        <tbody>
        <tr id="total">
            <th>Page ${list.pageNumber}</th>
            <td><c:out value="${totalRevenue}"/></td>
            <td><c:out value="${totalExpense}"/></td>
            <td><c:out value="${totalRevenue + totalExpense}"/></td>
        </tr>
        <tr>
            <th>Total in Month</th>
            <td><c:out value="${list.totalList.totalRevenue}"/></td>
            <td><c:out value="${list.totalList.totalExpense}"/></td>
            <td><c:out value="${list.totalList.totalRemain}"/></td>
        </tr>
        </tbody>
    </table>
</div>
<script>
    function loadPage(page, size) {
        var loading = document.getElementById("loading");
        loading.style.display = "block";
        var xhr = new XMLHttpRequest();
        var url = window.location.href;
        var segments = url.split("/");
        var month = segments[segments.length - 1];
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                loading.style.display = "none";
                var responseData = JSON.parse(xhr.responseText);

                var tableBody = document.getElementById("table-body");

                var totalSpend = document.getElementById("total");

                var totalExpense = 0;
                var totalRevenue = 0;

                tableBody.innerHTML = "";
                responseData.accountResponseList.forEach((account, index) => {
                    var row = tableBody.insertRow();
                    row.innerHTML = "<th scope='row'>" +  ((page - 1) * size + index + 1) + "</th>"
                    + "<td>" +  account.id + "</td>"
                    + "<td>" +  account.createdDate + "</td>"
                    + "<td>" +  account.title + "</td>"
                    + "<td>" +  account.revenue + "</td>"
                    + "<td>" +  account.expense + "</td>"
                    + "<td>" +  account.remain + "</td>"
                    + "<td>" +  account.user.fullname + "</td>"
                    + "<td>" +  account.bill + "</td>"
                    ;
                    totalExpense += account.expense;
                    totalRevenue += account.revenue;
                });

                updatePagination(responseData);

                totalSpend.innerHTML = "";
                totalSpend.innerHTML = '<th>Page ' + page + '</th>' + '<td>' + totalRevenue + '</td>'
                    + '<td>' + totalExpense + '</td>'
                    + '<td>' + (totalRevenue + totalExpense) + '</td>';
            }
        };
        xhr.open("GET", "/api/v1/accounts/"+ month + "?page=" + page + "&size=" + size, true);
        xhr.send();
    }

    function updatePagination(responseData) {
        var pagination = document.getElementById("pagination");
        var totalPages = responseData.totalPages;
        var currentPage = responseData.pageNumber;

        var paginationHTML = "";
        paginationHTML += '<li class="page-item"><a class="page-link" onclick="loadPage(1, ' + responseData.pageSize + ')">First</a></li>';

        if (responseData.hasPrevious) {
            paginationHTML += '<li class="page-item"><a class="page-link" onclick="loadPage(' + (currentPage - 1) + ', ' + responseData.pageSize + ')" tabindex="-1" aria-disabled="true">Previous</a></li>';
        } else {
            paginationHTML += '<li class="page-item disabled"><a class="page-link" onclick="loadPage(' + (currentPage - 1) + ', ' + responseData.pageSize + ')" tabindex="-1" aria-disabled="true">Previous</a></li>';
        }

        for (var page = 1; page <= totalPages; page++) {
            if (page === currentPage) {
                paginationHTML += '<li class="page-item active"><a class="page-link" href="#">' + page + '</a></li>';
            } else {
                paginationHTML += '<li class="page-item"><a class="page-link" onclick="loadPage(' + page + ', ' + responseData.pageSize + ')">' + page + '</a></li>';
            }
        }

        if (responseData.hasNext) {
            paginationHTML += '<li class="page-item"><a class="page-link" onclick="loadPage(' + (currentPage + 1) + ', ' + responseData.pageSize + ')" tabindex="-1" aria-disabled="true">Next</a></li>';
        } else {
            paginationHTML += '<li class="page-item disabled"><a class="page-link" onclick="loadPage(' + (currentPage + 1) + ', ' + responseData.pageSize + ')" tabindex="-1" aria-disabled="true">Next</a></li>';
        }

        paginationHTML += '<li class="page-item"><a class="page-link" style="cursor: pointer" onclick="loadPage(' + totalPages + ', ' + responseData.pageSize + ')">Last</a></li>';

        pagination.innerHTML = paginationHTML;
    }
</script>
<div id="loading" class="loading-spin">Loading...</div>
</body>
</html>

