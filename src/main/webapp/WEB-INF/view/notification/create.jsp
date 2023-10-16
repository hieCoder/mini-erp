<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 9/25/2023
  Time: 11:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<html>
<head>
    <title>Create Notification Form</title>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
            <div class="card-header font-weight-bold">
                Notification Create
            </div>
                <div class="card-body">
                    <form id="createForm">
                        <div id="errorAlert" class="alert alert-danger" style="display: none;" >
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
                            <label for="author" class="form-label">Author</label>
                            <input type="text" class="form-control" id="author" name="author">
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
                                    <td class="text-center col-3">${maxFileSize}</td>
                                    <td class="text-center col-3">${uploadFileLimit}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <button type="button" class="btn btn-primary" id="submitButton">Submit</button>
                        <button type="button" class="btn btn-secondary" id="cancelButton">Cancel</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="createNotificationModal" tabindex="-1" role="dialog" aria-labelledby="createNotificationModal" aria-hidden="true" data-backdrop="static">
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

<style>
    #createNotificationModal div.modal-content{
        margin-top: 50%;
    }
</style>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var dot = `
            <div class="text-center d-flex align-items-center justify-content-center">
                <div class="custom-spinner d-flex align-items-center justify-content-center">
                    <div class="dot"></div>
                </div>
            </div>
        `
        var submitButton = document.getElementById("submitButton")
        submitButton.addEventListener("click", function() {
            $("#submitButton").prop("disabled", true);
            $("#cancelButton").prop("disabled", true);
            $("#createForm").append(dot)
            document.getElementById("errorAlert").style.display = "none";
            var title = document.getElementById("title").value;
        var content = document.getElementById("content").value;
        var author = document.getElementById("author").value;
        var files = document.getElementById("file").files;
        var formData = new FormData();
        formData.append("title", title);
        formData.append("content", content);
        formData.append("author", author);
        for (var i = 0; i < files.length; i++) {
            formData.append("files", files[i]);
        }
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${apiURL}${pathMain}", true);
        xhr.send(formData);
        xhr.onreadystatechange = function() {
            if (xhr.status === 200 && xhr.readyState === 4) {
                $("#createNotificationModal").modal("show");
            } else {
                if(xhr.response){
                    document.getElementById("errorAlert").style.display = "block";
                    document.getElementById("errorAlert").innerHTML = JSON.parse(xhr.response).message
                    submitButton.disabled = false;
                }
            }
            $("#submitButton").prop("disabled", false);
            $("#cancelButton").prop("disabled", false);
            $('div.custom-spinner').parent().remove()
        };
    });

    document.getElementById("cancelButton").addEventListener("click", function() {
        window.location = "${pathMain}";
    });
    })
</script>
</body>
</html>
