<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page import="com.shsoftvina.erpshsoftvina.enums.user.RoleEnum" %>
<%@ page import="com.shsoftvina.erpshsoftvina.enums.Notification.StatusNotificationEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>

<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<html>
<head>
    <title>Notification Detail</title>
    <!-- Plugins css -->
    <link href="/assets/libs/dropzone/dropzone.css" rel="stylesheet" type="text/css">
    <!-- quill css -->
    <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
    <!-- bubble css for bubble editor-->
    <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
    <!-- snow css for snow editor-->
    <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />
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

        #viewNotification .ql-bubble{
            border: none
        }

        .ql-editor p:has(> img) {
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
        }
    </style>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title mb-0">Notification Detail</h4>
            </div><!-- end card header -->
                <div id="viewNotification" class="card-body" data-id="${notification.id}">
                            <div class="text-muted">
                                <h5 class="mb-3 fw-semibold text-uppercase titleView">
                                    <strong class="fw-bolder fst-italic fs-4">${notification.title}</strong>
                                </h5>
                            </div>
                            <div class="text-muted">
                                <div id="contentView">

                                </div>
                                <div class="pt-3 border-top border-top-dashed mt-4">
                                    <div class="row">

                                        <div class="col-lg-3 col-sm-6">
                                            <div>
                                                <p class="mb-2 text-uppercase fw-medium">Create Date :</p>
                                                <h5 class="fs-15 mb-0 createdDate">${notification.createdDate}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="pt-3 border-top border-top-dashed mt-4">
                                    <h6 class="mb-3 fw-semibold text-uppercase">Files Uploaded</h6>
                                    <div class="row g-3 showFilesUploaded">
                                    </div>
                                    <!-- end row -->
                                </div>
                    </div>
                    <div class="d-flex gap-2 justify-content-end mt-2" data-id="${notification.id}">
                        <c:if test="${(userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)) && notification.status.equals(StatusNotificationEnum.ACTIVE)}">
                            <div class="editNotification">
                                <button class="btn btn-sm btn-success editNotification">Edit</button>
                            </div>
                            <div class="removeNotification">
                                <button class="btn btn-sm btn-danger removeNotification">Remove</button>
                            </div>
                        </c:if>
                        <c:if test="${notification.status.equals(StatusNotificationEnum.INACTIVE)}">
                            <div class="notificationDeleted">
                                <button class="btn btn-sm btn-danger remove-item-btn notificationDeleted">Deleted</button>
                            </div>
                        </c:if>
                        <div class="backToList">
                            <button class="btn btn-sm btn-dark backToList">Back to list</button>
                        </div>
                    </div>
                </div>
            <div class="card">
                <div class="card-header align-items-center d-flex">
                    <h4 class="card-title mb-0 flex-grow-1">Comments</h4>
<%--                    <div class="flex-shrink-0">--%>
<%--                        <div class="dropdown card-header-dropdown">--%>
<%--                            <a class="text-reset dropdown-btn" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
<%--                                <span class="text-muted">Recent<i class="mdi mdi-chevron-down ms-1"></i></span>--%>
<%--                            </a>--%>
<%--                            <div class="dropdown-menu dropdown-menu-end">--%>
<%--                                <a class="dropdown-item" href="#">Recent</a>--%>
<%--                                <a class="dropdown-item" href="#">Top Rated</a>--%>
<%--                                <a class="dropdown-item" href="#">Previous</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </div><!-- end card header -->
                <div class="card-body">
                    <div data-simplebar="init" style="max-height: 500px;" class="px-3 mx-n3 mb-2">
                        <div class="simplebar-wrapper" style="margin: 0px -16px;">
                            <div class="simplebar-height-auto-observer-wrapper">
                                <div class="simplebar-height-auto-observer"></div>
                            </div>
                            <div class="simplebar-mask">
                                <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                    <div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: 100%; overflow: hidden scroll;">
                                        <div class="simplebar-content" style="padding: 0px 16px;">
                                            <div class="d-flex mb-4">
                                            <div class="flex-shrink-0">
                                                <img src="/assets/images/users/avatar-8.jpg" alt="" class="avatar-xs rounded-circle">
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h5 class="fs-13">Joseph Parker <small class="text-muted ms-2">20 Dec 2021 - 05:47AM</small></h5>
                                                <p class="text-muted">I am getting message from customers that when they place order always get error message .</p>
                                                <a href="javascript: void(0);" class="badge text-muted bg-light"><i class="mdi mdi-reply"></i> Reply</a>
                                                <div class="d-flex mt-4">
                                                    <div class="flex-shrink-0">
                                                        <img src="/assets/images/users/avatar-10.jpg" alt="" class="avatar-xs rounded-circle">
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <h5 class="fs-13">Alexis Clarke <small class="text-muted ms-2">22 Dec 2021 - 02:32PM</small></h5>
                                                        <p class="text-muted">Please be sure to check your Spam mailbox to see if your email filters have identified the email from Dell as spam.</p>
                                                        <a href="javascript: void(0);" class="badge text-muted bg-light"><i class="mdi mdi-reply"></i> Reply</a>
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <img src="/assets/images/users/avatar-6.jpg" alt="" class="avatar-xs rounded-circle">
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fs-13">Donald Palmer <small class="text-muted ms-2">24 Dec 2021 - 05:20PM</small></h5>
                                <p class="text-muted">If you have further questions, please contact Customer Support from the “Action Menu” on your <a href="javascript:void(0);" class="text-decoration-underline">Online Order Support</a>.</p>
                                <a href="javascript: void(0);" class="badge text-muted bg-light"><i class="mdi mdi-reply"></i> Reply</a>
                            </div>
                        </div>
                                            <div class="d-flex">
                            <div class="flex-shrink-0">
                                <img src="/assets/images/users/avatar-10.jpg" alt="" class="avatar-xs rounded-circle">
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5 class="fs-13">Alexis Clarke <small class="text-muted ms-2">26 min ago</small></h5>
                                <p class="text-muted">Your <a href="javascript:void(0)" class="text-decoration-underline">Online Order Support</a> provides you with the most current status of your order. To help manage your order refer to the “Action Menu” to initiate return, contact Customer Support and more.</p>
                                <div class="row g-2 mb-3">
                                    <div class="col-lg-1 col-sm-2 col-6">
                                        <img src="/assets/images/small/img-4.jpg" alt="" class="img-fluid rounded">
                                    </div>
                                    <div class="col-lg-1 col-sm-2 col-6">
                                        <img src="/assets/images/small/img-5.jpg" alt="" class="img-fluid rounded">
                                    </div>
                                </div>
                                <a href="javascript: void(0);" class="badge text-muted bg-light"><i class="mdi mdi-reply"></i> Reply</a>
                                <div class="d-flex mt-4">
                                    <div class="flex-shrink-0">
                                        <img src="/assets/images/users/avatar-6.jpg" alt="" class="avatar-xs rounded-circle">
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h5 class="fs-13">Donald Palmer <small class="text-muted ms-2">8 sec ago</small></h5>
                                        <p class="text-muted">Other shipping methods are available at checkout if you want your purchase delivered faster.</p>
                                        <a href="javascript: void(0);" class="badge text-muted bg-light"><i class="mdi mdi-reply"></i> Reply</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="simplebar-placeholder" style="width: auto; height: 598px;"></div>
                    </div><div class="simplebar-track simplebar-horizontal" style="visibility: hidden;"><div class="simplebar-scrollbar" style="width: 0px; display: none;"></div></div><div class="simplebar-track simplebar-vertical" style="visibility: visible;"><div class="simplebar-scrollbar" style="height: 150px; transform: translate3d(0px, 0px, 0px); display: block;"></div></div></div>
                    <div class="mt-4">
                        <div class="row g-3">
                            <div class="col-12">
                                <label for="newCommentContent" class="form-label text-body">Leave a Comments</label>
                                <textarea class="form-control bg-light border-light" id="newCommentContent" rows="3" placeholder="Enter your comment..."></textarea>
                            </div>
                            <div class="col-12 text-end">
<%--                                <button type="button" class="btn btn-ghost-secondary btn-icon waves-effect me-1"><i class="ri-attachment-line fs-16"></i></button>--%>
                                <button class="btn btn-success" id="newCommentBtn">Post Comments</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end card body -->
            </div>

            <div class="containerComment d-none">
            <div class="mb-3 mt-2">
                <div class="row mb-4 mt-4">
                    <div class="col-md-10 d-flex">
                        <img id="avatar-user-login" alt="Avatar" class="avatar rounded-circle img-thumbnail mr-4">
                        <textarea id="newComment" class="form-control" placeholder="Add a comment..."
                                  style="min-height: 90px;"></textarea>
                    </div>
                    <div class="col-md-2">
<%--                        <button class="btn btn-primary submit-button mt-2 mb-2 w-100" id="newCommentBtn">Submit</button>--%>
                    </div>
                </div>

                <ul id="commentList" class="list-group">
                    <c:forEach items="${notification.comments}" var="comment">
                        <li class="list-group-item" data-id="${comment.id}">
                            <div class="comment-header d-flex align-items-center">
                                <img src="${comment.avatarUser}" alt="Avatar"
                                     class="avatar rounded-circle img-thumbnail">
                                <div class="user-info">
                                    <p class="user-name">${comment.fullnameUser}</p>
                                    <p class="comment-date">${comment.createdDate}</p>
                                </div>
                            </div>
                            <p class="comment-content" data-id="${comment.id}">${comment.content}</p>
                            <div class="ml-auto">
                                <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER) || comment.userId.equals(userId)}">
                                    <button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal"
                                            data-target="#popupForm" data-id="${comment.id}">Edit
                                    </button>
                                    <button type="button" class="btn btn-sm btn-danger" data-toggle="modal"
                                            data-id="${comment.id}" data-target="#deleteConfirmationModal">Delete
                                    </button>
                                </c:if>
                                <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">

                                    <button class="btn btn-success btn-sm reply-button" data-id="${comment.id}">Reply
                                </button>

                                </c:if>

                            </div>
                            <ul id="commentChildList-${comment.id}" class="list-group mt-2 ml-4">
                                <c:if test="${not empty comment.childComments}">
                                    <c:forEach items="${comment.childComments}" var="childComment">
                                        <li class="list-group-item" data-id="${childComment.id}">
                                            <div class="comment-header d-flex align-items-center">
                                                <img src="${childComment.avatarUser}" alt="Avatar"
                                                     class="avatar rounded-circle img-thumbnail">
                                                <div class="user-info">
                                                    <p class="user-name">${childComment.fullnameUser}</p>
                                                    <p class="comment-date">${childComment.createdDate}</p>
                                                </div>
                                            </div>
                                            <p class="comment-content"
                                               data-id="${childComment.id}">${childComment.content}</p>
                                            <div class="ml-auto">
                                                <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER) || childComment.userId.equals(userId)}">
                                                    <button class="btn btn-primary btn-sm edit-button"
                                                            data-id="${childComment.id}">Edit
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-danger"
                                                            data-id="${childComment.id}" data-toggle="modal"
                                                            data-target="#deleteConfirmationModal">Delete
                                                    </button>
                                                </c:if>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                        </li>
                    </c:forEach>
                </ul>

            </div>
        </div>
        </div>

    </div>
</div>
<div class="modal fade" id="popupForm" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="popupFormLabel">Edit Comment</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="contentCommentEdit">Content</label>
                        <textarea class="form-control" id="contentCommentEdit" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" id="saveChangesButton" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="popupFormEditNotification" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="popupFormEditNotificationLabel">Edit Notification</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" id="saveChangesButtonNotification" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel"
     aria-hidden="true">
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

<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog"
     aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this comment?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmationModalFile" tabindex="-1" role="dialog"
     aria-labelledby="deleteConfirmationModalFile" aria-hidden="true">
    <div class="modal-dialog" role="document">
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
<div class="modal fade zoomIn" id="deleteNotification" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Are you Sure?</h4>
                        <p class="text-muted mx-4 mb-0">
                            Are you Sure You want to Remove this Notification?
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn w-sm btn-danger " id="deleteNotificationButton">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade zoomIn" id="deleteSuccessNotification" data-bs-backdrop="static" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                    <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                        <h4>Inform</h4>
                        <p class="text-muted mx-4 mb-0">
                            This notification has been deleted.
                        </p>
                    </div>
                </div>
                <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                    <button type="button" class="btn w-sm btn-light backToList" data-bs-dismiss="modal">Back To List</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="successComment" class="modal fade" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <div class="text-end">
                    <button type="button" class="btn-close text-end" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="mt-2">
                    <lord-icon src="https://cdn.lordicon.com/tqywkdcz.json" trigger="hover" style="width:150px;height:150px"></lord-icon>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div id="formEditNotication" data-bs-keyboard="false" data-bs-backdrop="static" class="modal fade zoomIn bs-example-modal-xl" tabindex="-1" aria-labelledby="myExtraLargeModalLabel" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Edit Notification Form</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- start page title -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="form-label" for="titleEdit">Notification Title</label>
                                    <input type="text" class="form-control" id="titleEdit" placeholder="Input Title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Notification Content</label>
                                    <div class="snow-editor" id="contentEdit">

                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="pt-3 border-top border-top-dashed mt-4">
                                        <h6 class="mb-3 fw-semibold text-uppercase">Files Uploaded</h6>
                                        <div class="row g-3 showFilesUploaded">

                                        </div>
                                        <!-- end row -->
                                    </div>
                                </div>
                            </div>
                            <!-- end card body -->
                        </div>
                        <!-- end card -->

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
            <div class="modal-footer">
                <a href="javascript:void(0);" class="btn btn-link link-success fw-medium" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</a>
                <button type="button" class="btn btn-primary editBtn">Update</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<div class="modal fade zoomIn" id="deleteFileModal" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mt-2 text-center">
                    <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
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

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>
<script src="/assets/js/notification/notification.js"></script>
<script>

    function generateClientID() {
        const timestamp = new Date().getTime();
        const random = Math.floor(Math.random() * 1000);
        return 'client-' + timestamp + '-' + random
    }
    function refreshPage() {
        location.reload();
    }
    const clientID = generateClientID();
    var stompClient = Stomp.over(new SockJS("/websocket"));

    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/notification/deleteNotification", function (notification) {
            let id = notification.body;
            let notiCheck = 'div#viewNotification[data-id="'+id+'"]'
            let notificationElement = $(notiCheck)
            if(notificationElement.length>0){
                $("#deleteSuccessNotification").modal("show");
                setTimeout(backToList, 5000);
            }
        })
        stompClient.subscribe("/notification/comments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data.id != null) {
                if ($('li.list-group-item[data-id="' + data.id + '"]').length <= 0) {
                    var buttonHtml = ""
                    if (userCurrent.id == data.userId || ${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}) {
                        buttonHtml =
                            '<button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="' + data.id + '">Edit</button>' +
                            '<button type="button" class="btn btn-sm btn-danger ml-1" data-toggle="modal" data-id="' + data.id + '" data-target="#deleteConfirmationModal">Delete</button>'
                    }
                    var buttonReply=""

                    if (${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}) {
                        buttonReply =  '<button class="btn btn-success btn-sm reply-button ml-1" data-id="' + data.id + '">Reply</button>'
                    }

                    $("textarea#newComment").val('');
                    var html = '<li class="list-group-item" data-id="' + data.id + '">' +
                        '<div class="comment-header d-flex align-items-center">' +
                        '<img src="' + data.avatarUser + '" alt="Avatar" class="avatar rounded-circle img-thumbnail">' +
                        '<div class="user-info">' +
                        '<p class="user-name">' + data.fullnameUser + '</p>' +
                        '<p class="comment-date">' + data.createdDate + '</p>' +
                        '</div>' +
                        '</div>' +
                        '<p class="comment-content" data-id="' + data.id + '">' + data.content + '</p>' +
                        '<div class="ml-auto">' + buttonHtml + buttonReply +
                        '</div>' +
                        '<ul id="commentChildList-' + data.id + '" class="list-group mt-2 ml-4">' +
                        '</li>';

                    if ($("ul#commentList li.list-group-item:first").length > 0) {
                        $("ul#commentList li.list-group-item:first").before(html);
                    } else {
                        $("ul#commentList").html(html);
                    }
                    if (data.clientId == clientID) {
                        var modal = `<strong class="btn-success rounded-circle p-2">Success!</strong>  Comment posted successfully.
                            `
                        $("#successComment div.modal-body").append(modal)
                        $("#successComment").modal("show");
                        $("button#newCommentBtn").prop("disabled", false);
                        $("textarea#newComment").prop("disabled", false);
                    }
                }
            }else if(data.clientId == clientID){
                refreshPage()
            }
        });
        stompClient.subscribe("/notification/editcomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data.id != null) {
                var $pElement = $('p.comment-content[data-id="' + data.id + '"]');
                $pElement.text(data.content)
                if (data.clientId == clientID) {
                    $("#popupForm").modal("hide");
                    var modal = `
                               <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment update successfully.
                                `
                    $("#successModal div.modal-body").html(modal)
                    $("#successModal").modal("show");
                    $(".modal-footer button").each(function () {
                        $(this).prop("disabled", false);
                    });
                    $('div.custom-spinner').parent().remove()
                }
            }else if(data.clientId == clientID){
                refreshPage()
            }
        });
        stompClient.subscribe("/notification/deletecomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data.id != null) {
                $('li.list-group-item[data-id="' + data.id + '"]').remove()
                if (data.clientId == clientID) {
                    var modal = `
                <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment delete successfully.
                `
                    $("#successModal div.modal-body").html(modal)
                    $("#popupForm").modal("hide");
                    $("#successModal").modal("show");
                    $(".modal-footer button").each(function () {
                        $(this).prop("disabled", false);
                    });
                    $('div.custom-spinner').parent().remove()
                }
            }else if(data.clientId == clientID){
                refreshPage()
            }
        });
        stompClient.subscribe("/notification/replycomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data.id != null) {
                var buttonHtml = ""
                if (userCurrent.id == data.userId || ${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}) {
                    buttonHtml =
                        '<button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="' + data.id + '">Edit</button>' +
                        '<button type="button" class="btn btn-sm btn-danger ml-1" data-toggle="modal" data-id="' + data.id + '" data-target="#deleteConfirmationModal">Delete</button>'
                }
                var html = '<li class="list-group-item" data-id="' + data.id + '">' +
                    '<div class="comment-header d-flex align-items-center">' +
                    '<img src="' + data.avatarUser + '" alt="Avatar" class="avatar rounded-circle img-thumbnail">' +
                    '<div class="user-info">' +
                    '<p class="user-name">' + data.fullnameUser + '</p>' +
                    '<p class="comment-date">' + data.createdDate + '</p>' +
                    '</div>' +
                    '</div>' +
                    '<p class="comment-content" data-id="' + data.id + '">' + data.content + '</p>' +
                    '<div class="ml-auto">' + buttonHtml +
                    '</div>' +
                    '<ul id="commentChildList-' + data.id + '" class="list-group mt-2 ml-4">' +
                    '</li>'
                var inputReply = $('#commentList #commentChildList-' + data.parentId + ' > div.row')
                var listChild = $('#commentList #commentChildList-' + data.parentId + ' > li.list-group-item:first')
                if (inputReply.length > 0) {
                    inputReply.after(html)
                } else if (listChild.length > 0) {
                    listChild.before(html)
                } else {
                    $('#commentList #commentChildList-' + data.parentId).html(html)
                }
                if (data.clientId == clientID) {
                    var modal = `
                                <strong class="btn-success rounded-circle p-2">Success!</strong>  Reply successfully.
                                `
                    $('textarea#replyComment[data-id=' + data.parentId + ']').val('');
                    $("#successModal div.modal-body").html(modal)
                    $("#successComment").modal("show");

                }
            }else if(data.clientId == clientID){
                refreshPage()
            }
        });
        $("div.containerComment").removeClass("d-none")
        $('div.custom-spinner').parent().remove()
    });

    function sendComment(data) {
        stompClient.send("/app/comment", {
            clientID: clientID
        }, data)
    }

    function editComment(data) {
        stompClient.send("/app/editcomment", {
            clientID: clientID
        }, data);
    }

    function deleteComment(data) {
        stompClient.send("/app/deletecomment", {
            clientID: clientID
        }, data);
    }

    function replyComment(data) {
        stompClient.send("/app/replycomment", {
            clientID: clientID
        }, data);
    }
</script>
<script>
    const INVALID_FILLED=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> This field is not filled'+
        '</div>'
    const INVALID_FILES_LIMIT=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> Maximum Files is ${uploadFileLimit}'+
        '</div>'

    const INVALID_FILES_TYPE=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> File type allowed: ${listTypeFile}'+
        '</div>'

    const INVALID_FILES_SIZE=' <div class="alert alert-danger" role="alert">'+
        '<strong> Invalid </strong> Maximum Size Files is ${maxFileSize}'+
        '</div>'

    let listTypeFileArr = "${listTypeFile}".split(",")
    let listTypeFile = ""
    listTypeFileArr.forEach((item, index)=>{
        listTypeFile += "." + item
        if(index<listTypeFileArr.length){
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
        previewTemplate: previewTemplateEdit,
        previewsContainer: "#dropzone-preview-edit",
        acceptedFiles: listTypeFile,
        maxFilesize: parseInt(maxFileSize),
        maxFiles: parseInt(uploadFileLimit) ,
        uploadMultiple:true,
        autoProcessQueue: false,
    });

    dropzoneEdit.on("addedfile", function (file) {
        removeAlert();
        let files = dropzoneEdit.files
        const fileExtension = file.name.split('.').pop();
        const fileSize = file.size
        if(!checkLimitFile(files.length, parseInt(dropzoneEdit.options.maxFiles))){
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_LIMIT)
            return
        }
        if(!checkTypeFile(fileExtension, listTypeFileArr)){
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_TYPE)
            return
        }
        if(!checkLimitSize(bytesToMB(fileSize),parseInt(maxFileSize))){
            dropzoneEdit.removeFile(file)
            showAlertValidate(INVALID_FILES_SIZE)
            return
        }
    });

    var quillView = new Quill("#contentView",{
        theme: 'bubble', // Specify theme in configuration
        readOnly: true,  // Set the editor to read-only mode
    });

    var quillEdit = new Quill("#contentEdit", snowEditorData);

    document.addEventListener("DOMContentLoaded", function () {
        let checkDeleted = $("button.notificationDeleted")
        if(checkDeleted.length>0){
            $("button").each(function (index,item){
                if(index > 0){
                    $(item).prop("disabled", true)
                    $("textarea").prop("disabled", true)
                }
            })
        }
        $(document).on("click","button#deleteFileBtn",function (){
            let fileName = $("#deleteFileModal").attr("data-name")
            $('#formEditNotication div.showFilesUploaded > div[data-name="' + fileName + '"]').remove();
            $("#deleteFileModal").modal("hide")
            dropzoneEdit.options.maxFiles = dropzoneEdit.options.maxFiles + 1;
        })

        $(document).on("click","button.editBtn", function(){
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
            $("#formEditNotication div.showFilesUploaded > div").each(function () {
                oldFile.push($(this).attr("data-name"));
            });
            var formData = new FormData();
            formData.append("title", title);
            formData.append("content", content);
            formData.append("oldFile", oldFile);
            if(dropzoneEdit.files.length>0) {
                for (let i = 0; i < dropzoneEdit.files.length; i++) {
                    let file = dropzoneEdit.files[i]
                    if(file.accepted){
                        formData.append("files", file);
                    }
                }
            }
            callAjaxByDataFormWithDataForm2("${apiURL}${pathMain}update/" + notificationId,"POST", formData ,function (rs){
                console.log(rs)
                if(rs){
                    $("h5.titleView strong").text(rs.title)
                    let contentParse = JSON.parse(rs.content)
                    quillView.setContents(contentParse)
                    loadFilesName(rs.files);
                    $("#formEditNotication").modal("hide")
                }
            },function (error){
                console.log(error)
            })

        })

        $(document).on("click","button.editNotification",function (){
            Dropzone.forElement('#dropzoneEdit').removeAllFiles(true)
            let notificationId = $(this).parent().parent().attr("data-id")
            let apiUrlNotification = baseUrlNotification
            if(notificationId){
                callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null,
                    function (rs) {
                        $("#formEditNotication").attr("data-id", rs.id)
                        $("#titleEdit").val(rs.title)
                        let contentParse = JSON.parse(rs.content)
                        quillEdit.setContents(contentParse)
                        let urlFiles = rs.files ? rs.files : []
                        let fileLength = rs.files ? rs.files.length : 0
                        dropzoneEdit.options.maxFiles = parseInt(uploadFileLimit) - fileLength;
                        let html=""
                        if(fileLength>0){
                            urlFiles.forEach(function (url) {
                                $.ajax({
                                    type: "HEAD",
                                    url: url,
                                    success: function (data, status, xhr) {
                                        var contentLength = xhr.getResponseHeader('Content-Length');
                                        var fileName = url.substring(url.lastIndexOf("/") + 1);
                                        html+= showFileUploaded(fileName, contentLength, url, "edit")
                                        $("#formEditNotication .showFilesUploaded").html(html)
                                        $("#formEditNotication").modal("show")
                                    }
                                });
                            });
                        }else{
                            $("#formEditNotication").modal("show")
                        }
                    },
                    function (error){
                        console.log(error)
                    }
                )
            }
        })

        $(document).on("click","button.downFileBtn",function (){
            let dataUrl = $(this).children().attr("data-url")
            downloadFiles(dataUrl)
        })

        let fileNameArr = []
        function loadFilesName(fileNameArr){
            let html =""
            handleFiles(fileNameArr, function handleEachFunc (fileName, fileSize, url) {
                html += showFileUploaded(fileName, fileSize, url, "view")
                $("#viewNotification .showFilesUploaded").html(html)
            })
        }

        <c:forEach items="${notification.files}" var="value" varStatus="loop">
            fileNameArr.push('${value}');
            <c:if test="${loop.index + 1 == fn:length(notification.files)}">
                loadFilesName(fileNameArr);
            </c:if>
        </c:forEach>
        function loadContent(content){
            quillView.setContents(content)
        }
        loadContent(${notification.content})
        $(document).on("click", "#saveChangesButtonNotification", function (e) {
            $("span.text-danger").remove()
            var apiUrlNotification = baseUrlNotification + "/update/"
            var notificationId = $("table#tableNotification").attr("data-id");
            var title = document.getElementById("editNotificationTitle").value;
            var content = document.getElementById("editNotificationContent").value;
            var files = document.getElementById("editNotificationFile").files;
            var oldFile = []
            $("li.listFilesEdit").each(function () {
                oldFile.push($(this).attr("data-name"));
            });

            if (title.trim() === "") {
                $("input#editNotificationTitle").after(notFilled)
                return false;
            }
            if (content.trim() === "") {
                $("textarea#editNotificationContent").after(notFilled)
                return false;
            }
            var formData = new FormData();
            formData.append("title", title);
            formData.append("content", content);
            formData.append("oldFile", oldFile);
            for (var i = 0; i < files.length; i++) {
                formData.append("files", files[i]);
            }
            $("#popupFormEditNotification .modal-footer button").each(function() {
                $(this).prop("disabled", true);
            });
            callAjaxByDataFormWithDataForm2(apiUrlNotification + notificationId, 'POST', formData, function (rs) {
                var data = rs;
                $("#titleNotification").text(data.title)
                $("#contentNotification").text(data.content)
                $("#authorNotification").text(data.title)
                $("#createdDateNotification").text(data.createdDate)
                var xhtml = ''
                if (data.files != null) {
                    data.files.forEach((e) => {
                        xhtml += '<a href="' + e + '" download class="btn btn-link text-primary">' + e.split("-")[1] + '</a>'
                    })
                }
                $("#attachedFilesNotification").html(xhtml)
                var modal = `
                        <strong class="btn-success rounded-circle p-2">Success!</strong>  Notification Updated successfully.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");

                $('div.custom-spinner').parent().remove()
                $("#popupFormEditNotification .modal-footer button").each(function () {
                    $(this).prop("disabled", false);
                });
                $("#popupFormEditNotification").modal("hide");
            }, function () {
                $('div.custom-spinner').parent().remove()
                $("#popupFormEditNotification .modal-footer button").each(function () {
                    $(this).prop("disabled", false);
                });
            });
        });

        $(document).on("click", ".listFilesEdit button", function (e) {
            $("#deleteConfirmationModalFile #deleteFileButton").attr("data-name", $(this).attr("data-name"))
        });
        $(document).on("click", "#deleteFileButton", function (e) {
            $('.listFilesEdit button[data-name="' + $(this).attr("data-name") + '"]').parent().remove()
            $("#deleteConfirmationModalFile").modal("hide");
        });

        $(document).on("click", "#deleteNotificationButton", function (e) {
            var notificationId = $("#deleteNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification;
            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
                $("#deleteNotification").modal("hide");
            });
        });

        $(document).on("click", "#editButtonNotification", function () {
            $(this).prop("disabled", true);
            var notificationId = $("table#tableNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification;

            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null, function (rs) {
                var data = rs;
                var fileList = data.files;
                var fileListHTML = '<ul class="list-group">';
                if (fileList != null) {
                    for (var i = 0; i < fileList.length; i++) {
                        var fileName = fileList[i].trim();
                        fileListHTML += '<li class="list-group-item listFilesEdit" data-name="' + fileName.split("/")[fileName.split("/").length - 1] + '">' +
                            '<a href="' + fileName + '" class="btn btn-link" download>' +
                            fileName.split("-")[1] +
                            '</a>' +
                            '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteConfirmationModalFile" data-name="' + fileName.split("/")[fileName.split("/").length - 1] + '">' +
                            '<span>×</span>' +
                            '</button>' +
                            '</li>';
                    }
                }
                fileListHTML += '<label for="file">Attached Files:</label>'
                    + '<input type="file" id="editNotificationFile" name="files" class="form-control-file" multiple>'
                    + '</ul>'
                    + '<table class="table table-bordered text-center">'
                    + '<thead>'
                    + '<tr>'
                    + ' <th class="text-center col-6">File Format</th>'
                    + ' <th class="text-center col-3">Maximum Size</th>'
                    + ' <th class="text-center col-3">Maximum Files</th>'
                    + '</tr>'
                    + '</thead>'
                    + '<tbody>'
                    + '<tr>'
                    + '<td class="text-center col-6">${listTypeFile}</td>'
                    + '<td class="text-center col-3">${maxFileSize} MB</td>'
                    + '<td class="text-center col-3">${uploadFileLimit}</td>'
                    + '</tr>'
                    + '</tbody>'
                    + ' </table>';
                var xhtml = '<div id="editNotificationForm">'
                    + '<div class="form-group">'
                    + '<label for="title">Title:</label>'
                    + '<input type="text" id="editNotificationTitle" name="title" value="' + data.title + '" class="form-control">'
                    + '</div>'
                    + '<div class="form-group">'
                    + '<label for="content">Content:</label>'
                    + '<textarea id="editNotificationContent" name="content" class="form-control">' + data.content + '</textarea>'
                    + '</div>'
                    + '<div class="form-group">'
                    + fileListHTML
                    + '</div>'
                    + '</div>';
                $("#popupFormEditNotification div.modal-body").html(xhtml)
                $("#popupFormEditNotification").modal("show");

                $('div.custom-spinner').parent().remove()
                $('button#editButtonNotification').prop("disabled", false);
            });
        });

        $("ul#commentList").on("click", ".edit-button", function () {
            var commentId = $(this).attr("data-id");
            var commentElement = $('p.comment-content[data-id="' + commentId + '"]').text();
            $("#contentCommentEdit").val(commentElement);
            $("#popupForm div.modal-content").attr("data-id", commentId);
            $("#popupForm").modal("show");
        });

        $("ul#commentList").on("click", ".reply-button", function () {
            $("div.inputReply").each(function () {
                $(this).remove()
            })
            var parentId = $(this).attr("data-id");
            var html =
                '<div class="row mb-4 mt-4 inputReply">'
                + '<div class="col-md-10 d-flex">'
                + '<img src="' + userCurrent.avatar + '" alt="Avatar" class="avatar rounded-circle img-thumbnail mr-4">'
                + '<textarea id="replyComment" data-id="' + parentId + '" class="form-control" placeholder="Add a comment..." style="min-height: 90px;"></textarea>'
                + '</div>'
                + '<div class="col-md-2">'
                + ' <button class="btn btn-primary submit-button mt-2 mb-2 w-100" id="replyCommentBtn" data-id="' + parentId + '">Submit</button>'
                + '</div>'
                + '</div>'
            if ($('ul#commentChildList-' + parentId + ' li.list-group-item').length > 0) {
                $(document).find('ul#commentChildList-' + parentId + ' li.list-group-item:first-child').before(html);
            } else {
                $(document).find('ul#commentChildList-' + parentId).html(html);
            }
        });

        $(document).on("click", "#replyCommentBtn", function (e) {
            var parentId = $(this).data("id");
            var content = $('textarea#replyComment[data-id=' + parentId + ']').val();
            var notificationId = $("table#tableNotification").attr("data-id");
            $(this).prop("disabled", true);
            $('textarea#replyComment[data-id=' + parentId + ']').prop("disabled", true);
            if (content == "") {
                var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Please input comment.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $(this).prop("disabled", false);
                $('textarea#replyComment[data-id=' + parentId + ']').prop("disabled", false);
                $('div.custom-spinner').parent().remove()
                return
            }
            var data = {
                content: content,
                notificationId: notificationId,
                parentId: parentId,
                userId: userCurrent.id
                // Add any other data you want to send to the server
            };
            var jsonData = JSON.stringify(data);
            replyComment(jsonData)
        });
        $(document).on("click", "#newCommentBtn", function (e) {
            var notificationId = $("div#viewNotification").attr("data-id")
            var content = $("textarea#newCommentContent").val()
            var data = {
                content: content,
                notificationId: notificationId,
                userId: userCurrent.id
            };
            var jsonData = JSON.stringify(data);
            sendComment(jsonData)
        });

        $(document).on("click", "#commentList button.btn-danger", function (e) {
            var commentId = $(this).data("id");
            $("#deleteConfirmationModal").attr("data-id", commentId)
        });

        document.getElementById("deleteButton").addEventListener("click", function () {
            $("#deleteConfirmationModal").modal("hide");
            var id = $("#deleteConfirmationModal").attr("data-id")
            $('li.list-group-item[data-id="' + id + '"] > div.ml-auto button').each(function () {
                $(this).prop("disabled", true);
            });
            var data = {
                id: id,
                userId: userCurrent.id
            };
            var jsonData = JSON.stringify(data);
            deleteComment(jsonData)
        })

        document.getElementById("saveChangesButton").addEventListener("click", function () {
            var content = $("#contentCommentEdit").val()
            if (content == "") {
                var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Please input comment.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $("button#newCommentBtn").prop("disabled", false);
                $("textarea#newComment").prop("disabled", false);
                $('div.custom-spinner').parent().remove()
                return
            }
            $(".modal-footer button").each(function () {
                $(this).prop("disabled", true);
            });
            // Create an XMLHttpRequest object
            var xhttp = new XMLHttpRequest();
            var apiUrl = baseUrlComment
            // Configure the request
            xhttp.open("PUT", apiUrl, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.setRequestHeader("Content-Type", "application/json");

            // Define the data you want to send (if needed)
            var id = $("div.modal-content").attr("data-id")
            var data = {
                id: id,
                content: content,
                userId: userCurrent.id
            };
            // Convert the data to JSON
            var jsonData = JSON.stringify(data);
            editComment(jsonData);
        });
    });
</script>
</body>
</html>
