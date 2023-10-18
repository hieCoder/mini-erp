<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accounting Management</title>
</head>
<body>
<c:set var="totalExpense" value="0" scope="page"/>
<c:set var="totalRevenue" value="0" scope="page"/>
<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <h3 class="text-center">Accounting ${month}</h3>
        </div>
    </div>
    <div class="row mt-1">
        <div class="col-md-9">
            <div class="form-group">
                <label for="datePickerStart">Choose time start:</label>
                <input type="date" id="datePickerStart" class="form-control">
                <label for="datePickerEnd">Choose time end:</label>
                <input type="date" id="datePickerEnd" class="form-control">
            </div>
            <button class="btn btn-primary" onclick="loadPage(1)">Filter</button>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="pageCount">Number size each page:</label>
                <select id="pageCount" class="form-control">
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="15">15</option>
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
            <th scope="col">NOTE</th>
            <th scope="col">BILL</th>
        </tr>
        </thead>
        <tbody id="table-body">
        <c:forEach varStatus="loop" var="a" items="${requestScope.list.accountResponseList}">
            <tr class="align-middle">
                <th scope="row" class="align-middle">${(list.pageNumber - 1) * list.pageSize + loop.index + 1}</th>
                <td class="align-middle"><a href="/accounting/detail/${a.id}"><c:out value="${a.id}"/></a></td>
                <td class="align-middle"><c:out value="${a.createdDate}"/></td>
                <td class="align-middle"><c:out value="${a.title}"/></td>
                <td class="align-middle ${a.revenue > 0 ? 'text-success' : ''}">
                    <fmt:formatNumber type="number" value="${a.revenue}" pattern="#,##0 ₫"/>
                </td>
                <td class="align-middle ${a.expense < 0 ? 'text-danger' : ''}">
                    <fmt:formatNumber type="number" value="${a.expense}" pattern="#,##0 ₫"/>
                </td>
                <td class="align-middle text-primary"><fmt:formatNumber type="number" value="${a.remain}" pattern="#,##0 ₫"/></td>
                <td class="align-middle"><c:out value="${a.user.fullname}"/></td>
                <td class="align-middle"><c:if test="${a.note != null}"><c:out value="${a.note}"/></c:if></td>
                <td class="align-middle">
                    <c:choose>
                        <c:when test="${not empty a.bill}">
                            <c:forEach items="${a.bill}" var="file">
                                <a href="${file}" download="" target="_blank"
                                   id="resumeLink">${file.substring(file.indexOf('-') + 1)}</a>
                                <hr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <c:set var="totalExpense" value="${totalExpense + a.expense}" scope="page"/>
            <c:set var="totalRevenue" value="${totalRevenue + a.revenue}" scope="page"/>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul id="pagination" class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" onclick="loadPage(1)">
                    First
                </a>
            </li>
            <c:choose>
                <c:when test="${list.hasPrevious}">
                    <li class="page-item">
                        <a class="page-link" onclick="loadPage(${list.pageNumber - 1})" tabindex="-1"
                           aria-disabled="true">Previous</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item disabled">
                        <a class="page-link" onclick="loadPage(${list.pageNumber - 1})" tabindex="-1"
                           aria-disabled="true">Previous</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="page" begin="1" end="${list.totalPages}">
                <c:choose>
                    <c:when test="${page == list.pageNumber}">
                        <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" onclick="loadPage(${page})">${page}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${list.hasNext}">
                    <li class="page-item">
                        <a class="page-link" onclick="loadPage(${list.pageNumber + 1})" tabindex="-1"
                           aria-disabled="true">Next</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item disabled">
                        <a class="page-link" onclick="loadPage(${list.pageNumber + 1})" tabindex="-1"
                           aria-disabled="true">Next</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <li class="page-item">
                <a class="page-link" onclick="loadPage(${list.totalPages})">
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
            <td class="text-success"><fmt:formatNumber type="number" value="${totalRevenue}" pattern="#,##0 ₫"/></td>
            <td class="text-danger"><fmt:formatNumber type="number" value="${totalExpense}" pattern="#,##0 ₫"/></td>
            <td class="text-primary"><fmt:formatNumber type="number" value="${totalRevenue + totalExpense}"
                                                       pattern="#,##0 ₫"/></td>
        </tr>
        <tr>
            <th>Total in Month</th>
            <td class="text-success"><fmt:formatNumber type="number" value="${list.totalList.totalRevenue}"
                                                       pattern="#,##0 ₫"/></td>
            <td class="text-danger"><fmt:formatNumber type="number" value="${list.totalList.totalExpense}"
                                                      pattern="#,##0 ₫"/></td>
            <td class="text-primary"><fmt:formatNumber type="number" value="${list.totalList.totalRemain}"
                                                       pattern="#,##0 ₫"/></td>
        </tr>
        </tbody>
    </table>
</div>
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-center" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Bad Request</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                An error occurred while sending the request. Please try again.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    var defaultDate = new Date('${month}');
    var year = defaultDate.getFullYear();
    var month = defaultDate.getMonth() + 1;
    var formattedDate = year + '-' + (month < 10 ? '0' : '') + month + '-01';
    document.getElementById("datePickerStart").value = formattedDate;

    var lastDay = new Date(year, month, 0);
    var lastDayOfMonth = lastDay.getDate();
    document.getElementById("datePickerEnd").value = year + '-' + (month < 10 ? '0' : '') + month + '-' + lastDayOfMonth;

    document.getElementById("pageCount").addEventListener("change", function () {
        localStorage.setItem("selectedPageSize", this.value);
        loadPage(1);
    });

    window.addEventListener("beforeunload", function () {
        localStorage.removeItem("selectedPageSize");
        localStorage.removeItem("selectedDateStart");
        localStorage.removeItem("selectedDateEnd");
        document.getElementById("datePickerStart").value = "";
        document.getElementById("datePickerEnd").value = "";
        document.getElementById("pageCount").selectedIndex = 0;
    });

    document.getElementById("datePickerStart").addEventListener("input", function () {
        localStorage.setItem("selectedDateStart", this.value);
    });

    document.getElementById("datePickerEnd").addEventListener("input", function () {
        localStorage.setItem("selectedDateEnd", this.value);
    });

    var url = window.location.href;
    var segments = url.split("/");
    var month = segments[segments.length - 1];

    function loadPage(page) {
        var selectedPageSize = localStorage.getItem("selectedPageSize") || ${list.pageSize};
        var selectedDateStart = localStorage.getItem("selectedDateStart") || "";
        var selectedDateEnd = localStorage.getItem("selectedDateEnd") || "";

        var loading = document.getElementById("loading");
        loading.style.display = "block";

        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    loading.style.display = "none";
                    var responseData = JSON.parse(xhr.responseText);

                    var tableBody = document.getElementById("table-body");

                    var totalSpend = document.getElementById("total");

                    var totalExpense = 0;
                    var totalRevenue = 0;
                    var totalRemain = 0;

                    if (responseData.accountResponseList.length === 0) {
                        tableBody.innerHTML = "";
                        var row = tableBody.insertRow();
                        row.innerHTML = "<td colspan='9' class='center'>NOT FOUND DATA IN THIS DURATION</td>";
                    } else {
                        tableBody.innerHTML = "";
                        responseData.accountResponseList.forEach((account, index) => {
                            var row = tableBody.insertRow();
                            row.innerHTML = "<th scope='row'>" + ((page - 1) * selectedPageSize + index + 1) + "</th>"
                                + "<td>" + '<a href="/accounting/detail/' + account.id + '">' + account.id + "</a>" + "</td>"
                                + "<td>" + account.createdDate + "</td>"
                                + "<td>" + account.title + "</td>"
                                + "<td style='color: " + (account.revenue > 0 ? 'green' : 'inherit') + "'>" + formatCurrency(account.revenue) + "</td>"
                                + "<td style='color: " + (account.expense < 0 ? 'red' : 'inherit') + "'>" + formatCurrency(account.expense) + "</td>"
                                + "<td style='color: blue'>" + formatCurrency(account.remain) + "</td>"
                                + "<td>" + account.user.fullname + "</td>"
                                + "<td>" + (account.note !== null ? account.note : '') + "</td>";
                            if (account.bill) {
                                var cell = row.insertCell();

                                var files = account.bill;

                                for (var i = 0; i < files.length; i++) {
                                    var file = files[i];
                                    var downloadLink = document.createElement("a");
                                    downloadLink.href = file;
                                    downloadLink.setAttribute("download", "");
                                    downloadLink.target = "_blank";
                                    downloadLink.id = "resumeLink";
                                    downloadLink.textContent = file.substring(file.indexOf('-') + 1);
                                    cell.appendChild(downloadLink);

                                    if (i < files.length - 1) {
                                        cell.appendChild(document.createElement("hr"));
                                    }
                                }
                            } else {
                                row.insertCell();
                            }
                            totalExpense += account.expense;
                            totalRevenue += account.revenue;
                            totalRemain = account.remain;
                        });
                    }

                    updatePagination(responseData);

                    totalSpend.innerHTML = '<th>Page ' + page + '</th>' + '<td class="text-success">' + formatCurrency(totalRevenue) + '</td>'
                        + '<td class="text-danger">' + formatCurrency(totalExpense) + '</td>'
                        + '<td class="text-primary">' + formatCurrency(totalRemain) + '</td>';
                } else {
                    loading.style.display = "none";
                    $('#errorModal').modal('show');
                }
            }
        };
        xhr.open("GET", "/api/v1/accounts/" + month + "?page=" + page + "&size=" + selectedPageSize + "&startDate=" + selectedDateStart + "&endDate=" + selectedDateEnd, true);
        xhr.send();
    }

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
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

