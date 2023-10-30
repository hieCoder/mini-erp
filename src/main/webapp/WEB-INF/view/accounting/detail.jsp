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
    <link href="/assets/libs/dropzone/dropzone.css" rel="stylesheet" type="text/css">
    <!-- quill css -->
    <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css"/>
    <!-- bubble css for bubble editor-->
    <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css"/>
    <!-- snow css for snow editor-->
    <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css"/>
    <style>
        .ql-container {
            min-height: 10rem;
            height: 100%;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .ql-editor {
            height: 100%;
            flex: 1;
            overflow-y: auto;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card shadow">
        <div class="card-header">
            Accounting Detail
        </div>
        <div class="card-body" id="table-body">
            <h5 class="card-title">Title: <span id="titleAccount">${account.title}</span></h5>
            <div class="row">
                <div class="col">
                    <p class="card-text">Created date: <span id="createdDateAccount">${account.createdDate}</span></p>
                </div>
                <div class="col">
                    <p class="card-text">Pay date: <span id="payDateAccount">${account.payDate}</span></p>
                </div>
                <div class="col text-right">
                    <p class="card-text">Username: <span id="fullnameAccount">${account.user.fullname}</span></p>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-4 col-md-6">
                    <div class="card card-height-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="avatar-sm flex-shrink-0">
                                            <span class="avatar-title bg-soft-success text-success rounded-2 fs-2">
                                                <i class="bx bxs-badge-dollar"></i>
                                            </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-uppercase fw-medium text-muted mb-3">Total Revenue</p>
                                    <h4 class="fs-4 mb-3"><span class="counter-value" data-target="${account.revenue}"
                                                                id="revenueAccount"><fmt:formatNumber type="number"
                                                                                                      value="${account.revenue}"
                                                                                                      pattern="#,##0 ₫"/></span>₫
                                    </h4>
                                    <p class="text-muted mb-0">From $1,750.04 last year</p>
                                </div>
                                <div class="flex-shrink-0 align-self-center">
                                    <span class="badge badge-soft-success fs-12"><i
                                            class="ri-arrow-up-s-line fs-13 align-middle me-1"></i>22.96 %<span></span></span>
                                </div>
                            </div>
                        </div><!-- end card body -->
                    </div>
                </div>
                <div class="col-xl-4 col-md-6">
                    <div class="card card-height-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="avatar-sm flex-shrink-0">
                                            <span class="avatar-title bg-soft-danger text-danger rounded-2 fs-2">
                                                <i class="bx bxs-cart-download"></i>
                                            </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-uppercase fw-medium text-muted mb-3">Total Expense</p>
                                    <h4 class="fs-4 mb-3"><span class="counter-value" data-target="${account.expense}"
                                                                id="expenseAccount">${account.expense}</span>₫</h4>
                                    <p class="text-muted mb-0">From $1,750.04 last year</p>
                                </div>
                                <div class="flex-shrink-0 align-self-center">
                                    <span class="badge badge-soft-success fs-12"><i
                                            class="ri-arrow-up-s-line fs-13 align-middle me-1"></i>22.96 %<span></span></span>
                                </div>
                            </div>
                        </div><!-- end card body -->
                    </div>
                </div>
                <div class="col-xl-4 col-md-6">
                    <div class="card card-height-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <div class="avatar-sm flex-shrink-0">
                                            <span class="avatar-title bg-soft-primary text-primary rounded-2 fs-2">
                                                <i class="bx bxs-box"></i>

                                            </span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="text-uppercase fw-medium text-muted mb-3">Balance</p>
                                    <h4 class="fs-4 mb-3"><span class="counter-value" data-target="${account.remain}"
                                                                id="remainAccount">${account.remain}</span>₫</h4>
                                    <p class="text-muted mb-0">From $1,750.04 last year</p>
                                </div>
                                <div class="flex-shrink-0 align-self-center">
                                    <span class="badge badge-soft-success fs-12"><i
                                            class="ri-arrow-up-s-line fs-13 align-middle me-1"></i>22.96 %<span></span></span>
                                </div>
                            </div>
                        </div><!-- end card body -->
                    </div>
                </div>
            </div>


            <div class="col-md-12 rounded border border-warning p-3 mb-3">
                <i class="fa-regular fa-lg fa-clipboard fa-bounce" style="color: #4a4c87;"></i>
                <strong class="text-info">Note: </strong><span id="noteAccount" class="text-info">${account.note}</span>
            </div>
            <c:choose>
                <c:when test="${not empty account.bill}">
                    Bill:<br>
                    <div class="row" id="attachedFilesNotification">
                        <c:set var="imageType" value="${setting.listTypeImage}"/>
                        <c:set var="fileType" value="${setting.listTypeFile}"/>
                        <c:forEach items="${account.bill}" var="file">
                            <div class="col-md-4 text-center">
                                <c:if test="${fn:contains(imageType, file.substring(file.lastIndexOf('.') + 1))}">
                                    <img width="50" height="50" src="${file}" alt="">
                                </c:if>
                                <c:if test="${fn:contains(fileType, file.substring(file.lastIndexOf('.') + 1))}">
                                    <img width="50" height="50"
                                         src="/upload/common/${file.substring(file.lastIndexOf('.') + 1)}.png" alt="">
                                </c:if>
                                <br>
                                <a href="${file}" download="" target="_blank" data-toggle="tooltip"
                                   data-placement="bottom"
                                   title="${file.substring(file.indexOf('-') + 1)}">
                                  <span class="shortened-text"
                                        style="display:inline-block;width: 250px">${file.substring(file.indexOf('-') + 1)}</span>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="card-text">Bill: <span id="attachedFilesNotification"></span></p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-footer">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" id="editBtn">Edit
            </button>
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete</button>
            <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#cancelModal" onclick="goBack()">
                Cancel
            </button>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Edit Information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <!-- Your edit form content goes here -->
                                <form enctype="multipart/form-data">
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="editTitle">Title</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="editTitle"
                                                   value="${account.title}" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-lg-3">
                                            <label for="transactionType">Transaction Type</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <select class="form-control" id="transactionType" required>
                                                <option value="">--Select Option--</option>
                                                <option value="revenue" ${account.revenue > 0 ? 'selected' : ''}>
                                                    Revenue
                                                </option>
                                                <option value="expense" ${account.expense < 0 ? 'selected' : ''}>
                                                    Expense
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row mb-3" id="amountGroup">
                                        <div class="col-lg-3">
                                            <label for="amount">Amount</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <input type="text" class="form-control" id="amount" step="1"
                                                   value="${account.revenue > 0 ? account.revenue : -account.expense}"
                                                   required
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
                                            <label for="editNote">Note</label>
                                        </div>
                                        <div class="col-lg-9">
                                            <textarea class="form-control" id="editNote"
                                                      required>${account.note}</textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="pt-3 border-top border-top-dashed mt-4">
                                            <h6 class="mb-3 fw-semibold text-uppercase">Files Uploaded</h6>
                                            <div class="row g-3 showFilesUploaded">
                                            </div>
                                            <!-- end row -->
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Attached files</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered text-center">
                                    <thead>
                                    <tr>
                                        <th class="text-center col-6">File Format</th>
                                        <th class="text-center col-3">Maximum Size</th>
                                        <th class="text-center col-3">Maximum Files</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="text-center col-6">${listTypeFile}</td>
                                        <td class="text-center col-3">${maxFileSize} MB</td>
                                        <td class="text-center col-3">${uploadFileLimit}</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div>
                                    <p class="text-muted">Add Attached files here.</p>

                                    <div class="dropzone" id="dropzoneEdit">
                                        <div class="fallback">
                                            <input name="file" type="file" multiple="multiple">
                                        </div>
                                        <div class="dz-message needsclick">
                                            <div class="mb-3">
                                                <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                            </div>

                                            <h5>Drop files here or click to upload.</h5>
                                        </div>
                                    </div>

                                    <ul class="list-unstyled mb-0" id="dropzone-preview-edit">
                                        <li class="mt-2" id="dropzone-preview-list-edit">
                                            <!-- This is used as the file preview template -->
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="d-flex p-2">
                                                        <div class="flex-shrink-0 me-3">
                                                            <div class="avatar-sm">
                                                                <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                    <i class="ri-file-upload-line"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="pt-1">
                                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <!-- end dropzon-preview -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class=" modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this file?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" id="deleteFileButton" class="btn btn-danger">Delete</button>
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
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this information?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal"
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
                <h5 class="modal-title" id="exampleModalLabel">Inform!</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Bad Request</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                An error occurred while sending the request. Please try again.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    var imageType = "${setting.listTypeImage}";
    var fileType = "${setting.listTypeFile}";
    var validFileUpload = "${setting.listTypeFile}" + "," + "${setting.listTypeImage}";
    var validExtensions = validFileUpload.split(',');
    var spanElement = $("#editModal #validFileText");
    spanElement.text("*File must be " + validFileUpload + ", file not over " + "${setting.maxFileSize}" + "MB and below " + "${setting.uploadFileLimit}" + " files");

    function convertMaxFileSize(string) {
        var maxFileSizeWithoutMB = string.replace("MB", "");
        return parseFloat(maxFileSizeWithoutMB) * 1024 * 1024;
    }

    $(document).on("click", ".listFilesEdit button", function (e) {
        $("#deleteConfirmationModalFile #deleteFileButton").attr("data-name", $(this).attr("data-name"))
    });

    $(document).on("click", "#deleteFileButton", function (e) {
        $('.listFilesEdit button[data-name="' + $(this).attr("data-name") + '"]').parent().remove()
        $("#deleteConfirmationModalFile").modal("hide");
    });

    $(document).on("change", "#editBill", function (event) {
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

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
    }

    document.getElementById('editBtn').addEventListener('click', function () {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/api/v1/accounts/detail/" + "${account.id}", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var responseData = JSON.parse(xhr.responseText);
                        $("#editBill").val('');
                        var editLink = $('#editLink');
                        var accountBill = responseData.bill;
                        if (accountBill) {
                            if (accountBill.length > 0) {
                                editLink.html('')
                                $.each(accountBill, function (index, file) {
                                    var fileName = file.substring(file.lastIndexOf('/') + 1);
                                    var linkText = file.substring(file.indexOf('-') + 1);

                                    var listItem = $('<li>', {
                                        class: 'list-group-item listFilesEdit',
                                        'data-name': fileName
                                    });

                                    var link = $('<a>', {
                                        href: file,
                                        download: '',
                                        target: '_blank',
                                        id: 'resumeLink'
                                    }).text(linkText);

                                    var deleteButton = $('<button>', {
                                        type: 'button',
                                        class: 'btn btn-danger ml-2',
                                        'data-bs-toggle': 'modal',
                                        'data-bs-target': '#deleteConfirmationModalFile',
                                        'data-name': fileName
                                    }).html('<span>×</span>');
                                    listItem.append(link, deleteButton);
                                    editLink.append(listItem);
                                });
                            }
                        }
                        $('#editModal').modal('show');
                    } else {
                        $('#editModal').modal('hide');
                        $('#errorModal').modal('show');
                    }
                }
            }
            xhr.send();
        }
    );

    function editAccount(accountId) {
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "/api/v1/accounts/edit", true);

        var title = document.getElementById("editTitle").value;
        var note = document.getElementById("editNote").value;
        var transaction = document.getElementById("transactionType").value;
        var input = document.getElementById("amount").value;
        var amount = Number(input.replace(/[^0-9.]/g, ''))

        var billInput = document.getElementById("editBill");
        var billFiles = billInput.files;
        var oldFile = []
        $("li.listFilesEdit").each(function () {
            oldFile.push($(this).attr("data-name"));
        });

        if (!title || !amount || isNaN(amount)) {
            alert("Title and amount are required and amount must be a number.");
            loading.style.display = "none";
            return;
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
                    var xhtml = '';
                    if (responseData.bill != null && responseData.bill.length > 0) {
                        responseData.bill.forEach((e) => {
                            xhtml += '<div class="col-md-4 text-center">';
                            var fileExtension = e.substring(e.lastIndexOf('.') + 1);
                            if (imageType.includes(fileExtension)) {
                                var img = document.createElement('img');
                                img.width = 50;
                                img.height = 50;
                                img.src = e;
                                img.alt = '';
                                xhtml += img.outerHTML;
                            }
                            if (fileType.includes(fileExtension)) {
                                var file = document.createElement('img');
                                file.width = 50;
                                file.height = 50;
                                file.src = "/upload/common/" + fileExtension + ".png";
                                file.alt = '';
                                xhtml += file.outerHTML;
                            }
                            var subStringBill = e.substring(e.indexOf('-') + 1);
                            xhtml += '<br><a href="' + e + '" download target="_blank" data-toggle="tooltip" data-placement="bottom" title="' + subStringBill + '">' +
                                '<span class="shortened-text" style="display:inline-block;width: 250px">' + subStringBill + '</span></a></div>';
                        })
                    }
                    $("#attachedFilesNotification").html(xhtml);
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
                    $('#successModal div.modal-body').text("The request has been completed successfully.")
                    $('#successModal').modal('show');
                    editLink.innerHTML = billContent;
                    $('#editBill').val("");
                } else {
                    $('#editModal').modal('hide');
                    $('#errorModal').modal('show');
                }
            }
        };
        xhr.send(formData);
    }

    function goBack() {
        window.location.replace(document.referrer);
    }

    function deleteAccount(accountId) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    $('#successModal div.modal-body').text("The request has been completed successfully.")
                    $('#successModal').modal('show');
                    window.location.replace(document.referrer);
                } else {
                    $('#deleteModal').modal('hide');
                    $('#errorModal').modal('show');
                }
            }
        }
        xhr.open("DELETE", "/api/v1/accounts/" + accountId, true);
        xhr.send();
    }
</script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>
<!-- init js -->
<%--<script src="/assets/js/pages/form-editor.init.js"></script>--%>
<script>
    function bytesToMB(bytes) {
        return parseInt((bytes / (1024 * 1024)).toFixed(0))
    }

    function bytesToMBShow(bytes) {
        return (bytes / (1024 * 1024)).toFixed(2)
    }

    function showFileUploaded(fileName, size, url) {

        return "<div class='col-xxl-4 col-lg-6' data-name='" + fileName + "'>"
            + "    <div class='border rounded border-dashed p-2'>"
            + "        <div class='d-flex align-items-center'>"
            + "            <div class='flex-shrink-0 me-3'>"
            + "                <div class='avatar-sm'>"
            + "                    <div class='avatar-title bg-light text-secondary rounded fs-24'>"
            + "                        <i class='ri-file-download-line'></i>"
            + "                    </div>"
            + "                </div>"
            + "            </div>"
            + "            <div class='flex-grow-1 overflow-hidden'>"
            + "                <h5 class='fs-13 mb-1'><a href='" + url + "' download data-toggle='tooltip' data-placement='bottom' title='" + fileName + "' class='text-body text-truncate d-block'>" + fileName + "</a></h5>"
            + "                <div>" + bytesToMBShow(size) + " MB</div>"
            + "            </div>"
            + "            <div class='flex-shrink-0 ms-2'>"
            + "                <div class='d-flex gap-1'>"
            + "                    <button type='button' class='btn btn-icon text-muted btn-sm fs-18 downFileBtn'>"
            + "                        <i class='ri-download-2-line' data-url='" + url + "'></i>"
            + "                    </button>"
            + "                    <button type='button' class='btn btn-icon text-muted btn-sm fs-18 deleteFileBtn'>"
            + "                        <i class='ri-delete-bin-fill' data-name='" + fileName + "'></i>"
            + "                    </button>"
            + "                </div>"
            + "            </div>"
            + "        </div>"
            + "    </div>"
            + "</div>";
    }

    // function loadDatabase() {
    //     var currentUrl = window.location.search;
    //     var params = new URLSearchParams(currentUrl);
    //     var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
    //     var pageSize = !params.get('pageSize') ? 10 : parseInt(params.get('pageSize'));
    //     var search = !params.get('search') ? "" : params.get('search');
    //     let currentGet = "?page=" + currentPage + "&pageSize=" + pageSize + "&search=" + search
    //     var apiUrl = baseUrlNotification + currentGet
    //     // callAjaxByJsonWithData(apiUrl, "GET", null,
    //     //     function (rs) {
    //     //         if(rs){
    //     //             history.pushState(null, null, currentUrl);
    //     //             let xhtml =""
    //     //             var currentURL = window.location.href;
    //     //             var urlParams = new URLSearchParams(currentURL);
    //     //             var pageSize = urlParams.get("pageSize") ? urlParams.get("pageSize") : 10
    //     //             rs.forEach(function (notification, index) {
    //     //                 let pageInt = (parseInt(page) - 1) * pageSize
    //     //                 xhtml += '<tr class="">' +
    //     //                     '<td>' + (index + pageInt + 1) + '</td>' +
    //     //                     '<td class="fw-bold"><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
    //     //                     '<td>' + notification.user.fullname + '</td>' +
    //     //                     '<td>' + notification.createdDate + '</td>' +
    //     //                     '<td>' +
    //     //                     '    <div class="d-flex gap-2" data-id="'+ notification.id +  '">' +
    //     //                     '<div class="viewNotification">'+
    //     //                     '<button class="btn btn-sm btn-info edit-item-btn">View</button>'+
    //     //                     ' </div>'+
    //     //                     '<div class="editNotification">'+
    //     //                     '<button class="btn btn-sm btn-success edit-item-btn">Edit</button>'+
    //     //                     '</div>'+
    //     //                     '<div class="removeNotification">'+
    //     //                     '<button class="btn btn-sm btn-danger remove-item-btn">Remove</button>'+
    //     //                     '</div>'+
    //     //                     '    </div>' +
    //     //                     '</td>'+
    //     //                     '</tr>'
    //     //             })
    //     //             tbodyElement.innerHTML = xhtml
    //     //             tbodyElement.classList.remove("hidden")
    //     //             displayPagination()
    //     //         } else{
    //     //             console.log("Data API Error")
    //     //         }
    //     //     },
    //     //     function (error){
    //     //         console.log("Call API Error")
    //     //         console.log(error)
    //     //     })
    // }
    //
    // loadDatabase()
    $(document).on("click", "div.removeNotification", function () {
        let notificationId = $(this).parent().attr("data-id")
        $("#deleteNotification").attr("data-id", notificationId)
        $("#deleteNotification").modal("show")
    })

    $(document).on("click", "#deleteNotificationBtn", function () {
        let notificationId = $("#deleteNotification").attr("data-id")
        let apiUrlNotification = baseUrlNotification;
        if (notificationId) {
            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
                console.log(rs)
                if (rs) {

                }
                $("#deleteNotification").modal("hide")
            });
        }
    })

    $(document).on("click", "button.downFileBtn", function () {
        let dataUrl = $(this).children().attr("data-url")
        downloadFiles(dataUrl)
    })

    $(document).on("click", "button.deleteFileBtn", function () {
        let fileName = $(this).children().attr("data-name")
        $("#deleteFileModal").attr("data-name", fileName)
        $("#deleteFileModal").modal("show")
    })

    $(document).on("click", "button#deleteFileBtn", function () {
        let fileName = $("#deleteFileModal").attr("data-name")
        $('div.showFilesUploaded > div[data-name="' + fileName + '"]').remove();
        $("#deleteFileModal").modal("hide")
        dropzoneEdit.options.maxFiles = dropzoneEdit.options.maxFiles + 1;
    })

    function downloadFiles(url) {
        var link = document.createElement('a');
        link.href = url;
        link.style.display = 'none';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    $(function () {
        $('[data-toggle="tooltip"]').tooltip();
    })
    var snowEditorData = {};
    snowEditorData.theme = 'snow'
    snowEditorData.modules = {
        'toolbar': [[{'font': []}, {'size': []}], ['bold', 'italic', 'underline', 'strike'],
            [{'color': []}, {'background': []}], [{'script': 'super'}, {'script': 'sub'}],
            [{'header': [false, 1, 2, 3, 4, 5, 6]}, 'blockquote', 'code-block'],
            [{'list': 'ordered'}, {'list': 'bullet'}, {'indent': '-1'}, {'indent': '+1'}],
            ['direction', {'align': []}], ['link', 'image', 'video'], ['clean']]
    }
    var quillCreate = new Quill("#contentCreate", snowEditorData);
    var quillEdit = new Quill("#contentEdit", snowEditorData);
    let listTypeFileArr = "${listTypeFile}".split(",")
    let listTypeFile = ""
    listTypeFileArr.forEach((item, index) => {
        listTypeFile += "." + item
        if (index < listTypeFileArr.length) {
            listTypeFile += ","
        }
    })
    let maxFileSize = "${maxFileSize}"
    let uploadFileLimit = "${uploadFileLimit}"

    var dropzonePreviewNodeEdit = document.querySelector("#dropzone-preview-list-edit");
    var previewTemplateEdit = dropzonePreviewNodeEdit.parentNode.innerHTML;
    dropzonePreviewNodeEdit.id = "";
    dropzonePreviewNodeEdit.parentNode.removeChild(dropzonePreviewNodeEdit);
    var dropzoneEdit = new Dropzone("#dropzoneEdit", {
        url: 'https://httpbin.org/post',
        method: "post",
        previewTemplate: previewTemplate,
        previewsContainer: "#dropzone-preview-edit",
        acceptedFiles: listTypeFile,
        maxFilesize: parseInt(maxFileSize),
        maxFiles: parseInt(uploadFileLimit),
        uploadMultiple: true,
        autoProcessQueue: false,
    });

    function removeAlert() {
        $(".alert-danger").remove()
    }

    function checkLimitFile(count, limit) {
        return count <= limit ? true : false
    }

    function checkTypeFile(type, listType) {
        if (listType.includes(type)) {
            return true
        }
    }

    function checkLimitSize(size, limit) {
        if (parseInt(size) <= limit) {
            return true
        }
    }

    function showAlertValidate(html) {
        let xhtml = '<li class="mt-2" id=""> ' +
            html +
            '</li>'

        let check = $("#dropzone-preview-edit li").children().last()
        if (check.length > 0) {
            $("#dropzone-preview-edit li").children().last().after(xhtml)
        } else {
            $("#dropzone-preview-edit").html(xhtml)
        }

    }

    function showAlertValidateCreate(html) {
        let xhtml = '<li class="mt-2" id=""> ' +
            html +
            '</li>'

        let check = $("#dropzone-preview li").children().last()
        if (check.length > 0) {
            $("#dropzone-preview li").children().last().after(xhtml)
        } else {
            $("#dropzone-preview").html(xhtml)
        }

    }

    dropzone.on("addedfile", function (file) {
        removeAlert();
        let files = dropzone.files
        const fileExtension = file.name.split('.').pop();
        const fileSize = file.size
        if (!checkLimitFile(files.length, parseInt(uploadFileLimit))) {
            dropzone.removeFile(file)
            showAlertValidateCreate(INVALID_FILES_LIMIT)
            return
        }
        if (!checkTypeFile(fileExtension, listTypeFileArr)) {
            dropzone.removeFile(file)
            showAlertValidateCreate(INVALID_FILES_TYPE)
            return
        }
        if (!checkLimitSize(bytesToMB(fileSize), parseInt(maxFileSize))) {
            dropzone.removeFile(file)
            showAlertValidateCreate(INVALID_FILES_TYPE)
            return
        }
    });

    dropzoneEdit.on("addedfile", function (file) {
        removeAlert();
        let files = dropzoneEdit.files
        const fileExtension = file.name.split('.').pop();
        const fileSize = file.size
        if (!checkLimitFile(files.length, parseInt(dropzoneEdit.options.maxFiles))) {
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_LIMIT)
            return
        }
        if (!checkTypeFile(fileExtension, listTypeFileArr)) {
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_TYPE)
            return
        }
        if (!checkLimitSize(bytesToMB(fileSize), parseInt(maxFileSize))) {
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_SIZE)
            return
        }
    });

    $(document).on("click", ".editNotification", function () {
        Dropzone.forElement('#dropzoneEdit').removeAllFiles(true)
        let notificationId = $(this).parent().attr("data-id")
        let apiUrlNotification = baseUrlNotification
        if (notificationId) {
            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null,
                function (rs) {
                    console.log(rs)
                    $("#formEditNotication").attr("data-id", rs.id)
                    $("#titleEdit").val(rs.title)
                    let contentParse = JSON.parse(rs.content)
                    quillEdit.setContents(contentParse)
                    let urlFiles = rs.files ? rs.files : []
                    let fileLength = rs.files ? rs.files.length : 0
                    dropzoneEdit.options.maxFiles = parseInt(uploadFileLimit) - fileLength;
                    let html = ""
                    if (fileLength > 0) {
                        urlFiles.forEach(function (url) {
                            $.ajax({
                                type: "HEAD",
                                url: url,
                                success: function (data, status, xhr) {
                                    var contentLength = xhr.getResponseHeader('Content-Length');
                                    var fileName = url.substring(url.lastIndexOf("/") + 1);
                                    console.log("File Name: " + fileName);
                                    console.log("Content Length: " + contentLength);
                                    html += showFileUploaded(fileName, contentLength, url)
                                    $(".showFilesUploaded").html(html)
                                    $("#formEditNotication").modal("show")
                                }
                            });
                        });
                    } else {
                        $("#formEditNotication").modal("show")
                    }
                },
                function (error) {
                    console.log(error)
                }
            )
        }
        console.log(notificationId)
    })

    $(document).on("click", "button.editBtn", function () {
        removeAlert()
        let notificationId = $("#formEditNotication").attr("data-id")
        let title = $("#titleEdit").val()
        let contentCheck = $("div#formEditNotication .ql-editor").html().toString()
        let content = JSON.stringify(quillEdit.getContents())
        if (title.trim() === "") {
            $("input#titleEdit").parent().after(INVALID_FILLED)
            return false;
        }
        if (contentCheck.trim() == "<p><br></p>" || contentCheck.trim() == "") {
            $("div#contentEdit").parent().after(INVALID_FILLED)
            return false;
        }
        var oldFile = []
        $("div.showFilesUploaded > div").each(function () {
            oldFile.push($(this).attr("data-name"));
        });
        var formData = new FormData();
        formData.append("title", title);
        formData.append("content", content);
        formData.append("oldFile", oldFile);

        if (dropzoneEdit.files.length > 0) {
            for (let i = 0; i < dropzoneEdit.files.length; i++) {
                let file = dropzoneEdit.files[i]
                if (file.accepted) {
                    formData.append("files", file);
                }
            }
        }

        callAjaxByDataFormWithDataForm2("${apiURL}${pathMain}update/" + notificationId, "POST", formData, function (rs) {
            console.log(rs)
            if (rs > 0) {

            }
        }, function (error) {
            console.log(error)
        })

    })
    $(document).on("click", "button.createBtn", function () {
        removeAlert()
        var apiUrlNotification = baseUrlNotification + "/update/"
        let title = $("#titleCreate").val()
        let contentCheck = $(".ql-editor").html().toString()
        let content = JSON.stringify(quillCreate.getContents())
        if (title.trim() === "") {
            $("input#titleCreate").parent().after(INVALID_FILLED)
            return false;
        }
        if (contentCheck.trim() == "<p><br></p>" || contentCheck.trim() == "") {
            $("div#contentCreate").parent().after(INVALID_FILLED)
            return false;
        }
        var formData = new FormData();
        formData.append("title", title);
        formData.append("content", content);
        formData.append("userId", ${userId});
        if (dropzone.files.length > 0) {
            for (let i = 0; i < dropzone.files.length; i++) {
                let file = dropzone.files[i]
                if (file.accepted) {
                    formData.append("files", file);
                }
            }
        }
        callAjaxByDataFormWithDataForm2("${apiURL}${pathMain}", "POST", formData, function (rs) {
            console.log(rs)
            if (rs > 0) {
                $("#formCreateNotication").modal("hide")
            }
        }, function (error) {
            console.log(error)
        })
    })
</script>
</body>
</html>

