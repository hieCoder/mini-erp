<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail Accounting</title>
    <link rel="stylesheet" href="../../../assets/css/accounting/style.css">
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            Accounting Detail
        </div>
        <div class="card-body" id="table-body">
            <h5 class="card-title">Title: <span id="titleAccount">${account.title}</span></h5>
            <p class="card-text">Created date: <span id="createdDateAccount">${account.createdDate}</span></p>
            <p class="card-text text-success">Revenue: <span id="revenueAccount"><fmt:formatNumber type="number" value="${account.revenue}" pattern="#,##0 ₫"/></span></p>
            <p class="card-text text-danger">Expense: <span id="expenseAccount"><fmt:formatNumber type="number" value="${account.expense}" pattern="#,##0 ₫"/></span></p>
            <p class="card-text text-primary">Balance: <span id="remainAccount"><fmt:formatNumber type="number" value="${account.remain}" pattern="#,##0 ₫"/></span></p>
            <p class="card-text">Username: <span id="fullnameAccount">${account.user.fullname}</span></p>
            <p class="card-text">Note: <span id="noteAccount">${account.note}</span></p>

            <c:choose>
                <c:when test="${not empty account.bill}">
                    <p class="card-text">Bill: <span id="attachedFilesNotification">
                        <c:forEach items="${account.bill}" var="file">
                            <a href="${file}" download="" target="_blank">${file.substring(file.indexOf('-') + 1)}</a>
                            <br>
                        </c:forEach>
                        </span>
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="card-text">Bill: <span id="attachedFilesNotification"></span></p>
                </c:otherwise>
            </c:choose>
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
    <div class="modal-dialog" role="document">
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
                               value="${account.revenue > 0 ? account.revenue : -account.expense}" required
                               pattern="[0-9]+">
                    </div>
                    <div class="form-group">
                        <label for="editNote">Note</label>
                        <input type="text" class="form-control" id="editNote" value="${account.note}" required>
                    </div>
                    <div class="form-group">
                        <label for="editBill">Bill</label>
                        <input type="file" class="form-control form-control-file" id="editBill" name="files" multiple>
                        <ul id="editLink" class="list-group">
                            <c:choose>
                                <c:when test="${not empty account.bill}">
                                    <c:forEach items="${account.bill}" var="file">
                                        <li class="list-group-item listFilesEdit"
                                            data-name="${file.substring(file.lastIndexOf('/') + 1)}">
                                            <a href="${file}" download="" target="_blank"
                                               id="resumeLink">${file.substring(file.indexOf('-') + 1)}</a>
                                            <button type="button" class="btn btn-danger" data-toggle="modal"
                                                    data-target="#deleteConfirmationModalFile"
                                                    data-name="${file.substring(file.lastIndexOf('/') + 1)}">
                                                <span>×</span>
                                            </button>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </form>
            </div>
            <div class=" modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button class="btn btn-primary" type="submit" onclick="editAccount('${account.id}')">Save changes
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmationModalFile" tabindex="-1" role="dialog"
     aria-labelledby="deleteConfirmationModalFile" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalFileLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this file?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteFileButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Inform!</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
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
    $(document).on("click", ".listFilesEdit button", function (e) {
        $("#deleteConfirmationModalFile #deleteFileButton").attr("data-name", $(this).attr("data-name"))
    });

    $(document).on("click", "#deleteFileButton", function (e) {
        $('.listFilesEdit button[data-name="' + $(this).attr("data-name") + '"]').parent().remove()
        $("#deleteConfirmationModalFile").modal("hide");
    });

    $(document).on("change", "#editBill", function (event) {
        const selectedFiles = event.target.files;
        var countFile = selectedFiles.length;
        var countCurrentFile = $("li.listFilesEdit").length;
        if((countFile+countCurrentFile)>${setting.uploadFileLimit}){
            var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum Files is ${setting.uploadFileLimit}.
                        `
            $("#successModal div.modal-body").html(modal)
            $("#successModal").modal("show");
            $(this).val('')
        }
    });


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

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
    }

    function editAccount(accountId) {
        var loading = document.getElementById("loading");
        loading.style.display = "block";
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "/api/v1/accounts/edit", true);

        var title = document.getElementById("editTitle").value;
        var note = document.getElementById("editNote").value;
        var transaction = document.getElementById("transactionType").value;
        var amount = parseFloat(document.getElementById("amount").value);
        var billInput = document.getElementById("editBill");
        var billFiles = billInput.files;
        var oldFile = []
        $("li.listFilesEdit").each(function() {
            oldFile.push($(this).attr("data-name"));
        });

        if (!title || !amount || isNaN(amount)) {
            alert("Title and amount are required and amount must be a number.");
            loading.style.display = "none";
            return;
        }

        var validExtensions = ["xls", "xlsx", "pdf", "pptx"];
        for (var j = 0; j < billFiles.length; j++) {
            var fileName = billFiles[j].name;
            var fileExtension = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2);
            if (!validExtensions.includes(fileExtension) || billFiles[j].size > 100 * 1024 * 1024) {
                alert("File must be xls, xlsx, pptx or pdf and not over 100mb.");
                loading.style.display = "none";
                return;
            }
        }

        if (transaction === 'expense') {
            amount = -amount;
        }

        var formData = new FormData();
        formData.append("title", title);
        formData.append("note", note);
        formData.append("id", accountId);
        formData.append("oldFile", oldFile);
        formData.append("userId", userCurrent.id);
        formData.append("expense", amount);

        for (var i = 0; i < billFiles.length; i++) {
            formData.append("bill", billFiles[i]);
        }

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 302) {
                    var responseData = JSON.parse(xhr.responseText);
                    $("#titleAccount").text(responseData.title);
                    $("#createdDateAccount").text(responseData.createdDate);
                    $("#revenueAccount").text(formatCurrency(responseData.revenue));
                    $("#expenseAccount").text(formatCurrency(responseData.expense));
                    $("#remainAccount").text(formatCurrency(responseData.remain));
                    $("#fullnameAccount").text(responseData.user.fullname);
                    $("#noteAccount").text(responseData.note);
                    var xhtml = ''
                    if(responseData.bill != null && responseData.bill.length > 0){
                        responseData.bill.forEach((e)=>{
                            xhtml += '<a href="'+ e +'" download target="_blank">'+e.substring(e.indexOf('-') + 1)+'</a><br>'
                        })
                    }
                    $("#attachedFilesNotification").html(xhtml)
                    var editLink = document.getElementById("editLink");
                    var billContent = '';
                    if (responseData.bill !== null && responseData.bill.length > 0) {
                        responseData.bill.forEach(function (file) {
                            billContent += '<li class="list-group-item listFilesEdit" data-name="' + file.substring(file.lastIndexOf('/') + 1) + '">';
                            billContent += '<a href="' + file + '" download="" target="_blank" id="resumeLink">' + file.substring(file.indexOf('-') + 1) + '</a>';
                            billContent += '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteConfirmationModalFile" data-name="' + file.substring(file.lastIndexOf('/') + 1) + '">';
                            billContent += '<span>×</span>';
                            billContent += '</button>';
                            billContent += '</li>';
                        });
                    }
                    $('#editModal').modal('hide');
                    loading.style.display = "none";
                    $('#successModal div.modal-body').text("The request has been completed successfully.")
                    $('#successModal').modal('show');
                    editLink.innerHTML = billContent;
                    $('#editBill').val("");
                } else {
                    loading.style.display = "none";
                    $('#editModal').modal('hide');
                    $('#errorModal').modal('show');
                }
            }
        };
        xhr.send(formData);
    }

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
                $('#successModal div.modal-body').text("The request has been completed successfully.")
                $('#successModal').modal('show');
                window.location.replace(document.referrer);
            }
        }
        xhr.open("DELETE", "/api/v1/accounts/" + accountId, true);
        xhr.send();
    }
</script>
<div id="loading" class="loading-spin">Loading...</div>
</body>
</html>

