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
<div class="row">
    <div class="shadow p-3 bg-white rounded">
        <div class="row">
            <div class="col-12">
                <h3 class="text-center">Accounting ${month}</h3>
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="account-day" class="form-label mb-0 text-muted">Filter by year: </label>
                    <div class="input-group" id="account-day">
                        <select class="form-select rounded-pill" aria-label="Default select example" id="account-year">
                            <option selected="">-- Select year --</option>
                        </select>
                        <select class="form-select rounded-pill" aria-label="Default select example" id="account-month">
                            <option selected="">-- Select month --</option>
                        </select>
                    </div>
                </div>
                <button type="button" class="btn btn-primary btn-label rounded-pill mt-3" onclick="loadPage(1)"><i
                        class="ri-user-smile-line label-icon align-middle rounded-pill fs-16 me-2"></i> Filter
                </button>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="datePickerStart" class="form-label mb-0 text-muted">Start Date</label>
                    <input type="text" class="form-control flatpickr-input" data-provider="flatpickr"
                           data-date-format="d M, Y" data-deafult-date="" id="datePickerStart">
                    <label for="datePickerEnd" class="form-label mb- mt-3 text-muted">End Date</label>
                    <input type="text" class="form-control flatpickr-input" data-provider="flatpickr"
                           data-date-format="d M, Y" data-deafult-date="" id="datePickerEnd">
                </div>
                <button type="button" class="btn btn-primary btn-label rounded-pill mt-3" onclick="loadPage(1)"><i
                        class="ri-user-smile-line label-icon align-middle rounded-pill fs-16 me-2"></i> Filter
                </button>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="pageCount" class="form-label mb-0 text-muted">Default</label>
                    <select class="form-select rounded-pill mb-3" aria-label="Default select example" id="pageCount">
                        <option selected="">--Select size--</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Basic Datatables</h5>
                    </div>
                    <div class="card-body">
                        <div id="example_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
                            <div class="row">
                                <div class="col-sm-12 col-md-6">
                                    <div class="dataTables_length" id="example_length"><label>Show <select
                                            name="example_length"
                                            aria-controls="example"
                                            class="form-select form-select-sm">
                                        <option value="10">10</option>
                                        <option value="25">25</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option>
                                    </select> entries</label></div>
                                </div>
                                <div class="col-sm-12 col-md-6">
                                    <div id="example_filter" class="dataTables_filter"><label>Search:<input
                                            type="search"
                                            class="form-control form-control-sm"
                                            placeholder=""
                                            aria-controls="example"></label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <table id="example"
                                           class="table table-bordered dt-responsive nowrap table-striped align-middle dataTable no-footer dtr-inline collapsed"
                                           style="width: 100%;" aria-describedby="example_info">
                                        <thead>
                                        <tr>
                                            <th scope="col" style="width: 17.4px;" class="sorting sorting_asc"
                                                tabindex="0" aria-controls="example" rowspan="1" colspan="1"
                                                aria-sort="ascending" aria-label="
                                                : activate to sort column descending">
                                                <div class="form-check">
                                                    <input class="form-check-input fs-15" type="checkbox" id="checkAll"
                                                           value="option">
                                                </div>
                                            </th>
                                            <th data-ordering="false" class="sorting" tabindex="0"
                                                aria-controls="example" rowspan="1" colspan="1" style="width: 43.4px;"
                                                aria-label="SR No.: activate to sort column ascending">NO.
                                            </th>
                                            <th data-ordering="false" class="sorting" tabindex="0"
                                                aria-controls="example" rowspan="1" colspan="1" style="width: 34.4px;"
                                                aria-label="ID: activate to sort column ascending">TRANSACTION ID
                                            </th>
                                            <th data-ordering="false" class="sorting" tabindex="0"
                                                aria-controls="example" rowspan="1" colspan="1" style="width: 81.4px;"
                                                aria-label="Purchase ID: activate to sort column ascending">CREATED DATE
                                            </th>
                                            <th data-ordering="false" class="sorting" tabindex="0"
                                                aria-controls="example" rowspan="1" colspan="1" style="width: 200.4px;"
                                                aria-label="Title: activate to sort column ascending">TITLE
                                            </th>
                                            <th data-ordering="false" class="sorting" tabindex="0"
                                                aria-controls="example" rowspan="1" colspan="1" style="width: 74.4px;"
                                                aria-label="User: activate to sort column ascending">REVENUE
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="example" rowspan="1"
                                                colspan="1" style="width: 84.4px;"
                                                aria-label="Assigned To: activate to sort column ascending">EXPENSE
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="example" rowspan="1"
                                                colspan="1" style="width: 76.4px;"
                                                aria-label="Created By: activate to sort column ascending">BALANCE
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="example" rowspan="1"
                                                colspan="1" style="width: 83.4px;"
                                                aria-label="Create Date: activate to sort column ascending">CREATED BY
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="example" rowspan="1"
                                                colspan="1" style="width: 48.4px;"
                                                aria-label="Status: activate to sort column ascending">
                                                NOTE
                                            </th>
                                            <th class="sorting sorting_asc" tabindex="0" aria-controls="example"
                                                rowspan="1" colspan="1" style="width: 43.4px;"
                                                aria-label="Action: activate to sort column descending"
                                                aria-sort="ascending">BILL
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="table-body">
                                        <c:forEach varStatus="loop" var="a"
                                                   items="${requestScope.list.accountResponseList}">
                                            <tr class="odd">
                                                <th scope="row" class="dtr-control sorting_1" tabindex="0">
                                                    <div class="form-check">
                                                        <input class="form-check-input fs-15" type="checkbox"
                                                               name="checkAll"
                                                               value="option1">
                                                    </div>
                                                </th>
                                                <td>${(list.pageNumber - 1) * list.pageSize + loop.index + 1}</td>
                                                <td><a href="/accounting/detail/${a.id}"><c:out value="${a.id}"/></a>
                                                </td>
                                                <td style=""><c:out value="${a.createdDate}"/></td>
                                                <td style=""><c:out value="${a.title}"/></td>
                                                <td class="${a.revenue > 0 ? 'text-success' : ''}"><fmt:formatNumber
                                                        type="number" value="${a.revenue}" pattern="#,##0 ₫"/></td>
                                                <td class="${a.revenue > 0 ? 'text-danger' : ''}"><fmt:formatNumber
                                                        type="number" value="${a.expense}" pattern="#,##0 ₫"/></td>
                                                <td class="${a.revenue > 0 ? 'text-primary' : ''}"><fmt:formatNumber
                                                        type="number" value="${a.remain}" pattern="#,##0 ₫"/></td>
                                                <td style=""><c:out value="${a.user.fullname}"/></td>
                                                <td style=""><span
                                                        class="badge badge-soft-info cut-file-name"
                                                        data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                        title="${a.note}">${a.note}</span></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty a.bill}">
                                                            <c:forEach items="${a.bill}" var="file">
                                                        <span class="badge bg-soft-success">
                                                            <a href="${file}" download="" target="_blank"
                                                               data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                               title="${file.substring(file.indexOf('-') + 1)}"
                                                               class="cut-file-name"
                                                               id="resumeLink">${file}</a>
                                                        </span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="display: none;">
                                                    <div class="dropdown d-inline-block">
                                                        <button class="btn btn-soft-secondary btn-sm dropdown"
                                                                type="button"
                                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                            <i class="ri-more-fill align-middle"></i>
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-end">
                                                            <li><a href="#!" class="dropdown-item"><i
                                                                    class="ri-eye-fill align-bottom me-2 text-muted"></i>
                                                                View</a>
                                                            </li>
                                                            <li><a class="dropdown-item edit-item-btn"><i
                                                                    class="ri-pencil-fill align-bottom me-2 text-muted"></i>
                                                                Edit</a></li>
                                                            <li>
                                                                <a class="dropdown-item remove-item-btn">
                                                                    <i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i>
                                                                    Delete
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <c:set var="totalExpense" value="${totalExpense + a.expense}" scope="page"/>
                                            <c:set var="totalRevenue" value="${totalRevenue + a.revenue}" scope="page"/>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-md-5">
                                    <div class="dataTables_info" id="example_info" role="status" aria-live="polite">
                                        Showing 1 to
                                        10 of 14 entries
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-7">
                                    <div class="dataTables_paginate paging_simple_numbers" id="example_paginate">
                                        <ul class="pagination" id="pagination">
                                            <c:choose>
                                                <c:when test="${list.hasPrevious}">
                                                    <li class="paginate_button page-item previous"
                                                        id="first"><a
                                                            aria-controls="example" data-dt-idx="0"
                                                            tabindex="0"
                                                            class="page-link" onclick="loadPage(1)">First</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="paginate_button page-item previous disabled"
                                                        id="first"><a
                                                            aria-controls="example" data-dt-idx="0"
                                                            tabindex="0"
                                                            class="page-link" onclick="loadPage(1)">First</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${list.hasPrevious}">
                                                    <li class="paginate_button page-item previous"
                                                        id="previous"><a
                                                            aria-controls="example" data-dt-idx="0"
                                                            tabindex="0"
                                                            class="page-link"
                                                            onclick="loadPage(${list.pageNumber - 1})">Previous</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="paginate_button page-item previous disabled"
                                                        id="previous"><a
                                                            aria-controls="example" data-dt-idx="0"
                                                            tabindex="0"
                                                            class="page-link"
                                                            onclick="loadPage(${list.pageNumber - 1})">Previous</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:forEach var="page" begin="1" end="${list.totalPages}">
                                                <c:choose>
                                                    <c:when test="${page == list.pageNumber}">
                                                        <li class="paginate_button page-item active"><a
                                                                style="cursor: pointer"
                                                                aria-controls="example"
                                                                data-dt-idx="1"
                                                                tabindex="0"
                                                                class="page-link">${page}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="paginate_button page-item"><a
                                                                style="cursor: pointer"
                                                                aria-controls="example"
                                                                data-dt-idx="1"
                                                                tabindex="0"
                                                                class="page-link"
                                                                onclick="loadPage(${page})">${page}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${list.hasNext}">
                                                    <li class="paginate_button page-item next"
                                                        id="next"><a
                                                            style="cursor: pointer"
                                                            aria-controls="example" data-dt-idx="3"
                                                            tabindex="0"
                                                            class="page-link"
                                                            onclick="loadPage(${list.pageNumber + 1})">Next</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="paginate_button page-item next disabled"
                                                        id="next"><a
                                                            aria-controls="example" data-dt-idx="3"
                                                            tabindex="0"
                                                            class="page-link"
                                                            onclick="loadPage(${list.pageNumber + 1})">Next</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${list.hasNext}">
                                                    <li class="paginate_button page-item next" id="last"><a
                                                            style="cursor: pointer"
                                                            aria-controls="example" data-dt-idx="3"
                                                            tabindex="0"
                                                            class="page-link"
                                                            onclick="loadPage(${list.totalPages})">Last</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="paginate_button page-item next disabled" id="last"><a
                                                            aria-controls="example" data-dt-idx="3"
                                                            tabindex="0"
                                                            class="page-link"
                                                            onclick="loadPage(${list.totalPages})">Last</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                <td class="text-success"><fmt:formatNumber type="number" value="${totalRevenue}"
                                                           pattern="#,##0 ₫"/></td>
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
</div>
<script>
    cutShortLink();
    var defaultDate = new Date();
    var currentYear = defaultDate.getFullYear();
    var currentMonth = defaultDate.getMonth() + 1;
    var formattedTextStartDate = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-01';
    document.getElementById("datePickerStart").value = formattedDateToText(formattedTextStartDate);

    var lastDay = new Date(currentYear, currentMonth, 0);
    var lastDayOfMonth = lastDay.getDate();
    var formattedTextEndDate = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-' + lastDayOfMonth;
    document.getElementById("datePickerEnd").value = formattedDateToText(formattedTextEndDate);

    function formattedDateToText(inputDate) {
        const dateObj = new Date(inputDate);

        const monthNames = [
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];

        const day = dateObj.getDate();
        const month = monthNames[dateObj.getMonth()];
        const year = dateObj.getFullYear();

        return day + " " + month + ', ' + year;
    }

    function formattedDate(inputDate) {
        if (inputDate !== null) {
            const dateObj = new Date(inputDate);

            const year = dateObj.getFullYear();
            let month = dateObj.getMonth() + 1;
            let day = dateObj.getDate();

            month = month < 10 ? "0" + month : month;
            day = day < 10 ? "0" + day : day;

            return year + "-" + month + "-" + day;
        } else return "";
    }

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

    document.addEventListener("DOMContentLoaded", function () {
        // if (!isDeleveloper()) {
        // Lấy tham chiếu đến các phần tử HTML
        var yearSelect = document.getElementById('account-year');
        var monthSelect = document.getElementById('account-month');
        var data;
        callAjaxByJsonWithData('/api/v1/accounts', 'GET', null, function (rs) {
            data = rs;
            yearSelect.innerHTML = '<option value="">-- Select Year --</option>';
            data.monthList.forEach(function (entry) {
                let option = document.createElement('option');
                option.value = entry.year;
                option.textContent = entry.year;
                yearSelect.appendChild(option);
            });
        });

        yearSelect.addEventListener('change', function () {
            $('#account-day').after(createLoadingHtml());
            callAjaxByJsonWithData('/api/v1/accounts', 'GET', null, function (rs) {
                var dataMonth = rs;
                monthSelect.innerHTML = '<option value="">-- Select Month --</option>';
                dataMonth.monthList.forEach(function (entry) {
                    if (yearSelect.value === entry.year) {
                        entry.month.forEach(function (target) {
                            var option = document.createElement('option');
                            option.value = target;
                            option.textContent = target;
                            monthSelect.appendChild(option);
                        })
                    }
                });
                monthSelect.addEventListener('change', function () {
                    month = yearSelect.value + "-" + monthSelect.value;
                    console.log(month);
                    loadPage(1);
                });
                $('div.custom-spinner').parent().remove();
            });

            if (yearSelect.value !== "") {
                monthSelect.style.display = 'block';
            } else {
                monthSelect.style.display = 'none';
            }
        });
        // }
    });

    function loadPage(page) {
        var selectedPageSize = localStorage.getItem("selectedPageSize") || ${list.pageSize};
        var selectedDateStart = localStorage.getItem("selectedDateStart") || null;
        var selectedDateEnd = localStorage.getItem("selectedDateEnd") || null;

        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var responseData = JSON.parse(xhr.responseText);

                    var tableBody = document.getElementById("table-body");

                    var totalSpend = document.getElementById("total");

                    var totalExpense = 0;
                    var totalRevenue = 0;
                    var totalRemain = 0;

                    if (responseData.accountResponseList.length === 0) {
                        tableBody.innerHTML = "";
                        row.innerHTML = "<td colspan='10' class='text-center'>NOT FOUND DATA IN THIS DURATION</td>";
                    } else {
                        tableBody.innerHTML = "";
                        responseData.accountResponseList.forEach((account, index) => {
                            var row = tableBody.insertRow();
                            row.innerHTML = "<th scope='row' class='align-middle text-center'>" + ((page - 1) * selectedPageSize + index + 1) + "</th>"
                                + "<td class='align-middle' >" + '<a href="/accounting/detail/' + account.id + '">' + account.id + "</a>" + "</td>"
                                + "<td class='align-middle' >" + account.createdDate + "</td>"
                                + "<td class='align-middle' >" + account.title + "</td>"
                                + "<td class='align-middle min-width text-right' style='color: " + (account.revenue > 0 ? 'green' : 'inherit') + "'>" + formatCurrency(account.revenue) + "</td>"
                                + "<td class='align-middle min-width text-right' style='color: " + (account.expense < 0 ? 'red' : 'inherit') + "'>" + formatCurrency(account.expense) + "</td>"
                                + "<td class='align-middle min-width text-right' style='color: blue'>" + formatCurrency(account.remain) + "</td>"
                                + "<td class='align-middle'>" + account.user.fullname + "</td>"
                                + "<td class='align-middle text-break'>" + (account.note !== null ? account.note : '') + "</td>";
                            if (account.bill) {
                                var cell = row.insertCell();

                                var files = account.bill;

                                for (var i = 0; i < files.length; i++) {
                                    var file = files[i];
                                    let subStringFile = file.substring(file.indexOf('-') + 1);
                                    var downloadLink = document.createElement("a");
                                    downloadLink.href = file;
                                    downloadLink.setAttribute("download", "");
                                    downloadLink.target = "_blank";
                                    downloadLink.classList.add("cut-file-name", "text-break")
                                    downloadLink.id = "resumeLink";
                                    downloadLink.title = subStringFile;
                                    downloadLink.textContent = file;
                                    downloadLink.setAttribute("data-toggle", "tooltip");
                                    downloadLink.setAttribute("data-placement", "bottom");
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
                        cutShortLink();
                    }

                    updatePagination(responseData);

                    totalSpend.innerHTML = '<th>Page ' + page + '</th>' + '<td class="text-success">' + formatCurrency(totalRevenue) + '</td>'
                        + '<td class="text-danger">' + formatCurrency(totalExpense) + '</td>'
                        + '<td class="text-primary">' + formatCurrency(totalRemain) + '</td>';
                } else {
                    $('#errorModal').modal('show');
                }
            }
        };
        xhr.open("GET", "/api/v1/accounts/" + month + "?page=" + page + "&size=" + selectedPageSize + "&startDate=" + formattedDate(selectedDateStart) + "&endDate=" + formattedDate(selectedDateEnd), true);
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

        if (responseData.hasPrevious) {
            paginationHTML += '<li class="page-item"><a class="page-link" onclick="loadPage(1, ' + responseData.pageSize + ')">First</a></li>';
        } else {
            paginationHTML += '<li class="page-item disabled"><a class="page-link" onclick="loadPage(1, ' + responseData.pageSize + ')">First</a></li>';
        }

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

        if (responseData.hasNext) {
            paginationHTML += '<li class="page-item"><a class="page-link" style="cursor: pointer" onclick="loadPage(' + totalPages + ', ' + responseData.pageSize + ')">Last</a></li>';
        } else {
            paginationHTML += '<li class="page-item disabled"><a class="page-link" style="cursor: pointer" onclick="loadPage(' + totalPages + ', ' + responseData.pageSize + ')">Last</a></li>';
        }

        pagination.innerHTML = paginationHTML;
    }
</script>
<%--<div id="loading" class="loading-spin">Loading...</div>--%>
</body>
</html>

