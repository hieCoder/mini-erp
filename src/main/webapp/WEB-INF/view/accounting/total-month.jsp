<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Total Month Accounting</title>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <h1 class="text-center">Accounting</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <h3 class="mt-4">Years</h3>
            <ul class="list-group" id="yearList">
                <c:forEach varStatus="loop" items="${monthList.monthList}" var="date">
                    <li class="list-group-item year-item" data-toggle="collapse" href="#months${loop.index}">${date.year}</li>
                    <div class="collapse" id="months${loop.index}">
                        <ul class="list-group">
                            <c:forEach items="${date.month}" var="month">
                                <li class="list-group-item" onclick="redirectToAccounting('${month}')">${month}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <button class="btn btn-primary mt-4" data-toggle="modal" data-target="#createModal">Create</button>
        </div>
    </div>

    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createModalLabel">Create Information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Your create form content goes here -->
                    <form enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="createTitle">Title</label>
                            <input type="text" class="form-control" id="createTitle" required>
                        </div>
                        <div class="form-group">
                            <label for="transactionType">Transaction Type</label>
                            <select class="form-control" id="transactionType" required>
                                <option value="">--Select Option--</option>
                                <option value="revenue">Revenue</option>
                                <option value="expense">Expense</option>
                            </select>
                        </div>
                        <div class="form-group" id="amountGroup" style="display: none;">
                            <label for="amount">Amount</label>
                            <input type="number" class="form-control" id="amount" step="1" required pattern="[0-9]+">
                        </div>
                        <div class="form-group">
                            <label for="createBill">Bill</label>
                            <input type="file" class="form-control" id="createBill" multiple>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button class="btn btn-primary" type="button" onclick="sendCreateForm()">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal HTML -->
    <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Success!</h5>
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

    <!-- Modal Error-->
    <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
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
    document.getElementById('transactionType').addEventListener('change', function() {
        var selectedOption = this.value;
        var amountGroup = document.getElementById('amountGroup');
        var amountInput = document.getElementById('amount');

        if (selectedOption === 'revenue') {
            amountGroup.style.display = 'block';
            amountInput.placeholder = 'Enter positive amount';
            amountInput.min = 0;
        } else if (selectedOption === 'expense') {
            amountGroup.style.display = 'block';
            amountInput.placeholder = 'Enter positive amount';
            amountInput.min = 0;
        }  else {
            amountGroup.style.display = 'none';
        }
    });

    document.getElementById('amount').addEventListener('input', function() {
        var amount = parseFloat(this.value);
        if ( isNaN(amount) || amount.includes('-') ) {
            this.value = '';
            alert('Amount must be within the specified range.');
        }
    });

    function redirectToAccounting(month) {
        const trimmedMonth = month.replace(/\s/g, '');
        console.log(trimmedMonth);
        window.location.href = '/accounting/' + trimmedMonth;
    }

    function sendCreateForm() {
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "/api/v1/accounts", true);

        var title = document.getElementById("createTitle").value;
        var transaction = document.getElementById("transactionType").value;
        var amount = parseFloat(document.getElementById("amount").value);
        var billInput = document.getElementById("createBill");
        var billFiles = billInput.files;
        console.log(transaction);
        if (transaction === 'expense') {
            amount = -amount;
        }
        var formData = new FormData();

        formData.append("title", title);
        formData.append("userId", '3');
        formData.append("expense", amount);

        for (var i = 0; i < billFiles.length; i++) {
            formData.append("bill", billFiles[i]);
        }
        // Xử lý phản hồi từ máy chủ
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 201) {
                    var responseData = xhr.responseText;
                    console.log(responseData);
                    $('#createModal').modal('hide');
                    $('#successModal').modal('show');
                } else {
                    $('#createModal').modal('hide');
                    $('#errorModal').modal('show');
                }
            }
        };
        xhr.send(formData);
    }
</script>
</body>
</html>
