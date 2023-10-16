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
                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <p id="title">Title Value</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">Content</label>
                    <p id="content">Content Value</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">Author</label>
                    <p id="author">Author Value</p>
                </div>
                <div class="mb-3">
                    <label class="form-label">Attached files</label>
                    <!-- Thêm hiển thị các tệp đã chọn (nếu có) -->
                </div>
            </form>
            <div class="mb-3">
                <label class="form-label">Comments</label>
                <ul id="commentList" class="list-group">
                    <!-- Comment cha -->
                    <li class="list-group-item">
                        <div class="comment-header">
                            <img src="path_to_avatar_image1.jpg" alt="Avatar 1" class="avatar">
                            <p class="user-name">User Comment 1 (Comment Cha)</p>
                            <button class="btn btn-primary btn-sm edit-button">Edit</button>
                            <button class="btn btn-success btn-sm reply-button">Reply</button>
                        </div>
                        <!-- Danh sách comment con (lồng nhau) -->
                        <ul class="list-group">
                            <li class="list-group-item">
                                <div class="comment-header">
                                    <img src="path_to_avatar_image1.1.jpg" alt="Avatar 1.1" class="avatar">
                                    <p class="user-name">User Comment 1.1 (Comment Con)</p>
                                    <button class="btn btn-primary btn-sm edit-button">Edit</button>
                                </div>
                            </li>
                            <li class="list-group-item">
                                <div class="comment-header">
                                    <img src="path_to_avatar_image1.2.jpg" alt="Avatar 1.2" class="avatar">
                                    <p class="user-name">User Comment 1.2 (Comment Con)</p>
                                    <button class="btn btn-primary btn-sm edit-button">Edit</button>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <!-- Comment cha khác -->
                    <li class="list-group-item">
                        <div class="comment-header">
                            <img src="path_to_avatar_image2.jpg" alt="Avatar 2" class="avatar">
                            <p class="user-name">User Comment 2 (Comment Cha)</p>
                            <button class="btn btn-primary btn-sm edit-button">Edit</button>
                            <button class="btn btn-success btn-sm reply-button">Reply</button>
                        </div>
                    </li>
                    <!-- Thêm các comment cha và comment con khác tại đây -->
                </ul>
                <div class="comment-input">
                    <textarea id="newComment" class="form-control" placeholder="Add a comment..."></textarea>
                    <button class="btn btn-primary submit-button">Submit</button>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {

    })
</script>
</body>
</html>
