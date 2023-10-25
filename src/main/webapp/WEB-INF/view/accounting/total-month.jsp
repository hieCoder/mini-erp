<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Total Month Accounting</title>
    <link rel="stylesheet" href="../../../assets/css/accounting/style.css">
</head>
<body>
<div class="container mt-5">
    <div class="shadow p-3 mb-5 bg-white rounded">
        <div class="row">
            <div class="col-12">
                <h1 class="text-center rounded">Accounting</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <h3 class="mt-3 rounded">Years</h3>
                <ul class="list-group" id="yearList">
                    <c:forEach varStatus="loop" items="${monthList.monthList}" var="date">
                        <li class="list-group-item year-item font-italic" data-toggle="collapse"
                            href="#months${loop.index}">${date.year}</li>
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

        <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
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
                                <%--                            <div id="createTitle">This is some sample content.</div>--%>
                                <%--                            <script>--%>
                                <%--                                ClassicEditor--%>
                                <%--                                    .create(document.querySelector('#createTitle'))--%>
                                <%--                                    .then(editor => {--%>
                                <%--                                        console.log(editor);--%>
                                <%--                                    })--%>
                                <%--                                    .catch(error => {--%>
                                <%--                                        console.error(error);--%>
                                <%--                                    });--%>
                                <%--                            </script>--%>
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
                                <input type="text" class="form-control" id="amount" step="1" required pattern="[0-9]+">
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
                            <div class="form-group">
                                <label for="createNote">Note</label>
                                <input type="text" class="form-control" id="createNote" required>
                            </div>

                            <div class="form-group">
                                <label for="createBill">Bill</label>
                                <input type="file" class="form-control" id="createBill" multiple>
                                <span class="text-secondary" id="validFileText">*File must be , file not over ${setting.maxFileSize} and below ${setting.uploadFileLimit} files</span>
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

        <!-- Modal Error-->
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
    </div>
</div>

<script>
    var validFileUpload = "${setting.listTypeFile}" + "," + "${setting.listTypeImage}";
    var validExtensions = validFileUpload.split(',');
    var spanElement = $("#createModal #validFileText");
    spanElement.text("*File must be " + validFileUpload +", file not over " + "${setting.maxFileSize}" + " and below "+ "${setting.uploadFileLimit}" + " files");

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

    $(document).on("change", "#createBill", function (event) {
        const billFiles = event.target.files;
        var countFile = billFiles.length;
        var countCurrentFile = $("li.listFilesEdit").length;
        if ((countFile + countCurrentFile) >${setting.uploadFileLimit}) {
            var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum Files is ${setting.uploadFileLimit}.
                        `
            $("#successModal div.modal-body").html(modal)
            $("#successModal").modal("show");
            $(this).val('')
        }
        for (var i = 0; i < billFiles.length; i++) {
            var fileName = billFiles[i].name;
            var fileExtension = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2);
            if (!validExtensions.includes(fileExtension) || billFiles[i].size > convertMaxFileSize("${setting.maxFileSize}")) {
                alert("File must " +  validFileUpload + " and not over 100MB.");
                loading.style.display = "none";
                $(this).val('')
                return;
            }
        }
        if ((countFile + countCurrentFile) >${setting.uploadFileLimit}) {
            var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum Files is ${setting.uploadFileLimit}.
                        `
            $("#successModal div.modal-body").html(modal)
            $("#successModal").modal("show");
            $(this).val('')
        }
    });

    function convertMaxFileSize(string) {
        var maxFileSizeWithoutMB = string.replace("MB", "");
        return parseFloat(maxFileSizeWithoutMB)*1024*1024;
    }

    function redirectToAccounting(month) {
        const trimmedMonth = month.replace(/\s/g, '');
        window.location.href = '/accounting/' + trimmedMonth;
    }

    function sendCreateForm() {
        var loading = document.getElementById("loading");
        loading.style.display = "block";
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

        for (var i = 0; i < billFiles.length; i++) {
            var fileName = billFiles[i].name;
            var fileExtension = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2);
            if (!validExtensions.includes(fileExtension) || billFiles[i].size > convertMaxFileSize("${setting.maxFileSize}")) {
                alert(`File must ${setting.listTypeFile} and not over ${setting.maxFileSize}.`);
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
                        beforeSend: function( xhr ) {
                            xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
                        }
                    })
                        .done(function(data) {
                            var responseData = JSON.parse(data);
                            $('#yearList').html('');
                            $.each(responseData.monthList, function(index, date) {
                                var yearItem = $('<li/>').addClass('list-group-item year-item').attr('data-toggle', 'collapse').attr('href', '#months' + index).text(date.year);
                                $('#yearList').append(yearItem);

                                var monthsContainer = $('<div/>').addClass('collapse').attr('id', 'months' + index);
                                var monthList = $('<ul/>').addClass('list-group');

                                $.each(date.month, function(index, month) {
                                    var monthItem = $('<li/>').addClass('list-group-item').text(month).on('click', function() {
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
<div id="loading" class="loading-spin">Loading...</div>
</body>
</html>
