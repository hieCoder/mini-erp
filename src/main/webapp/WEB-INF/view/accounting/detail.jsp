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
            <h5 class="card-title">Title: <span id="titleAccount">${account.title}</span></h5>
        </div>
        <div class="card-body" id="table-body">
            <div class="text-muted">
                <div class="pb-3 border-bottom border-bottom-dashed mb-4 ">
                    <div class="row">
                        <div class="col-lg-4 col-sm-6">
                            <div>
                                <p class="mb-2 text-uppercase fw-medium">Create Date :</p>
                                <h5 class="fs-15 mb-0" id="createdDateAccount">${account.createdDate}</h5>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6">
                            <div>
                                <p class="mb-2 text-uppercase fw-medium">Pay Date :</p>
                                <h5 class="fs-15 mb-0" id="payDateAccount">${account.payDate}</h5>
                            </div>
                        </div>
                        <div class="col-lg-4 col-sm-6">
                            <div>
                                <p class="mb-2 text-uppercase fw-medium">Last user created/edited :</p>
                                <div class="badge bg-danger fs-12" id="fullnameAccount">${account.user.fullname}</div>
                            </div>
                        </div>
                    </div>
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

            <div class="alert alert-warning alert-dismissible alert-label-icon rounded-label fade show" role="alert">
                <i class="ri-clipboard-fill label-icon"></i><strong>Note</strong> - <span id="noteAccount">${account.note}</span>
            </div>
            <div class="pt-3 border-top border-top-dashed mt-4">
                <h6 class="mb-3 fw-semibold text-uppercase">Bills</h6>
                <c:choose>
                    <c:when test="${not empty account.bill}">
                        <div class="row g-3" id="attachedFilesNotification">
                            <c:set var="imageType" value="${setting.listTypeImage}"/>
                            <c:set var="fileType" value="${setting.listTypeFile}"/>
                            <c:forEach items="${account.bill}" var="file">
                            <div class="col-xxl-4 col-lg-6">
                                <div class="border rounded border-dashed p-2">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0 me-3">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                    <i class="ri-folder-zip-line"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 overflow-hidden">
                                            <h5 class="fs-13 mb-1"><a href="${file}" download class="text-body text-truncate d-block cut-file-name"
                                                                      data-bs-toggle="tooltip"
                                                                      data-bs-placement="bottom"
                                                                      title="${file.substring(file.indexOf('-') + 1)}">${file}</a></h5>
                                            <div>2.2MB</div>
                                        </div>
                                        <div class="flex-shrink-0 ms-2">
                                            <div class="d-flex gap-1">
                                                <button type="button" class="btn btn-icon text-muted btn-sm fs-18 downFileBtn"><i
                                                        class="ri-download-2-line" data-url="${file}"></i></button>
                                                <div class="dropdown">
                                                    <button class="btn btn-icon text-muted btn-sm fs-18 dropdown"
                                                            type="button"
                                                            data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="ri-more-fill"></i>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a class="dropdown-item" href="#"><i
                                                                class="ri-pencil-fill align-bottom me-2 text-muted"></i>
                                                            Rename</a>
                                                        </li>
                                                        <li><a class="dropdown-item" href="#"><i
                                                                class="ri-delete-bin-fill align-bottom me-2 text-muted"></i>
                                                            Delete</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
                <!-- end col -->

                <!-- end row -->
            </div>
        </div>
        <div class="card-footer" data-id="${account.id}">
            <button class="btn btn-primary editAccount" data-bs-toggle="modal" data-bs-target="#editModal">Edit
            </button>
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete</button>
            <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#cancelModal" onclick="goBack()">
                Cancel
            </button>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal zoomIn" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
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
                                        <td class="text-center col-6">${setting.listTypeFile},${setting.listTypeImage}</td>
                                        <td class="text-center col-3">${setting.maxFileSize} MB</td>
                                        <td class="text-center col-3">${setting.uploadFileLimit}</td>
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
                                                            <strong class="error text-danger"
                                                                    data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3 pt-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete
                                                        </button>
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
                <button class="btn btn-primary editBtn" type="submit">Save changes
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal zoomIn" id="deleteConfirmationModalFile" tabindex="-1" role="dialog"
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
<div class="modal zoomIn" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
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
                <button type="button" class="btn btn-danger" onclick="deleteAccount(${account.id})"
                        data-bs-dismiss="modal">Delete
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal zoomIn" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
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
<div class="modal zoomIn" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
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
<div class="modal zoomIn" id="deleteFileModal" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop"
                               colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Are you Sure?</h4>
                        <p class="text-muted mx-4 mb-0">
                            Are you Sure You want to Delete this File?
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="deleteFileBtn">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    cutShortLink();
    const baseUrlAccount = "/api/v1/accounts/";
    const INVALID_FILLED = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> This field is not filled' +
        '</div>'
    const INVALID_FILES_LIMIT = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> Maximum Files is ${setting.uploadFileLimit}' +
        '</div>'

    const INVALID_FILES_TYPE = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> File type allowed: ${setting.listTypeFile}' + 'and ${setting.listTypeImage}' +
        '</div>'

    const INVALID_FILES_SIZE = ' <div class="alert alert-danger" role="alert">' +
        '<strong> Invalid </strong> Maximum Size Files is ${setting.maxFileSize}' +
        '</div>'
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

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
    }

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

    let listTypeFileArr = validExtensions
    let listTypeFile = ""
    listTypeFileArr.forEach((item, index) => {
        listTypeFile += "." + item
        if (index < listTypeFileArr.length) {
            listTypeFile += ","
        }
    })
    let maxFileSize = "${setting.maxFileSize}"
    let uploadFileLimit = "${setting.uploadFileLimit}"

    var dropzonePreviewNodeEdit = document.querySelector("#dropzone-preview-list-edit");
    var previewTemplateEdit = dropzonePreviewNodeEdit.parentNode.innerHTML;
    dropzonePreviewNodeEdit.id = "";
    dropzonePreviewNodeEdit.parentNode.removeChild(dropzonePreviewNodeEdit);
    var dropzoneEdit = new Dropzone("#dropzoneEdit", {
        url: 'https://httpbin.org/post',
        method: "post",
        previewTemplate: previewTemplateEdit,
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
        }
    });

    $(document).on("click", ".editAccount", function () {
        Dropzone.forElement('#dropzoneEdit').removeAllFiles(true)
        let accountId = $(this).parent().attr("data-id")
        if (accountId) {
            callAjaxByJsonWithData(baseUrlAccount + "detail/" + accountId, 'GET', null,
                function (rs) {
                    $("#editModal").attr("data-id", rs.id)
                    let urlFiles = rs.bill ? rs.bill : []
                    let fileLength = rs.bill ? rs.bill.length : 0
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
                                    html += showFileUploaded(fileName, contentLength, url)
                                    $(".showFilesUploaded").html(html)
                                    $("#editModal").modal("show")
                                }
                            });
                        });
                    } else {
                        $("#editModal").modal("show")
                    }
                },
                function (error) {
                    console.log(error)
                }
            )
        }
    })

    $(document).on("click", "button.editBtn", function () {
        removeAlert()
        let accountId = $("#editModal").attr("data-id")
        let title = $("#editTitle").val()
        let note = $("#editNote").val()
        let transaction = $("#transactionType").val()
        let input = document.getElementById("amount").value;
        let amount = Number(input.replace(/[^0-9.]/g, ''))
        if (transaction === 'expense') {
            amount = -amount;
        }
        if (title.trim() === "") {
            $("input#editTitle").parent().after(INVALID_FILLED)
            return false;
        }
        var oldFile = []
        $("div.showFilesUploaded > div").each(function () {
            oldFile.push($(this).attr("data-name"));
        });
        var formData = new FormData();
        formData.append("title", title);
        formData.append("note", note);
        formData.append("id", accountId);
        formData.append("oldFile", oldFile);
        formData.append("userId", userCurrent.id);
        formData.append("expense", amount);

        if (dropzoneEdit.files.length > 0) {
            for (let i = 0; i < dropzoneEdit.files.length; i++) {
                let file = dropzoneEdit.files[i]
                if (file.accepted) {
                    formData.append("bill", file);
                }
            }
        }

        callAjaxByDataFormWithDataForm2(baseUrlAccount + "edit", "POST", formData, function (rs) {
            if (rs) {
                $("#titleAccount").text(rs.title);
                $("#createdDateAccount").text(rs.createdDate);
                $("#revenueAccount").text(formatCurrency(rs.revenue));
                $("#expenseAccount").text(formatCurrency(rs.expense));
                $("#remainAccount").text(formatCurrency(rs.remain));
                $("#fullnameAccount").text(rs.user.fullname);
                $("#noteAccount").text(rs.note);
                $('#editModal').modal('hide');
                $('#successModal div.modal-body').text("The request has been completed successfully.")
                $('#successModal').modal('show');
                $('#editBill').val("");
            }
        }, function (error) {
            if (error) {
                $('#editModal').modal('hide');
                $('#errorModal').modal('show');
            }
        })
    })
</script>
</body>
</html>

