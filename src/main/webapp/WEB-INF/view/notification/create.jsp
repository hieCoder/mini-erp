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
                </div>
                <button type="button" class="btn btn-primary" id="submitButton">Submit</button>
                <button type="button" class="btn btn-secondary" id="cancelButton">Cancel</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var submitButton = document.getElementById("submitButton")
        submitButton.addEventListener("click", function() {
            submitButton.disabled = true;
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
            if (xhr.status === 200) {
                window.location = "${pathMain}";
            } else {
                if(xhr.response){
                    document.getElementById("errorAlert").style.display = "block";
                    document.getElementById("errorAlert").innerHTML = JSON.parse(xhr.response).message
                    submitButton.disabled = false;
                }
            }
        };
    });

    document.getElementById("cancelButton").addEventListener("click", function() {
        window.location = "${pathMain}";
    });
    })
</script>
</body>
</html>
