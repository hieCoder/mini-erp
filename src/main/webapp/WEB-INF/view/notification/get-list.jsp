<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page import="com.shsoftvina.erpshsoftvina.enums.user.RoleEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<html>
<head>
    <title>Notifications List</title>
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
    </style>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title mb-0">Notification List</h4>
            </div><!-- end card header -->
            <div class="card-body">
                <div id="customerList">
                    <div class="row g-4 mb-3">
                        <div class="col-sm-auto d-flex justify-content-end align-items-center">
                                <div style="display: inline-block" class="dataTables_length"><label class="m-0">Show
                                    <select id="pageSizeSelect"
                                            name="example_length"
                                            aria-controls="example"
                                            class="form-select form-select-sm">
                                        <option <c:if test='${pageSize  == 10}'>selected</c:if>>10</option>
                                        <option <c:if test='${pageSize  == 15}'>selected</c:if>>15</option>
                                        <option <c:if test='${pageSize  == 20}'>selected</c:if>>20</option>
                                    </select> entries</label></div>
                        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                <button type="button" class="btn btn-success addNotification" style="margin-left: 8px"><i class="ri-add-line align-bottom me-1"></i> Add</button>
                                <button type="button" class="btn btn-danger showListInactive" style="margin-left: 8px"><i class=" ri-delete-bin-line align-bottom me-1"></i> Inactive List</button>
                                <button class="btn btn-soft-danger" onclick="deleteMultiple()" style="margin-left: 8px"><i class="ri-delete-bin-2-line"></i></button>
                        </c:if>
                        </div>
                        <div class="col-sm d-flex justify-content-end align-items-center">
                                <div class="search-box ms-2">
                                    <input id="searchInput" type="text" class="form-control search" placeholder="Search Title or Author">
                                    <i class="ri-search-line search-icon"></i>
                                </div>
                                <button class="btn btn-sm btn-primary" id="searchButton" style="margin-left: 8px">Search</button>
                        </div>
                    </div>

                    <div class="table-responsive table-card mt-3 mb-1">
                        <table class="table align-middle table-nowrap" id="customerTable">
                            <thead class="table-light">
                            <tr>
                                <th data-sort="customer_name">No. </th>
                                <th data-sort="email">Title</th>
                                <th data-sort="phone">Author</th>
                                <th data-sort="date">Created Date</th>
                            <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                <th data-sort="action">Action</th>
                            </c:if>
                            </tr>
                            </thead>
                            <tbody id="notificationList" class="list form-check-all">
                                <c:forEach items="${listNotification}" varStatus="loop" var="notification">
                                    <tr class="">
                                        <td class="number">${(loop.index + 1) + (currentPage-1)*pageSize }</td>
                                        <td class="fw-bold title">
                                            <a target="_blank" href="<c:url value='/notifications/${notification.id}'/>">${notification.title}</a>
                                        </td>
                                        <td class="author">${notification.user.fullname}</td>
                                        <td class="createdDate">${notification.createdDate}</td>
                                        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                        <td>
                                            <div class="d-flex gap-2" data-id="${notification.id}">
                                                <div class="viewNotification">
                                                    <button class="btn btn-sm btn-info edit-item-btn">View</button>
                                                </div>
                                                <div class="editNotification">
                                                    <button class="btn btn-sm btn-success edit-item-btn">Edit</button>
                                                </div>
                                                <div class="removeNotification">
                                                    <button class="btn btn-sm btn-danger remove-item-btn">Remove</button>
                                                </div>
                                            </div>
                                        </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="noresult" style="display: none">
                            <div class="text-center">
                                <lord-icon src="https://cdn.lordicon.com/msoeawqm.json" trigger="loop" colors="primary:#121331,secondary:#08a88a" style="width:75px;height:75px"></lord-icon>
                                <h5 class="mt-2">Sorry! No Result Found</h5>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center align-items-center paginationElement">
                        <div class="pagination-wrap hstack gap-2">
                            <div class="dataTables_paginate paging_simple_numbers" <c:if test="${totalPages <= 1}">class="invisible"</c:if> >
                                <ul class="pagination listjs-pagination mb-0" id="paginationList">
                                    <li class="paginate_button page-item previous linkStart">
                                        <span class="btn page-link fw-bold"
                                              data-page="1">Last</span>
                                    </li>
                                    <li class="paginate_button page-item previous linkStart">
                                        <span class="btn page-link fw-bold"
                                              data-page="-1">Previous</span>
                                    </li>
                                    <c:forEach var="page" begin="1" end="${totalPages}">
                                        <li class="paginate_button page-item <c:if test="${currentPage == page}"> active</c:if>"><span class="btn page-link fw-bold"
                                                                                                                                       data-page="${page}">${page}</span></li>
                                    </c:forEach>
                                    <li class="paginate_button page-item next linkEnd">
                                                        <span class="btn page-link fw-bold"
                                                              data-page="+1"> Next </span>
                                    </li>
                                    <li class="paginate_button page-item next linkEnd">
                                                        <span class="btn page-link fw-bold"
                                                              data-page="${totalPages}"> Last </span>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div><!-- end card -->
        </div>
        <!-- end col -->
    </div>
    <!-- end col -->
</div>

<div id="listInactive" class="modal modal-lg fade zoomIn" tabindex="-1" aria-labelledby="zoomInModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="zoomInModalLabel">List Inactive Notifications</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table id="inactiveNotificationTable" class="table align-middle table-nowrap">
                            <thead class="table-light">
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Title</th>
                                <th scope="col">Author</th>
                                <th scope="col">Created Date</th>
                            </tr>
                            </thead>
                            <tbody id="inactiveNotificationList" class="list form-check-all">
                            </tbody>
                        </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<div id="viewNotification" class="modal modal-xl fade zoomIn" tabindex="-1" aria-labelledby="zoomInModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">View Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="card">
                    <div class="card-body">
                        <div class="text-muted">
                            <h5 class="mb-3 fw-semibold text-uppercase titleView">Title</h5>

                        </div>
                        <div class="text-muted">
                            <h5 class="mb-3 fw-semibold text-uppercase contentView">Content</h5>
                            <div id="contentView">

                            </div>
                            <div class="pt-3 border-top border-top-dashed mt-4">
                                <div class="row">

                                    <div class="col-lg-3 col-sm-6">
                                        <div>
                                            <p class="mb-2 text-uppercase fw-medium">Create Date :</p>
                                            <h5 class="fs-15 mb-0">15 Sep, 2021</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="pt-3 border-top border-top-dashed mt-4">
                                <h6 class="mb-3 fw-semibold text-uppercase">Resources</h6>
                                <div class="row g-3">
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
                                                    <h5 class="fs-13 mb-1"><a href="#" class="text-body text-truncate d-block">App pages.zip</a></h5>
                                                    <div>2.2MB</div>
                                                </div>
                                                <div class="flex-shrink-0 ms-2">
                                                    <div class="d-flex gap-1">
                                                        <button type="button" class="btn btn-icon text-muted btn-sm fs-18"><i class="ri-download-2-line"></i></button>
                                                        <div class="dropdown">
                                                            <button class="btn btn-icon text-muted btn-sm fs-18 dropdown" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                <i class="ri-more-fill"></i>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a class="dropdown-item" href="#"><i class="ri-pencil-fill align-bottom me-2 text-muted"></i> Rename</a></li>
                                                                <li><a class="dropdown-item" href="#"><i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i> Delete</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end col -->
                                    <div class="col-xxl-4 col-lg-6">
                                        <div class="border rounded border-dashed p-2">
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar-sm">
                                                        <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                            <i class="ri-file-ppt-2-line"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <h5 class="fs-13 mb-1"><a href="#" class="text-body text-truncate d-block">Velzon admin.ppt</a></h5>
                                                    <div>2.4MB</div>
                                                </div>
                                                <div class="flex-shrink-0 ms-2">
                                                    <div class="d-flex gap-1">
                                                        <button type="button" class="btn btn-icon text-muted btn-sm fs-18"><i class="ri-download-2-line"></i></button>
                                                        <div class="dropdown">
                                                            <button class="btn btn-icon text-muted btn-sm fs-18 dropdown" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                <i class="ri-more-fill"></i>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a class="dropdown-item" href="#"><i class="ri-pencil-fill align-bottom me-2 text-muted"></i> Rename</a></li>
                                                                <li><a class="dropdown-item" href="#"><i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i> Delete</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end col -->
                                </div>
                                <!-- end row -->
                            </div>
                        </div>
                    </div>
                    <!-- end card body -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<div id="formCreateNotication" data-bs-keyboard="false" data-bs-backdrop="static" class="modal fade zoomIn bs-example-modal-xl" tabindex="-1" aria-labelledby="myExtraLargeModalLabel" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="myExtraLargeModalLabel">Create Notification Form</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- start page title -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="form-label" for="titleCreate">Notification Title</label>
                                    <input type="text" class="form-control" id="titleCreate" placeholder="Input Title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Notification Content</label>
                                    <div class="snow-editor" id="contentCreate">

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

                                    <div class="dropzone" id="dropzoneCreate">
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

                                    <ul class="list-unstyled mb-0" id="dropzone-preview">
                                        <li class="mt-2" id="dropzone-preview-list">
                                            <!-- This is used as the file preview template -->
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="d-flex p-2">                                                    <div class="flex-shrink-0 me-3">
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
                <button type="button" class="btn btn-primary createBtn">Create</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
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
                                    <label class="form-label" for="titleCreate">Notification Title</label>
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
                    <button type="button" class="btn w-sm btn-danger " id="deleteNotificationBtn">Yes, Delete It!</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
        const baseUrlComment = "/api/v1/comment-notification";
        const baseUrlNotification = "/api/v1/notifications";
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
        function displayPagination() {
        var currentUrl = window.location.search;
        var params = new URLSearchParams(currentUrl);
        var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
        if (currentPage == 1) {
            $("li.linkStart").addClass("d-none")
        } else {
            $("li.linkStart").removeClass("d-none")
        }
        var lastPageElement = $("#paginationList > li").eq(-3)
        let lastPage = $(lastPageElement).children().attr("data-page")
        if (currentPage == lastPage) {
            $("li.linkEnd").addClass("d-none")
        } else {
            $("li.linkEnd").removeClass("d-none")
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        displayPagination()
        $("button.addNotification").click(function () {
            Dropzone.forElement('#dropzoneCreate').removeAllFiles(true)
            $("#titleCreate").val("")
            $(".ql-editor").html("")
            $("#formCreateNotication").modal("show")
        })

        $(document).on("click", "li.viewNotification", function (e) {
            let main = $(this)
            let idNotification = main.parent().attr("data-id")

            $("#viewNotification").modal("show")
        })
        $(document).on("click", "li.paginate_button", function (e) {
            var currentUrl = window.location.search;
            var params = new URLSearchParams(currentUrl);
            var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
            var target = event.target;
            if (target.tagName === "SPAN") {
                var page = target.getAttribute("data-page");
                if (page === "-1") {
                    page = currentPage - 1
                    if (page < 1) {
                        return;
                    }
                } else if (page === "+1") {
                    page = currentPage + 1;
                }
                if (currentPage == page || page > ${totalPages}) {
                    return;
                }
                if (currentUrl.includes("page=")) {
                    currentUrl = currentUrl.replace(/(page=)[^\&]+/, "page=" + page);
                } else {
                    if (currentUrl.includes("?")) {
                        currentUrl += "&page=" + page;
                    } else {
                        currentUrl += "?page=" + page;
                    }
                }
            }
            document.querySelector(".page-item.active").classList.remove("active");
            var listActive = document.querySelectorAll('[data-page="' + page + '"]')
            if (page == 1) {
                listActive[1].parentElement.classList.add("active");
            } else {
                listActive[0].parentElement.classList.add("active");
            }
            var apiUrl = baseUrlNotification + currentUrl
            var tbodyElement = document.getElementById("notificationList");
            tbodyElement.classList.add("hidden")
            callAjaxByJsonWithData(apiUrl, "GET", null,
                function (rs) {
                    if(rs){
                        history.pushState(null, null, currentUrl);
                        let xhtml =""
                        var currentURL = window.location.href;
                        var urlParams = new URLSearchParams(currentURL);
                        var pageSize = urlParams.get("pageSize") ? urlParams.get("pageSize") : 10
                        rs.forEach(function (notification, index) {
                            let pageInt = (parseInt(page) - 1) * pageSize
                            xhtml += '<tr class="">' +
                                '<td>' + (index + pageInt + 1) + '</td>' +
                                '<td class="fw-bold"><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '<td>' +
                                '    <div class="d-flex gap-2" data-id="'+ notification.id +  '">' +
                                        '<div class="viewNotification">'+
                                            '<button class="btn btn-sm btn-info edit-item-btn">View</button>'+
                                       ' </div>'+
                                        '<div class="editNotification">'+
                                            '<button class="btn btn-sm btn-success edit-item-btn">Edit</button>'+
                                        '</div>'+
                                        '<div class="removeNotification">'+
                                            '<button class="btn btn-sm btn-danger remove-item-btn">Remove</button>'+
                                        '</div>'+
                                '    </div>' +
                                '</td>'+
                                '</tr>'
                        })
                        tbodyElement.innerHTML = xhtml
                        tbodyElement.classList.remove("hidden")
                        displayPagination()
                    } else{
                        console.log("Data API Error")
                    }
                },
                function (error){
                    console.log("Call API Error")
                    console.log(error)
            })
        })
        const pageSizeSelect = document.getElementById("pageSizeSelect");

        pageSizeSelect.addEventListener("change", () => {
            const selectedValue = pageSizeSelect.value;
            updateUrl(selectedValue);
        });

        const updateUrl = (selectedValue) => {
            let currentUrl = window.location.href;
            if (currentUrl.includes("pageSize=")) {
                currentUrl = currentUrl.replace(/(pageSize=)[^\&]+/, "pageSize=" + selectedValue);
            } else {
                if (currentUrl.includes("?")) {
                    currentUrl += "&pageSize=" + selectedValue
                } else {
                    currentUrl += "?pageSize=" + selectedValue
                }
            }
            window.location.href = currentUrl
        };

        function searchNotification() {
            var keyword = searchInput.value;
            var currentUrl = window.location.href;

            if (currentUrl.includes("?")) {
                if (currentUrl.includes("search=")) {
                    var regex = /(\?|&)search=([^&]*)/;
                    var newUrl = currentUrl.replace(regex, "$1search=" + encodeURIComponent(keyword));
                    window.location.href = newUrl;
                } else {
                    var newUrl = currentUrl + "&search=" + encodeURIComponent(keyword);
                    window.location.href = newUrl;
                }
            } else {
                var newUrl = currentUrl + "?search=" + encodeURIComponent(keyword);
                window.location.href = newUrl;
            }
        }


        var searchInput = document.getElementById("searchInput");
        var searchButton = document.getElementById("searchButton");
        searchInput.addEventListener("keydown", handleSearchEvent);
        searchButton.addEventListener("click", handleSearchEvent);

        function showSearchValue(){
            var url = new URL(window.location.href);
            var params = url.searchParams;
            var paramValue = params.get("search");
            if(paramValue){
                document.getElementById("searchInput").value = paramValue
            }
        }
        showSearchValue()
        function handleSearchEvent(event) {
            if (event.key === "Enter" || event.type === "click") {
                searchNotification();
            }
        }

        $("button.showListInactive").click(function () {
            let button = $(this)
            button.addClass("d-none")
            button.prop("disabled", true)
            button.before(BtnDangerLoad)
            callAjaxByJsonWithData(baseUrlNotification + "/inactive", "GET", null, function (rs) {
                if (rs) {
                    let xhtml = ""
                    if (rs.length > 0) {
                        rs.forEach(function (notification, index) {
                            xhtml += '<tr>' +
                                '<td>' + (index + 1) + '</td>' +
                                '<td class="fw-bold"><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '</tr>';
                        })
                        $("#inactiveNotificationList").html(xhtml)
                    } else {
                        xhtml = '<tr>' +
                            '<td class="text-center" colspan="4">' +
                            '<div class="alert alert-warning" role="alert"> <strong> The list is empty  </strong></div>' +
                            '</td>' +
                            '</tr>'
                        $("#inactiveNotificationList").html(xhtml)
                    }
                    $("#listInactive").modal("show")
                    button.removeClass("d-none")
                    $("button.showListInactive").prop("disabled", false)
                } else {
                    console.log("Data Error")
                    $("button.showListInactive").prop("disabled", false)
                }
                BtnLoadRemove()
            }, function (error){
                console.log("Call API Error")
                console.log(error)
            })
        });
    })
        let checkSearch = (number) => {
            var url = new URL(window.location.href);
            var params = url.searchParams;
            var paramValue = params.get("search");
            if((number === 0 && paramValue) || number === 0){
                $(".noresult").css("display", "block")
                $("ul.pagination ").addClass("d-none")
            } else{
                $(".noresult").css("display", "none")
                $("ul.pagination ").removeClass("d-none")
            }
        }
        checkSearch(${listNotification.size()});
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

        function bytesToMBShow(bytes){
            return (bytes / (1024 * 1024)).toFixed(2)
        }
        function showFileUploaded(fileName, size, url){

            return "<div class='col-xxl-4 col-lg-6' data-name='"+ fileName +"'>"
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
                + "                <h5 class='fs-13 mb-1'><a href='"+ url +"' download data-toggle='tooltip' data-placement='bottom' title='"+ fileName+"' class='text-body text-truncate d-block'>" + fileName + "</a></h5>"
                + "                <div>"+ bytesToMBShow(size)+" MB</div>"
                + "            </div>"
                + "            <div class='flex-shrink-0 ms-2'>"
                + "                <div class='d-flex gap-1'>"
                + "                    <button type='button' class='btn btn-icon text-muted btn-sm fs-18 downFileBtn'>"
                + "                        <i class='ri-download-2-line' data-url='"+ url +"'></i>"
                + "                    </button>"
                + "                    <button type='button' class='btn btn-icon text-muted btn-sm fs-18 deleteFileBtn'>"
                + "                        <i class='ri-delete-bin-fill' data-name='"+ fileName +"'></i>"
                + "                    </button>"
                + "                </div>"
                + "            </div>"
                + "        </div>"
                + "    </div>"
                + "</div>";
        }

        function loadDatabase(){
            var currentUrl = window.location.search;
            var params = new URLSearchParams(currentUrl);
            var page = !params.get('page') ? 1 : parseInt(params.get('page'));
            var pageSize = !params.get('pageSize') ? 10 : parseInt(params.get('pageSize'));
            var search = !params.get('search') ? "" : params.get('search');
            let currentGet = "?page=" +page +"&pageSize="+pageSize+"&search="+search
            var apiUrl = baseUrlNotification + currentGet
            var tbodyElement = document.getElementById("notificationList");
            callAjaxByJsonWithData(apiUrl, "GET", null,
                function (rs) {
                    if(rs){
                        history.pushState(null, null, currentUrl);
                        let xhtml =""
                        var currentURL = window.location.href;
                        var urlParams = new URLSearchParams(currentURL);
                        var pageSize = urlParams.get("pageSize") ? urlParams.get("pageSize") : 10
                        rs.forEach(function (notification, index) {
                            let pageInt = (parseInt(page) - 1) * pageSize
                            xhtml += '<tr class="">' +
                                '<td>' + (index + pageInt + 1) + '</td>' +
                                '<td class="fw-bold"><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '<td>' +
                                '    <div class="d-flex gap-2" data-id="'+ notification.id +  '">' +
                                '<div class="viewNotification">'+
                                '<button class="btn btn-sm btn-info edit-item-btn">View</button>'+
                                ' </div>'+
                                '<div class="editNotification">'+
                                '<button class="btn btn-sm btn-success edit-item-btn">Edit</button>'+
                                '</div>'+
                                '<div class="removeNotification">'+
                                '<button class="btn btn-sm btn-danger remove-item-btn">Remove</button>'+
                                '</div>'+
                                '    </div>' +
                                '</td>'+
                                '</tr>'
                        })
                        tbodyElement.innerHTML = xhtml
                        tbodyElement.classList.remove("hidden")
                        displayPagination()
                    } else{
                        console.log("Data API Error")
                    }
                },
                function (error){
                    console.log("Call API Error")
                    console.log(error)
                })
        }
        $(document).on("click","div.removeNotification", function (){
            let notificationId = $(this).parent().attr("data-id")
            $("#deleteNotification").attr("data-id", notificationId)
            $("#deleteNotification").modal("show")
        })

        $(document).on("click","div.viewNotification", function (){
            let notificationId = $(this).parent().attr("data-id")
            $("#viewNotification").attr("data-id", notificationId)
            let apiUrlNotification = baseUrlNotification
            if(notificationId){
                callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null,
                    function (rs) {
                        console.log(rs)
                        $("h5.titleView").text("Title: " + rs.title)
                        let contentParse = JSON.parse(rs.content)
                        quillView.setContents(contentParse)
                        console.log(contentParse)
                        let urlFiles = rs.files ? rs.files : []
                        let fileLength = rs.files ? rs.files.length : 0
                        let html=""
                        if(fileLength>0){
                            urlFiles.forEach(function (url) {
                                $.ajax({
                                    type: "HEAD",
                                    url: url,
                                    success: function (data, status, xhr) {
                                        var contentLength = xhr.getResponseHeader('Content-Length');
                                        var fileName = url.substring(url.lastIndexOf("/") + 1);
                                        html+= showFileUploaded(fileName, contentLength, url)
                                        $(".showFilesUploaded").html(html)
                                        $("#viewNotification").modal("show")
                                    }
                                });
                            });
                        }else{
                            $("#viewNotification").modal("show")
                        }
                    },
                    function (error){
                        console.log(error)
                    }
                )
            }
        })

        $(document).on("click","#deleteNotificationBtn", function (){
           let notificationId = $("#deleteNotification").attr("data-id")
            let apiUrlNotification = baseUrlNotification;
            if(notificationId){
                callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
                    console.log(rs)
                    if(rs){
                        loadDatabase();
                    }
                    $("#deleteNotification").modal("hide")
                });
            }
        })

        $(document).on("click","button.downFileBtn",function (){
            let dataUrl = $(this).children().attr("data-url")
            downloadFiles(dataUrl)
        })

        $(document).on("click","button.deleteFileBtn",function (){
            let fileName = $(this).children().attr("data-name")
            $("#deleteFileModal").attr("data-name", fileName)
            $("#deleteFileModal").modal("show")
        })

        $(document).on("click","button#deleteFileBtn",function (){
            let fileName = $("#deleteFileModal").attr("data-name")
            $('div.showFilesUploaded > div[data-name="' + fileName + '"]').remove();
            $("#deleteFileModal").modal("hide")
            dropzoneEdit.options.maxFiles = dropzoneEdit.options.maxFiles + 1;
        })

        function downloadFiles(url){
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
                    'toolbar': [[{ 'font': [] }, { 'size': [] }], ['bold', 'italic', 'underline', 'strike'],
                        [{ 'color': [] }, { 'background': [] }], [{ 'script': 'super' }, { 'script': 'sub' }],
                        [{ 'header': [false, 1, 2, 3, 4, 5, 6] }, 'blockquote', 'code-block'],
                        [{ 'list': 'ordered' }, { 'list': 'bullet' }, { 'indent': '-1' }, { 'indent': '+1' }],
                        ['direction', { 'align': [] }], ['link', 'image', 'video'], ['clean']]
                }
         var quillCreate = new Quill("#contentCreate", snowEditorData);
         var quillEdit = new Quill("#contentEdit", snowEditorData);
        var quillView = new Quill("#contentView",{
            theme: 'bubble', // Specify theme in configuration
            readOnly: true,  // Set the editor to read-only mode
        });

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
        var dropzonePreviewNode = document.querySelector("#dropzone-preview-list");
        dropzonePreviewNode.id = "";
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
        var dropzone = new Dropzone("#dropzoneCreate", {
            url: 'https://httpbin.org/post',
            method: "post",
            previewTemplate: previewTemplate,
            previewsContainer: "#dropzone-preview",
            acceptedFiles: listTypeFile,
            maxFilesize: parseInt(maxFileSize),
            maxFiles: parseInt(uploadFileLimit) ,
            uploadMultiple:true,
            autoProcessQueue: false,
        });

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
             maxFiles: parseInt(uploadFileLimit) ,
             uploadMultiple:true,
             autoProcessQueue: false,
         });

         function removeAlert(){
             $(".alert-danger").remove()
         }
        function checkLimitFile(count, limit){
             return count <= limit ? true : false
        }

        function checkTypeFile(type, listType){
            if(listType.includes(type)){
                return true
            }
        }

        function checkLimitSize(size, limit){
            if(parseInt(size)<= limit){
                return true
            }
        }

        function showAlertValidate(html){
            let xhtml =  '<li class="mt-2" id=""> '+
                html +
                '</li>'

            let check = $("#dropzone-preview-edit li").children().last()
            if(check.length>0){
                $("#dropzone-preview-edit li").children().last().after(xhtml)
            }else{
                $("#dropzone-preview-edit").html(xhtml)
            }

        }

        function showAlertValidateCreate(html){
            let xhtml =  '<li class="mt-2" id=""> '+
                html +
                '</li>'

            let check = $("#dropzone-preview li").children().last()
            if(check.length>0){
                $("#dropzone-preview li").children().last().after(xhtml)
            }else{
                $("#dropzone-preview").html(xhtml)
            }

        }

        dropzone.on("addedfile", function (file) {
            removeAlert();
            let files = dropzone.files
            const fileExtension = file.name.split('.').pop();
            const fileSize = file.size
            if(!checkLimitFile(files.length,parseInt(uploadFileLimit))){
                dropzone.removeFile(file)
                showAlertValidateCreate(INVALID_FILES_LIMIT)
                return
            }
            if(!checkTypeFile(fileExtension, listTypeFileArr)){
                dropzone.removeFile(file)
                showAlertValidateCreate(INVALID_FILES_TYPE)
                return
            }
            if(!checkLimitSize(bytesToMB(fileSize),parseInt(maxFileSize))){
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

         $(document).on("click",".editNotification",function (){
             Dropzone.forElement('#dropzoneEdit').removeAllFiles(true)
             let notificationId = $(this).parent().attr("data-id")
             let apiUrlNotification = baseUrlNotification
             if(notificationId){
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
                             let html=""
                             if(fileLength>0){
                                 urlFiles.forEach(function (url) {
                                     $.ajax({
                                         type: "HEAD",
                                         url: url,
                                         success: function (data, status, xhr) {
                                             var contentLength = xhr.getResponseHeader('Content-Length');
                                             var fileName = url.substring(url.lastIndexOf("/") + 1);
                                             console.log("File Name: " + fileName);
                                             console.log("Content Length: " + contentLength);
                                             html+= showFileUploaded(fileName, contentLength, url)
                                             $(".showFilesUploaded").html(html)
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
            $("div.showFilesUploaded > div").each(function () {
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
                    $('#notificationList a[href="/notifications/'+notificationId+'"]').text(rs.title)
                    $("#formEditNotication").modal("hide")
                }
            },function (error){
                console.log(error)
            })

        })
        $(document).on("click","button.createBtn", function (){
            removeAlert()
            var apiUrlNotification = baseUrlNotification + "/update/"
            let title = $("#titleCreate").val()
            let contentCheck = $("#formCreateNotication .ql-editor").html().toString()
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
            if(dropzone.files.length>0){
                for (let i = 0; i < dropzone.files.length; i++) {
                    let file = dropzone.files[i]
                    if(file.accepted){
                        formData.append("files", file);
                    }
               }
            }
            callAjaxByDataFormWithDataForm2("${apiURL}${pathMain}","POST", formData ,function (rs){
                console.log(rs)
                if(rs>0){
                    loadDatabase();
                    $("#formCreateNotication").modal("hide")
                }
            },function (error){
                console.log(error)
            })
        })
</script>
</body>
</html>
