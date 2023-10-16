<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail Accounting</title>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            Accounting Detail
        </div>
        <div class="card-body" id="table-body">
            <h5 class="card-title">Title: ${account.title}</h5>
            <p class="card-text">Created date: ${account.createdDate}</p>
            <p class="card-text">Revenue: ${account.revenue}</p>
            <p class="card-text">Expense: ${account.expense}</p>
            <p class="card-text">Remain: ${account.remain}</p>
            <p class="card-text">Username: ${account.user.fullname}</p>
            <p class="card-text">Bill: <a href="${account.bill == null ? '#' : account.bill}" download=""
                                          target="_blank" id="resumeLink">Download Bill</a></p>
        </div>
        <div class="card-footer">
            <button class="btn btn-primary" data-toggle="modal" data-target="#editModal">Edit</button>
            <button class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">Delete</button>
            <button class="btn btn-secondary" data-toggle="modal" data-target="#cancelModal" onclick="goBack()">Cancel
            </button>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit Information</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Your edit form content goes here -->
                <form enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="editTitle">Title</label>
                        <input type="text" class="form-control" id="editTitle" value="${account.title}" required>
                    </div>
                    <div class="form-group">
                        <label for="transactionType">Transaction Type</label>
                        <select class="form-control" id="transactionType" required>
                            <option value="">--Select Option--</option>
                            <option value="revenue" ${account.revenue > 0 ? 'selected' : ''}>Revenue</option>
                            <option value="expense" ${account.expense < 0 ? 'selected' : ''}>Expense</option>
                        </select>
                    </div>
                    <div class="form-group" id="amountGroup">
                        <label for="amount">Amount</label>
                        <input type="number" class="form-control" id="amount" step="1"
                               value="${account.revenue > 0 ? account.revenue : -account.expense}" required pattern="[0-9]+">
                    </div>
                    <div class="form-group">
                        <label for="editBill">Bill</label>
                        <input type="file" class="form-control" id="editBill" value="${account.bill}" multiple>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button class="btn btn-primary" type="submit" onclick="editAccount('${account.id}')">Save changes
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Delete Information</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this information?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal"
                        onclick="deleteAccount('${account.id}')">Delete
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
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

<script>
    document.getElementById('transactionType').addEventListener('change', function () {
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
        } else {
            amountGroup.style.display = 'none';
        }
    });

    document.getElementById('amount').addEventListener('input', function () {
        var amount = parseFloat(this.value);
        if (isNaN(amount) || amount.includes('-')) {
            this.value = '';
            alert('Amount must be within the specified range.');
        }
    });

    function goBack() {
        window.history.back();
    }

    function deleteAccount(accountId) {
        var loading = document.getElementById("loading");
        loading.style.display = "block";
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                loading.style.display = "none";
                $('#successModal').modal('show');
                window.location.replace(document.referrer);
            }
        }
        xhr.open("DELETE", "/api/v1/accounts/" + accountId, true);
        xhr.send();
    }

    function editAccount(accountId) {
        var loading = document.getElementById("loading");
        loading.style.display = "block";
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "/api/v1/accounts/edit", true);

        var title = document.getElementById("editTitle").value;
        var transaction = document.getElementById("transactionType").value;
        var amount = parseFloat(document.getElementById("amount").value);
        var billInput = document.getElementById("editBill");
        var billFiles = billInput.files;
        console.log(transaction);
        if (transaction === 'expense') {
            amount = -amount;
        }
        console.log(amount);
        var formData = new FormData();

        formData.append("title", title);
        formData.append("id", accountId);
        formData.append("userId", '3');
        formData.append("expense", amount);

        for (var i = 0; i < billFiles.length; i++) {
            formData.append("bill", billFiles[i]);
        }
        // Xử lý phản hồi từ máy chủ
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 302) {
                    var responseData = JSON.parse(xhr.responseText);
                    console.log(responseData);
                    var tableBody = document.getElementById("table-body");
                    tableBody.innerHTML = '<h5 class="card-title">Title:' + responseData.title + '</h5>' + '<p class="card-text">Created date: ' + responseData.createdDate + '</p>'
                        + '<p class="card-text">Revenue: ' + responseData.revenue + '</p>'
                        + '<p class="card-text">Expense: ' + responseData.expense + '</p>'
                        + '<p class="card-text">Username: ' + responseData.user.fullname + '</p>'
                        + '<p class="card-text">Bill: <a href="' + (responseData.bill === null ? '#' : responseData.bill) + '" download="" target="_blank" id="resumeLink">Download Bill</a></p>';
                    loading.style.display = "none";
                    var responseData = xhr.responseText;
                    console.log(responseData);
                    $('#editModal').modal('hide');
                    $('#successModal').modal('show');
                } else {
                    console.error("Requirement Error: " + xhr.status);
                }
            }
        };
        xhr.send(formData);
    }

</script>
<div id="loading" class="loading-spin">Loading...</div>
</body>
</html>

