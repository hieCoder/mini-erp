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
            <div class="col-md-4 col-xl-4">
                <div class="form-group">
                    <label for="account-day" class="form-label mb-0 text-muted">Filter by year: </label>
                    <div class="input-group" id="account-day">
                        <select class="form-select rounded-pill" aria-label="Default select example" id="account-year">
                            <option value="">-- Select year --</option>
                        </select>
                        <select class="form-select rounded-pill" aria-label="Default select example" id="account-month"
                                style="display: none;">
                            <option value="">-- Select month --</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-xl-4">
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
            <div class="col-md-4 col-xl-4">
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
                                                aria-label="Purchase ID: activate to sort column ascending">PAY DATE
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
                                                <td class="${a.revenue > 0 ? 'text-bg-success' : ''}"><fmt:formatNumber
                                                        type="number" value="${a.revenue}" pattern="#,##0 ₫"/></td>
                                                <td class="${a.expense < 0 ? 'text-bg-danger' : ''}"><fmt:formatNumber
                                                        type="number" value="${a.expense}" pattern="#,##0 ₫"/></td>
                                                <td class="text-bg-primary"><fmt:formatNumber
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
</div>
<div class="row">
    <div class="col-12">
        <button class="btn btn-primary mt-4" data-bs-toggle="modal" data-bs-target="#createModal">Create</button>
    </div>
</div>

<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createModalLabel">Create Information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <!-- Your create form content goes here -->
                <form enctype="multipart/form-data">
                    <div class="row mb-3">
                        <div class="col-lg-3">
                            <label for="createTitle" class="form-label">Title</label>
                        </div>
                        <div class="col-lg-9">
                            <input type="text" class="form-control" id="createTitle" required
                                   placeholder="Enter title">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-lg-3">
                            <label for="createPayDate" class="form-label">Pay Date</label>
                        </div>
                        <div class="col-lg-9">
                            <input type="date" class="form-control" id="createPayDate" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-lg-3">
                            <label for="transactionType" class="form-label">Transaction Type</label>
                        </div>
                        <div class="col-lg-9">
                            <select class="form-control" id="transactionType" required>
                                <option value="">--Select Option--</option>
                                <option value="revenue">Revenue</option>
                                <option value="expense">Expense</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3" id="amountGroup" style="display: none;">
                        <div class="col-lg-3">
                            <label for="amount" class="form-label">Amount</label>
                        </div>
                        <div class="col-lg-9">
                            <input type="text" class="form-control" id="amount" value="0" step="1" required
                                   pattern="[0-9]+">
                        </div>
                    </div>

                    <script>
                        var amount = $('input#amount').val()
                        $('input#amount').val(formatNumberToVND(amount));

                        function formatNumberToVND(number) {
                            var parts = number.toString().split('.');

                            var integerPart = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');

                            var formattedNumber = integerPart;
                            if (parts.length > 1) {
                                formattedNumber += '.' + parts[1];
                            }
                            return formattedNumber;
                        }

                        $(document).ready(function () {
                            $(document).ready(function () {
                                var input = $('#amount');
                                input.on('keydown', function (event) {
                                    var value = input.val();
                                    var charCode = event.which;
                                    if (charCode === 190 || charCode === 110) {
                                        if (value.indexOf('.') !== -1) {
                                            event.preventDefault();
                                        }
                                    }
                                    if ((charCode < 48 || charCode > 57) && (charCode < 96 || charCode > 105) && charCode !== 190 && charCode !== 110) {
                                        if (charCode !== 8 && charCode !== 46) {
                                            event.preventDefault();
                                        }
                                    }
                                });

                                input.on('keyup', function () {
                                    var value = input.val().replace(/[^0-9.]/g, '');
                                    input.val(formatNumberToVND(value));
                                });
                            });
                        })
                    </script>
                    <div class="row mb-3">
                        <div class="col-lg-3">
                            <label for="createNote" class="form-label">Note</label>
                        </div>
                        <div class="col-lg-9">
                            <input type="text" class="form-control" id="createNote" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-lg-3">
                            <label for="createBill">Bill</label>
                        </div>
                        <div class="col-lg-9">
                            <input type="file" class="form-control" id="createBill" multiple>
                            <span class="text-secondary"
                                  id="validFileText">*File must be , file not over ${setting.maxFileSize} and below ${setting.uploadFileLimit} files</span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button class="btn btn-primary" type="button" onclick="sendCreateForm()">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal HTML -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Inform!</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                The request has been completed successfully.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
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
    cutShortLink();
    window.onload = function () {
        var defaultDate = new Date();
        var currentYear = defaultDate.getFullYear();
        var currentMonth = defaultDate.getMonth() + 1;
        var formattedTextStartDate = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-01';
        document.getElementById("datePickerStart").value = formattedDateToText(formattedTextStartDate);
        localStorage.setItem("selectedDateStart", formattedDateToText(formattedTextStartDate));

        var lastDay = new Date(currentYear, currentMonth, 0);
        var lastDayOfMonth = lastDay.getDate();
        var formattedTextEndDate = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-' + lastDayOfMonth;
        document.getElementById("datePickerEnd").value = formattedDateToText(formattedTextEndDate);
        localStorage.setItem("selectedDateEnd", formattedDateToText(formattedTextEndDate));
    }

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
        callAjaxByJsonWithData('/api/v1/accounts/total-month', 'GET', null, function (rs) {
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
            callAjaxByJsonWithData('/api/v1/accounts/total-month', 'GET', null, function (rs) {
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
                    let defaultDate = new Date(month);
                    let pickYear = defaultDate.getFullYear();
                    let pickMonth = defaultDate.getMonth() + 1;
                    let formattedTextStartDate = pickYear + '-' + (pickMonth < 10 ? '0' : '') + pickMonth + '-01';
                    localStorage.setItem("selectedDateStart", formattedDateToText(formattedTextStartDate));

                    let lastDay = new Date(pickYear, pickMonth, 0);
                    let lastDayOfMonth = lastDay.getDate();
                    let formattedTextEndDate = pickYear + '-' + (pickMonth < 10 ? '0' : '') + pickMonth + '-' + lastDayOfMonth;
                    localStorage.setItem("selectedDateEnd", formattedDateToText(formattedTextEndDate));
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
        xhr.open("GET", "/api/v1/accounts/" + "?page=" + page + "&size=" + selectedPageSize + "&startDate=" + formattedDate(selectedDateStart) + "&endDate=" + formattedDate(selectedDateEnd), true);
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


    var validFileUpload = "${setting.listTypeFile}" + "," + "${setting.listTypeImage}";
    var validExtensions = validFileUpload.split(',');
    var spanElement = $("#createModal #validFileText");
    spanElement.text("*File must be " + validFileUpload + ", file not over " + "${setting.maxFileSize}" + " and below " + "${setting.uploadFileLimit}" + " files");

    document.getElementById('transactionType').addEventListener('change', function () {
        var selectedOption = this.value;
        var amountGroup = document.getElementById('amountGroup');
        var amountInput = document.getElementById('amount');

        if (selectedOption === 'revenue') {
            amountGroup.style.display = 'flex';
            amountInput.placeholder = 'Enter positive amount';
            amountInput.min = 0;
        } else if (selectedOption === 'expense') {
            amountGroup.style.display = 'flex';
            amountInput.placeholder = 'Enter positive amount';
            amountInput.min = 0;
        } else {
            amountGroup.style.display = 'none';
        }
    });

    $(document).on("change", "#createBill", function (event) {
        const billFiles = event.target.files;
        var countFile = billFiles.length;
        var countCurrentFile = $("li.listFilesEdit").length;
        if ((countFile + countCurrentFile) >${setting.uploadFileLimit}) {
            let modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum Files is ${setting.uploadFileLimit}.
                        `
            $("#successModal div.modal-body").html(modal)
            $("#successModal").modal("show");
            $(this).val('')
            return;
        }
        for (var i = 0; i < billFiles.length; i++) {
            var fileName = billFiles[i].name;
            var fileExtension = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2);
            if (!validExtensions.includes(fileExtension) || billFiles[i].size > convertMaxFileSize("${setting.maxFileSize}")) {
                let modal = '<strong class="btn-danger rounded-circle p-2">Invalid!</strong> File must be ' +
                    validFileUpload +
                    ' and not over ' + "${setting.maxFileSize}" + 'MB.';
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $(this).val('')
                return;
            }
        }
    });

    function convertMaxFileSize(string) {
        var maxFileSizeWithoutMB = string.replace("MB", "");
        return parseFloat(maxFileSizeWithoutMB) * 1024 * 1024;
    }

    function sendCreateForm() {
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "/api/v1/accounts", true);

        var title = document.getElementById("createTitle").value;
        var note = document.getElementById("createNote").value;
        var transaction = document.getElementById("transactionType").value;
        var input = document.getElementById("amount").value;
        var amount = Number(input.replace(/[^0-9.]/g, ''));
        var billInput = document.getElementById("createBill");
        var billFiles = billInput.files;

        if (!title || !amount || isNaN(amount)) {
            alert("Title, note and amount are required and amount must be a number.");
            loading.style.display = "none";
            return;
        }

        if (transaction === 'expense') {
            amount = -amount;
        }
        var formData = new FormData();

        formData.append("title", title);
        formData.append("note", note);
        formData.append("userId", userCurrent.id);
        formData.append("expense", amount);

        for (var i = 0; i < billFiles.length; i++) {
            formData.append("bill", billFiles[i]);
        }
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 201) {
                    $.ajax({
                        url: "/api/v1/accounts",
                        beforeSend: function (xhr) {
                            xhr.overrideMimeType("text/plain; charset=x-user-defined");
                        }
                    })
                        .done(function (data) {
                            var responseData = JSON.parse(data);
                            $('#yearList').html('');
                            $.each(responseData.monthList, function (index, date) {
                                var yearItem = $('<li/>').addClass('list-group-item year-item').attr('data-toggle', 'collapse').attr('href', '#months' + index).text(date.year);
                                $('#yearList').append(yearItem);

                                var monthsContainer = $('<div/>').addClass('collapse').attr('id', 'months' + index);
                                var monthList = $('<ul/>').addClass('list-group');

                                $.each(date.month, function (index, month) {
                                    var monthItem = $('<li/>').addClass('list-group-item').text(month).on('click', function () {
                                        redirectToAccounting(month);
                                    });
                                    monthList.append(monthItem);
                                });

                                monthsContainer.append(monthList);
                                $('#yearList').append(monthsContainer);
                            });
                            loading.style.display = "none";
                            $('#createNote').val("");
                            $('#createBill').val("");
                            $('#createTitle').val("");
                            $('#amount').val("");
                            $('#amountGroup').css('display', 'none');
                            $('#transactionType').val("");
                            $('#createModal').modal('hide');
                            $('#successModal div.modal-body').text("The request has been completed successfully.")
                            $('#successModal').modal('show');
                        });
                } else {
                    loading.style.display = "none";
                    $('#createModal').modal('hide');
                    $('#errorModal').modal('show');
                }
            }
        };
        xhr.send(formData);
    }

</script>
<%--<div id="loading" class="loading-spin">Loading...</div>--%>
</body>
</html>

