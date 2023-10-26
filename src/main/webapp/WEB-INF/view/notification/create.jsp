<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<html>
<head>
    <title>Create Notification Form</title>
    <link rel="stylesheet" href="/assets/css/notification/style.css">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header font-weight-bold">
                    Create Notification Form
                </div>
                <div class="card-body">
                    <div id="createForm">
                        <div id="errorAlert" class="alert alert-danger" style="display: none;">
                        </div>
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" id="title" name="title">
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">Content</label>
                            <textarea class="form-control" id="content" name="content" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="file" class="form-label">Attached files</label>
                            <input type="file" class="form-control" id="file" name="file" multiple>
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
                        </div>
                        <button type="button" class="btn btn-primary" id="submitButton">Submit</button>
                        <button type="button" class="btn btn-secondary" id="cancelButton">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="createNotificationModal" tabindex="-1" role="dialog"
     aria-labelledby="createNotificationModal" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Notification Created</h5>
            </div>
            <div class="modal-body">
                <p>Your notification has been created.</p>
            </div>
            <div class="modal-footer">
                <a href="${pathMain}" class="btn btn-secondary ml-2">Go to list</a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Message</h5>
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

<script>
    const notFilled = '<span class="text-danger font-weight-bold font-italic small">This field is not filled</span>'
    document.addEventListener("DOMContentLoaded", function () {
        var dot = createLoadingHtml()

        $(document).on("change", "#file", function (event) {
            const selectedFiles = event.target.files;
            var countFile = selectedFiles.length;
            if(countFile>${uploadFileLimit}){
                var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum Files is ${uploadFileLimit}.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $(this).val('')
                return
            }
            let sizeCount = 0

            for (let i = 0; i < countFile; i++) {
                const file = selectedFiles[i];
                const fileSizeMb = (file.size / (1024 * 1024)).toFixed(0)
                const fileExtension = file.name.split('.').pop();
                const allowedExtensions = "${listTypeFile}".split(',');
                sizeCount += parseInt(fileSizeMb)
                if (!allowedExtensions.includes(fileExtension)) {
                    var modal =
                '<strong class="btn-danger rounded-circle p-2">Invalid!</strong> File type allowed: ${listTypeFile}.'
                    $("#successModal div.modal-body").html(modal);
                    $("#successModal").modal("show");
                    $(this).val('');
                    return;
                }
            }

            if(sizeCount > ${maxFileSize}){
                    var modal =
                '<strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum size allowed: ${maxFileSize} MB.'
                    $("#successModal div.modal-body").html(modal);
                    $("#successModal").modal("show");
                    $(this).val('');
                    return;
            }

        });

        var submitButton = document.getElementById("submitButton")
        submitButton.addEventListener("click", function () {
            $("span.text-danger").remove()
            document.getElementById("errorAlert").style.display = "none";
            var title = document.getElementById("title").value;
            var content = document.getElementById("content").value;
            var files = document.getElementById("file").files;
            var formData = new FormData();
            formData.append("title", title);
            formData.append("content", content);
            formData.append("userId", userCurrent.id);
            for (var i = 0; i < files.length; i++) {
                formData.append("files", files[i]);
            }
            if (title.trim() === "") {
                $("input#title").after(notFilled)
                return false;
            }
            if (content.trim() === "") {
                $("textarea#content").after(notFilled)
                return false;
            }

            $("#submitButton").prop("disabled", true);
            $("#cancelButton").prop("disabled", true);
            $("#createForm").append(dot)
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${apiURL}${pathMain}", true);
            xhr.send(formData);
            xhr.onreadystatechange = function () {
                if (xhr.status === 200 && xhr.readyState === 4) {
                    $("#createNotificationModal").modal("show");
                } else {
                    if (xhr.response) {
                        document.getElementById("errorAlert").style.display = "block";
                        document.getElementById("errorAlert").innerHTML = "Failed to create notification"
                        submitButton.disabled = false;
                    }
                }
                $("#submitButton").prop("disabled", false);
                $("#cancelButton").prop("disabled", false);
                $('div.custom-spinner').parent().remove()
            };
        });

        document.getElementById("cancelButton").addEventListener("click", function () {
            window.location = "${pathMain}";
        });
    });
</script>
</body>
</html>
