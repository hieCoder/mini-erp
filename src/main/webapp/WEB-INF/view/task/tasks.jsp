<%@ page import="com.shsoftvina.erpshsoftvina.constant.TaskConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Tasks</title>
    <!-- dropzone css -->
    <link rel="stylesheet" href="/assets/libs/dropzone/dropzone.css" type="text/css"/>
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Tasks List</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks management</a></li>
                    <li class="breadcrumb-item active">Tasks List</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-xxl-2 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Total Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-total-task">0</span></h2>
                    </div>
                    <div>
                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-info text-info rounded-circle fs-4">
                                                    <i class="ri-ticket-2-line"></i>
                                                </span>
                        </div>
                    </div>
                </div>
            </div><!-- end card body -->
        </div> <!-- end card-->
    </div>
    <!--end col-->
    <div class="col-xxl-2 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Closed Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-closed-task">0</span></h2>
                    </div>
                    <div>
                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-success text-success rounded-circle fs-4">
                                                    <i class="ri-checkbox-circle-line"></i>
                                                </span>
                        </div>
                    </div>
                </div>
            </div><!-- end card body -->
        </div>
    </div>
    <!--end col-->
    <div class="col-xxl-2 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Opened Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-opened-task">0</span></h2>
                    </div>
                    <div>
                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-warning text-warning rounded-circle fs-4">
                                                    <i class="mdi mdi-timer-sand"></i>
                                                </span>
                        </div>
                    </div>
                </div>
            </div><!-- end card body -->
        </div>
    </div>
    <!--end col-->
    <div class="col-xxl-2 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Reopened Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-reopend-task">0</span></h2>
                    </div>
                    <div>
                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-secondary text-secondary rounded-circle fs-4">
                                                    <i class="mdi mdi-timer-sand"></i>
                                                </span>
                        </div>
                    </div>
                </div>
            </div><!-- end card body -->
        </div>
    </div>
    <!--end col-->
    <div class="col-xxl-2 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Postponed Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-postponed-task">0</span></h2>
                    </div>
                    <div>
                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-danger text-danger rounded-circle fs-4">
                                                    <i class="mdi mdi-timer-sand"></i>
                                                </span>
                        </div>
                    </div>
                </div>
            </div><!-- end card body -->
        </div>
    </div>
    <!--end col-->
    <div class="col-xxl-2 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Registered Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-registered-task">0</span></h2>
                    </div>
                    <div>
                        <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-primary text-primary rounded-circle fs-4">
                                                    <i class="mdi mdi-timer-sand"></i>
                                                </span>
                        </div>
                    </div>
                </div>
            </div><!-- end card body -->
        </div>
    </div>
    <!--end col-->
</div>
<!--end row-->

<div class="row">
    <div class="col-lg-12">
        <div class="alert alert-success d-none"></div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="card" id="tasksList">
            <div class="card-header border-0">
                <div class="d-flex align-items-center">
                    <h5 class="card-title mb-0 flex-grow-1">All Tasks</h5>
                    <div class="flex-shrink-0">
                        <a href="/tasks/register" class="btn btn-success"><i class="ri-add-line align-bottom me-1"></i>
                            Register task</a>
                        <button class="btn btn-soft-danger" id="delete-mul-task"><i class="ri-delete-bin-2-line"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="card-body border border-dashed border-end-0 border-start-0">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="hstack gap-2 flex-wrap">
                            <input type="radio" class="btn-check task-status" name="options" id="all" data-value=""
                                   checked>
                            <label class="btn btn btn-light" for="all">ALL</label>

                            <input type="radio" class="btn-check task-status" name="options" id="opened"
                                   data-value="OPENED">
                            <label class="btn btn-warning" for="opened">OPENED</label>

                            <input type="radio" class="btn-check task-status" name="options" id="reopened"
                                   data-value="REOPENED">
                            <label class="btn btn-info" for="reopened">REOPENED</label>

                            <input type="radio" class="btn-check task-status" name="options" id="registered"
                                   data-value="REGISTERED">
                            <label class="btn btn-secondary" for="registered">REGISTERED</label>

                            <input type="radio" class="btn-check task-status" name="options" id="postponed"
                                   data-value="POSTPONED">
                            <label class="btn btn-danger" for="postponed">POSTPONED</label>

                            <input type="radio" class="btn-check task-status" name="options" id="closed"
                                   data-value="CLOSED">
                            <label class="btn btn-success" for="closed">CLOSED</label>
                        </div>
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-xxl-3 col-sm-12">
                        <div class="search-box">
                            <input id="titleSearch" type="text"
                                   class="form-control search bg-light border-light search-task"
                                   placeholder="Search by title">
                            <i class="ri-search-line search-icon"></i>
                        </div>
                    </div>
                    <div class="col-xxl-3 col-sm-12">
                        <div class="search-box">
                            <input id="picSearch" type="text"
                                   class="form-control search bg-light border-light search-task"
                                   placeholder="Search by Pic">
                            <i class="ri-search-line search-icon"></i>
                        </div>
                    </div>
                    <div class="col-xxl-3 col-sm-12">
                        <div class="search-box">
                            <input id="tagSearch" type="text"
                                   class="form-control search bg-light border-light search-task"
                                   placeholder="Search by tag">
                            <i class="ri-search-line search-icon"></i>
                        </div>
                    </div>
                    <div class="col-xxl-1 col-sm-4">
                        <button id="reset-search" type="button" class="btn btn-primary btn-load">
                            Reset
                        </button>
                    </div>
                    <div class="col-xxl-2 col-sm-4 d-flex align-items-center float-end">
                        <div style="margin-right: 5px;">Show entries:</div>
                        <div class="d-flex align-items-center align-items-center">
                            <select id="page-count-select" class="form-select" aria-label=".form-select-lg example">
                                <option value="10">10</option>
                                <option value="15">15</option>
                                <option value="20">20</option>
                            </select>
                            <span class="btn-load ml-10">
                                    <span class="spinner-border flex-shrink-0 d-none"></span>
                                </span>
                        </div>
                    </div>
                    <!--end col-->
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive table-card">
                    <table class="table align-middle table-nowrap mb-0 w-100" style="margin: 0px!important;"
                           id="tasksTable">
                        <thead class="table-light text-muted">
                        <tr>
                            <th scope="col" style="width: 40px;">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="checkAll" value="option">
                                </div>
                            </th>
                            <th>ID</th>
                            <th>Status</th>
                            <th>Title</th>
                            <th>Pic</th>
                            <th>Priority</th>
                            <th>Progress</th>
                            <th>Start date</th>
                            <th>Due/Closed date</th>
                            <th>Tag</th>
                        </tr>
                        </thead>
                        <tbody class="list form-check-all"></tbody>
                    </table>
                    <!--end table-->
                </div>
                <div class="d-flex justify-content-center">
                    <div class="pagination-wrap hstack gap-2">
                        <ul id="pagination" class="pagination mb-0"></ul>
                    </div>
                </div>
            </div>
            <!--end card-body-->
        </div>
        <!--end card-->
    </div>
    <!--end col-->
</div>
<!--end row-->

<div class="modal fade flip" id="deleteTaskModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop"
                           colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a task ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger btn-load" id="delete-task" data-id="">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Yes, Delete It</span>
                            </span>
                        </button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none"
                                id="delete-task-close" data-bs-dismiss="modal"><i
                                class="ri-close-line me-1 align-middle"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<div class="modal fade zoomIn" id="registerTaskModal" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel">Register Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                        id="close-modal"></button>
            </div>
            <form id="registerTaskForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <label for="selectUsername" class="form-label">Username: <span
                                    class="username-register-task"></span></label>
                            <select id="selectUsername" name="userId" class="form-select d-none"
                                    aria-label="Default select example">
                            </select>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="title" class="form-label">Title</label>
                                <input type="text" id="title" name="title" class="form-control" placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <!--end col-->
                        <div class="col-lg-12">
                            <label for="content" class="form-label">Content</label>
                            <div id="content" class="snow-editor h-auto"></div>
                            <small class="form-message"></small>
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="dueDate" class="form-label">Due date</label>
                            <input type="text" id="dueDate" name="dueDate" class="form-control"
                                   data-provider="flatpickr" placeholder="Due date"/>
                            <small class="form-message"></small>
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="selectPriority" class="form-label">Priority</label>
                            <select id="selectPriority" name="priority" class="form-control" data-choices
                                    data-choices-search-false>
                                <option value="LOW">Low</option>
                                <option value="MEDIUM">Medium</option>
                                <option value="HIGH">High</option>
                            </select>
                        </div>
                        <!--end col-->
                    </div>
                    <!--end row-->
                </div>
                <div class="modal-footer">
                    <div class="hstack gap-2 justify-content-end">
                        <button type="submit" class="btn btn-success btn-load">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Register</span>
                            </span>
                        </button>
                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade zoomIn" id="editTaskModal" aria-hidden="true" aria-labelledby="..." tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel-edit-task">Update task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                        id="close-modal"></button>
            </div>
            <form id="editTaskForm">
<%--                <div class="modal-body" data-simplebar style="max-height: 800px">--%>
<%--                    <div class="row g-3">--%>
<%--                        <div class="col-lg-12">--%>
<%--                            <label for="selectUsernameEdit" class="form-label">Username: <span--%>
<%--                                    class="username-edit-task"></span></label>--%>
<%--                            <select id="selectUsernameEdit" name="userId" class="form-select d-none"--%>
<%--                                    aria-label="Default select example">--%>
<%--                            </select>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-12">--%>
<%--                            <div>--%>
<%--                                <label for="title" class="form-label">Title</label>--%>
<%--                                <input type="text" id="title-edit" name="title" class="form-control"--%>
<%--                                       placeholder="Title"/>--%>
<%--                                <small class="form-message"></small>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <!--end col-->--%>
<%--                        <div class="col-lg-12">--%>
<%--                            <label for="content" class="form-label">Content</label>--%>
<%--                            <div id="content-edit" class="snow-editor h-auto"></div>--%>
<%--                            <small class="form-message"></small>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-12">--%>
<%--                            <label class="form-label">Old files</label>--%>
<%--                            <div class="row mb-1">`--%>
<%--                                + files +--%>
<%--                                `--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-12">--%>
<%--                            <label class="form-label">Attach file</label>--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="dropzone">--%>
<%--                                    <div class="fallback">--%>
<%--                                        <input name="fileList" type="file" multiple="multiple">--%>
<%--                                    </div>--%>
<%--                                    <div class="dz-message needsclick">--%>
<%--                                        <div class="mb-3">--%>
<%--                                            <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>--%>
<%--                                        </div>--%>
<%--                                        <h4>Drop files here or click to upload.</h4>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <ul class="list-unstyled mb-0" id="dropzone-preview">--%>
<%--                                    <li class="mt-2" id="dropzone-preview-list">--%>
<%--                                        <div class="border rounded">--%>
<%--                                            <div class="d-flex p-2">--%>
<%--                                                <div class="flex-shrink-0 me-3">--%>
<%--                                                    <div class="avatar-sm bg-light rounded">--%>
<%--                                                        <div class="avatar-title bg-light text-secondary rounded fs-24">--%>
<%--                                                            <i class="ri-file-upload-line"></i>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                                <div class="flex-grow-1">--%>
<%--                                                    <div class="pt-1">--%>
<%--                                                        <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>--%>
<%--                                                        <p class="fs-13 text-muted mb-0" data-dz-size></p>--%>
<%--                                                        <strong class="error text-danger" data-dz-errormessage></strong>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                                <div class="flex-shrink-0 ms-3">--%>
<%--                                                    <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </li>--%>
<%--                                </ul>--%>
<%--                                <div class="message-error-file"></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <!--end col-->--%>
<%--                        <div class="col-lg-6">--%>
<%--                            <label for="selectActionEdit" class="form-label">Status:<span--%>
<%--                                    id="statusTaskEdit"></span></label>--%>
<%--                            <select id="selectActionEdit" name="action" class="form-control"></select>--%>
<%--                        </div>--%>
<%--                        <!--end col-->--%>
<%--                        <div class="col-lg-6">--%>
<%--                            <label for="selectProgressEdit" class="form-label">Progress</label>--%>
<%--                            <select id="selectProgressEdit" name="progress" class="form-control">--%>
<%--                                <option value="0">0</option>--%>
<%--                                <option value="5">5</option>--%>
<%--                                <option value="10">10</option>--%>
<%--                                <option value="15">15</option>--%>
<%--                                <option value="20">20</option>--%>
<%--                                <option value="25">25</option>--%>
<%--                                <option value="30">30</option>--%>
<%--                                <option value="35">35</option>--%>
<%--                                <option value="40">40</option>--%>
<%--                                <option value="45">45</option>--%>
<%--                                <option value="50">50</option>--%>
<%--                                <option value="55">55</option>--%>
<%--                                <option value="60">60</option>--%>
<%--                                <option value="65">65</option>--%>
<%--                                <option value="70">70</option>--%>
<%--                                <option value="75">75</option>--%>
<%--                                <option value="80">80</option>--%>
<%--                                <option value="85">85</option>--%>
<%--                                <option value="90">90</option>--%>
<%--                                <option value="95">95</option>--%>
<%--                                <option value="100">100</option>--%>
<%--                            </select>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-6">--%>
<%--                            <label for="dueDateEdit" class="form-label">Due date</label>--%>
<%--                            <input type="text" id="dueDateEdit" class="form-control"--%>
<%--                                   data-provider="flatpickr" placeholder="Due date"/>--%>
<%--                            <small class="form-message"></small>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-6">--%>
<%--                            <label for="selectPriority" class="form-label">Priority</label>--%>
<%--                            <select id="selectPriorityEdit" name="priority" class="form-control">--%>
<%--                                <option value="LOW">Low</option>--%>
<%--                                <option value="MEDIUM">Medium</option>--%>
<%--                                <option value="HIGH">High</option>--%>
<%--                            </select>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-6 d-flex align-items-center">--%>
<%--                            <label class="form-label m-0">Tag: </label>--%>
<%--                            <div id="show-tag" class="d-flex align-items-center">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-6 d-flex align-items-center">--%>
<%--                            <label class="form-label m-0">Pic: </label>--%>
<%--                            <div id="show-pic" class="d-flex align-items-center">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-lg-12 d-flex align-items-center">--%>
<%--                            <label class="form-label m-0">Related Task: </label>--%>
<%--                            <div id="show-related-task" class="d-flex align-items-center">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <div class="hstack gap-2 justify-content-end">--%>
<%--                        <button type="submit" class="btn btn-success btn-load" id="update-task-btn">--%>
<%--                            <span class="d-flex align-items-center">--%>
<%--                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>--%>
<%--                                <span class="flex-grow-1">Update</span>--%>
<%--                            </span>--%>
<%--                        </button>--%>
<%--                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </form>
        </div>
    </div>
</div>

<!-- Modal Add Tag To Tag -->
<div id="tagModal" class="modal fade" tabindex="-1" aria-labelledby="..." aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">TAG</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 border p-1" id="tag-selected" style="height: 45px"></div>
                <div class="mt-2 text-center align-items-center" data-simplebar style="max-height: 400px">
                    <div class="d-flex justify-content-between align-items-center">
                        <input type="text" id="searchTag" class="form-control" placeholder="Search Tag..."
                               style="width: 30%">
                        <button type="button" class="btn btn-primary ms-1" data-bs-toggle="modal"
                                data-bs-target="#add-tag-name">+ TAG NAME
                        </button>
                    </div>
                    <div>
                        <table class="table table-bordered mt-2 nowrap align-middle" style="border: 1px solid black">
                            <thead>
                            <tr>
                                <th style="border: 1px solid black">Default Tags</th>
                                <th style="border: 1px solid black">Tags added</th>
                            </tr>
                            </thead>
                            <tbody id="dataBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="save-tag-selected" type="button" class="btn btn-primary" data-bs-dismiss="modal">Save
                    Changes
                </button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Add Tag Name -->
<div class="modal fade" id="add-tag-name" aria-hidden="true" aria-labelledby="..." tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalgridLabel">Add a new tag Name</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <label for="new-tag-name" class="form-label float-start">Tag Name</label>
                <input id="new-tag-name" class="form-control" type="text" placeholder="Enter here..." required
                       maxlength="10">
                <span id="message-new-tag-name" class="text-danger d-none">Tag already exists</span>

                <label for="type-tag" class="form-label float-start mt-3">Type</label>
                <select id="type-tag" class="form-select mb-3" aria-label="Default select example">
                    <option value="DEFAULT_TAG" selected>Default Tag</option>
                    <option value="TAG_ADDED">Tag Normal</option>
                </select>
            </div>
            <div class="modal-footer">
                <button id="save-tag-name" type="button" class="btn btn-primary">ADD</button>
                <button type="button" class="btn btn-light" onclick="showEditTaskModal()">Back</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Edit Tag Name -->
<div class="modal fade" id="modal-edit-tag-name" aria-hidden="true" aria-labelledby="..." tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form>
                <div class="modal-header">
                    <h5 class="modal-title">Edit tag Name</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <label for="edit-tag-name" class="form-label float-start">Tag Name</label>
                    <input id="edit-tag-name" class="form-control" type="text" placeholder="Enter here..." required>

                    <label for="edit-type-tag" class="form-label float-start mt-2">Type</label>
                    <select id="edit-type-tag" class="form-select mb-3" aria-label="Default select example">
                        <option value="DEFAULT_TAG">Default Tag</option>
                        <option value="TAG_ADDED">Tag Normal</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button id="save-edit-tag-name" type="button" class="btn btn-primary" data-bs-target="#tagModal"
                            data-bs-toggle="modal" data-bs-dismiss="modal">Save
                    </button>
                    <button type="button" class="btn btn-light" data-bs-target="#tagModal" data-bs-toggle="modal"
                            data-bs-dismiss="modal">Back
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- Modal Add Pic --%>
<div id="picModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">PIC</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 border p-1" id="pic-selected" style="height: 45px"></div>
                <div class="mt-2 text-center align-items-center">
                    <div class="d-flex justify-content-between align-items-center">
                        <input type="text" id="searchPic" class="form-control" placeholder="Search Pic..."
                               style="width: 30%">
                    </div>
                    <div data-simplebar style="max-height: 400px">
                        <table class="table table-bordered mt-2 nowrap align-middle" id="table-pic">
                            <thead>
                            <tr>
                                <th>UserName</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="btn-save-pic" type="button" class="btn btn-primary" data-bs-dismiss="modal">Save Changes
                </button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%-- Modal Add Related Task--%>
<div id="relatedTaskModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 border p-1" id="related-task-selected" style="height: 45px"></div>
                <div class="mt-2 text-center align-items-center">
                    <div class="d-flex justify-content-between align-items-center">
                        <input type="text" id="searchTask" class="form-control" placeholder="Search Task..."
                               style="width: 30%">
                    </div>
                    <div data-simplebar style="max-height: 400px">
                        <table class="table table-bordered mt-2 nowrap align-middle" id="table-task">
                            <thead>
                            <tr>
                                <th>Title Task</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="btn-save-task" type="button" class="btn btn-primary" data-bs-dismiss="modal">Save Changes
                </button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!--end delete modal -->

<div class="modal fade flip" id="deleteFileTaskModal" aria-hidden="true" aria-labelledby="..." tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a file ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger" id="delete-file-comment" data-name="" data-bs-target="#editTaskModal" data-bs-toggle="modal" data-bs-dismiss="modal">Yes, Delete It</button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" data-bs-target="#editTaskModal" data-bs-toggle="modal" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/assets/custom/js/task/task.js"></script>
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>
<script src="/assets/custom/js/task/task-detail.js"></script>
<script>

    function createFileTask(file, isShowDeleteIcon) {

        var iconDelete = '';
        if (isShowDeleteIcon) {
            iconDelete = `<button type="button" class="delete-file border-0" data-name="` + file.fileName + `" data-bs-toggle="modal" data-bs-target="#deleteFileTaskModal"><i class="ri-delete-bin-fill align-bottom text-muted"></i></button>`;
        }

        return `<div class="col-lg-4 mb-1 file-container-item" data-name="` + file.fileName + `">
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
                                                    <h5 class="fs-13 mb-1"><a href="javascript:void(0);" class="text-body text-truncate d-block file-name-item" title="` + file.fileName + `">` + file.fileName + `</a></h5>
                                                    <div>` + bToKbShow(file.fileSize) + `Kb</div>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="d-flex gap-1 align-items-center">
                                                        <a href="` + file.url + `" class="btn btn-icon text-muted btn-sm fs-18"><i class="ri-download-2-line"></i></a>`
            + iconDelete +
            `</div>
                                                </div>
                                            </div>
                    </div>
                </div>`;
    }

    async function showEditTaskForm(rs) {

        return new Promise(async (resolve, reject) => {

            var filesTask = rs.filesTask;

            // files
            var files = ``;
            if (filesTask && filesTask.length > 0) {
                try {
                    await handleFilesAsync(filesTask, function (fileName, fileSize, url) {
                        files += createFileTask({fileName: fileName, fileSize: fileSize, url: url}, true);
                    });
                } catch (error) {
                    console.error(error);
                }
            }

            const taskHTML = ` <form id="editTaskForm">
                <div class="modal-body" data-simplebar style="max-height: 800px">
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <label for="selectUsernameEdit" class="form-label">Username: <span
                                    class="username-edit-task"></span></label>
                            <select id="selectUsernameEdit" name="userId" class="form-select d-none"
                                    aria-label="Default select example">
                            </select>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="title" class="form-label">Title</label>
                                <input type="text" id="title-edit" name="title" class="form-control"
                                       placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
            <div class="col-lg-12">
            <label for="content" class="form-label">Content</label>
            <div id="content-edit" class="snow-editor h-auto"></div>
            <small class="form-message"></small>
            </div>
            <div class="col-lg-12">
            <label class="form-label">Old files</label>
            <div class="row mb-1">`
                + files +
                `</div>
            </div>
            <div class="col-lg-12">
            <label class="form-label">Attach file</label>
            <div class="card-body">
            <div class="dropzone">
            <div class="fallback">
            <input name="fileList" type="file" multiple="multiple">
            </div>
            <div class="dz-message needsclick">
            <div class="mb-3">
            <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
            </div>
            <h4>Drop files here or click to upload.</h4>
            </div>
            </div>
            <ul class="list-unstyled mb-0" id="dropzone-preview">
            <li class="mt-2" id="dropzone-preview-list">
            <div class="border rounded">
            <div class="d-flex p-2">
            <div class="flex-shrink-0 me-3">
            <div class="avatar-sm bg-light rounded">
            <div class="avatar-title bg-light text-secondary rounded fs-24">
            <i class="ri-file-upload-line"></i>
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
            <div class="message-error-file"></div>
            </div>
            </div>
            <div class="col-lg-6">
            <label for="selectActionEdit" class="form-label">Status:<span
            id="statusTaskEdit"></span></label>
            <select id="selectActionEdit" name="action" class="form-control"></select>
            </div>
            <div class="col-lg-6">
            <label for="selectProgressEdit" class="form-label">Progress</label>
            <select id="selectProgressEdit" name="progress" class="form-control">
            <option value="0">0</option>
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="15">15</option>
            <option value="20">20</option>
            <option value="25">25</option>
            <option value="30">30</option>
            <option value="35">35</option>
            <option value="40">40</option>
            <option value="45">45</option>
            <option value="50">50</option>
            <option value="55">55</option>
            <option value="60">60</option>
            <option value="65">65</option>
            <option value="70">70</option>
            <option value="75">75</option>
            <option value="80">80</option>
            <option value="85">85</option>
            <option value="90">90</option>
            <option value="95">95</option>
            <option value="100">100</option>
            </select>
            </div>
            <div class="col-lg-6">
            <label for="dueDateEdit" class="form-label">Due date</label>
            <input type="date" id="dueDateEdit" class="form-control"
             data-provider="flatpickr" placeholder="Due date"/>
            <small class="form-message"></small>
            </div>
            <div class="col-lg-6">
            <label for="selectPriority" class="form-label">Priority</label>
            <select id="selectPriorityEdit" name="priority" class="form-control">
            <option value="LOW">Low</option>
            <option value="MEDIUM">Medium</option>
            <option value="HIGH">High</option>
            </select>
            </div>
            <div class="col-lg-6 d-flex align-items-center">
            <label class="form-label m-0">Tag: </label>
            <div id="show-tag" class="d-flex align-items-center">

            </div>
            </div>
            <div class="col-lg-6 d-flex align-items-center">
            <label class="form-label m-0">Pic: </label>
            <div id="show-pic" class="d-flex align-items-center">

            </div>
            </div>
            <div class="col-lg-12 d-flex align-items-center">
            <label class="form-label m-0">Related Task: </label>
            <div id="show-related-task" class="d-flex align-items-center">

            </div>
            </div>
            </div>
            </div>
            <div class="modal-footer">
            <div class="hstack gap-2 justify-content-end">
            <button type="submit" class="btn btn-success btn-load" id="update-task-btn">
            <span class="d-flex align-items-center">
            <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
            <span class="flex-grow-1">Update</span>
            </span>
            </button>
            <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close
            </button>
            </div>
            </div>
            </form>`;
            resolve(taskHTML);
        });
    }

    $(document).on('click', '.delete-file', function (e){
        var name = $(this).data('name');
        $('#delete-file-comment').attr('data-name', name);
    });

    $(document).on('click', '#delete-file-comment', function (e) {
        var name = $(this).attr('data-name');
        $(".file-container-item[data-name='" + name + "']").remove();
        $('#deleteFileTaskModal').modal('hide');
    });

    var tasksRequest = {
        page: 1,
        pageSize: $('#page-count-select').val(),
        statusTask: '',
        picSearch: '',
        tagSearch: '',
        titleSearch: ''
    }
    var tableTask = null;

    $(document).ready(function () {

        var swal = showAlertLoading();

        loadCountStatus().then(function (rs) {
            swal.close();
        }).catch(function (error) {
            console.error("Error loading task counts:", error);
        });
        $('#tasksTable').DataTable().destroy();
        tableTask = $('#tasksTable').DataTable({
            ajax: {
                url: '/api/v1/tasks',
                contentType: 'application/json',
                method: 'POST',
                data: function (d) {
                    return JSON.stringify(tasksRequest);
                },
                dataSrc: function (json) {
                    if (json.length != 0) {
                        loadPaging();
                        $('#pagination').addClass('mt-4');
                    } else {
                        removePagingIfExsit();
                        $('#pagination').removeClass('mt-4');
                    }
                    return json;
                }
            },
            columns: [
                {
                    render: function (data, type, row) {
                        if (!isAdminOrUserLogin(row.user.id)) return '';
                        return `<th scope="row">
                            <div class="form-check">
                                <input data-id="` + row.id + `" class="form-check-input" type="checkbox" name="chk_child" value="option1">
                            </div>
                        </th>`;
                    }
                },
                {
                    data: 'id',
                    render: function (data, type, row) {
                        return `<a class="fw-medium link-primary">` + data + `</a>`;
                    }
                },
                {
                    data: 'statusTask.code',
                    render: function (data, type, row) {
                        var colorClass = getStatusColor(data);
                        return '<span class="badge ' + colorClass + '">' + data + '</span>';
                    }
                },
                {
                    data: 'title',
                    render: function (data, type, row) {
                        var editAndRemoveE = '';
                        if (isAdminOrUserLogin(row.user.id)) {
                            editAndRemoveE = `<li class="list-inline-item"><a class="edit-item-task-btn" href="#" data-id="` + row.id + `"><i class="ri-pencil-fill align-bottom me-2 text-muted"></i></a></li>
                                            <li class="list-inline-item">
                                                <a class="remove-item-task-btn" data-bs-toggle="modal" href="#deleteTaskModal" data-id="` + row.id + `">
                                                    <i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i>
                                                </a>
                                            </li>`;
                        }
                        return `<div class="d-flex">
                                    <div class="flex-grow-1 tasks_name"><a class="fw-medium link-primary text-decoration-underline" href="/tasks/` + row.id + `">` + data + `</a></div>
                                    <div class="flex-shrink-0 ms-4">
                                        <ul class="list-inline tasks-list-menu mb-0">
                                            <li class="list-inline-item"><a href="/tasks/` + row.id + `"><i class="ri-eye-fill align-bottom me-2 text-muted"></i></a></li>`
                            + editAndRemoveE + `
                                        </ul>
                                    </div>
                                </div>`;
                    }
                },
                {data: 'pic'},
                {
                    data: 'priority.code',
                    render: function (data, type, row) {
                        var colorClass = getPriorityColor(data);
                        return `<span class="badge ` + colorClass + ` text-uppercase">` + data + `</span>`;
                    }
                },
                {
                    data: 'progress',
                    render: function (data, type, row) {
                        return getProgressE(data);
                    }
                },
                {data: 'startDate'},
                {data: 'dueOrCloseDate'},
                {data: 'tag'}
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        $('.search-task').on('input', function () {
            tasksRequest.picSearch = $('#picSearch').val();
            tasksRequest.tagSearch = $('#tagSearch').val();
            tasksRequest.titleSearch = $('#titleSearch').val();
            // Filter by task
            document.querySelectorAll('.task-status').forEach(function (e) {
                e.addEventListener('click', function () {
                    var taskStatus = this.getAttribute('data-value');
                    tasksRequest.statusTask = taskStatus;
                })
            })
            tasksRequest.page = 1;
            tableTask.ajax.reload(function () {
            });
        });

        // Filter by status
        document.querySelectorAll('.task-status').forEach(function (e) {
            e.addEventListener('click', function () {
                var taskStatus = this.getAttribute('data-value');
                tasksRequest.statusTask = taskStatus;
                tasksRequest.page = 1;

                tableTask.ajax.reload(function () {
                });
            })
        })

        $('#page-count-select').on('change', function () {

            var selectE = $(this);
            var selectedValue = selectE.val();
            tasksRequest.page = 1;
            tasksRequest.pageSize = selectedValue;

            var divParent = selectE.closest('div');
            divParent.find('.spinner-border').removeClass('d-none');
            tableTask.ajax.reload(function () {
                divParent.find('.spinner-border').addClass('d-none');
            });
        });
    });

    function removePagingIfExsit() {
        if (window.pagObj) {
            window.pagObj.twbsPagination('destroy');
        }
    }

    function loadPaging() {
        callAjaxByJsonWithData('/api/v1/tasks/count', 'POST', tasksRequest, function (totalItem) {

            removePagingIfExsit();

            //paging
            var totalPages = 0;
            if (totalItem <= tasksRequest.pageSize) totalPages = 1;
            else totalPages = Math.ceil(totalItem / tasksRequest.pageSize);
            var currentPage = tasksRequest.page;

            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        if (currentPage != page) {
                            tasksRequest.page = page;
                            tableTask.ajax.reload();
                            currentPage = page;
                        }
                    }
                });
            });
        });
    }

    $(document).on('click', '#delete-mul-task', function (e) {
        var checkedIds = [];
        $('#tasksTable input[type="checkbox"]:checked').not('#checkAll').each(function () {
            var id = $(this).data('id');
            checkedIds.push(id);
        });

        if (checkedIds.length != 0) {
            Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn btn-primary w-xs me-2 mt-2",
                cancelButtonClass: "btn btn-danger w-xs mt-2",
                confirmButtonText: "Yes, delete it!",
                buttonsStyling: false,
                showCloseButton: true
            }).then(function (e) {
                if (e.isConfirmed) {
                    Swal.close();

                    var swal = showAlertLoading();
                    callAjaxByJsonWithData("/api/v1/tasks/", "DELETE", checkedIds, function (rs) {
                        tableTask.ajax.reload(function () {
                            $('#checkAll').prop('checked', false);

                            loadCountStatus();
                            swal.close();
                            showAlert(SUCCESS_ALERT, 'Delete success!');
                        });
                    });
                }
            });
        } else {
            Swal.fire({
                title: "Please select at least one checkbox",
                confirmButtonClass: "btn btn-info",
                buttonsStyling: false,
                showCloseButton: true
            });
        }
    });

    $(document).on('click', '.remove-item-task-btn', function (e) {
        var idTask = $(this).data('id');
        $('#delete-task').attr('data-id', idTask);
    });

    $(document).on('click', '#delete-task', function (e) {
        var idTask = $(this).attr('data-id');
        $('#deleteTaskModal .spinner-border').removeClass('d-none');
        callAjaxByJsonWithData("/api/v1/tasks/" + idTask, "DELETE", null, function (rs) {
            tableTask.ajax.reload(function () {
                $('#deleteTaskModal .spinner-border').addClass('d-none');
                $("#deleteTaskModal").modal("hide");
                showAlert(SUCCESS_ALERT, 'Delete success!');
                loadCountStatus();
            });
        });
    });

    $(document).on('click', '#checkAll', function (e) {
        if ($(this).prop('checked')) {
            $('#tasksTable input[type="checkbox"]').prop('checked', true);
        } else {
            $('#tasksTable input[type="checkbox"]').prop('checked', false);
        }
    });

    $(document).on('click', '.edit-item-task-btn', function (e) {
        function showListTag() {
            callAjaxByJsonWithData('/api/v1/tags', 'GET', null, function (rs) {
                let table = new DataTable('#scroll-vertical', {
                    "scrollY": "210px",
                    "scrollCollapse": true,
                    "paging": false,
                    "searching": false,
                    "ordering": false,
                    "info": false
                });

                const defaultTagNames = [];
                const tagAddedTagNames = [];

                rs.forEach(function (item) {
                    let obj = {
                        id: item.id,
                        tagName: item.tagName,
                        type: item.type.code
                    };
                    if (item.type.code == 'DEFAULT_TAG') defaultTagNames.push(obj);
                    else if (item.type.code == 'TAG_ADDED') tagAddedTagNames.push(obj);
                })
                const dataBody = document.getElementById('dataBody');

                displayData(defaultTagNames, tagAddedTagNames);

                document.getElementById('searchTag').addEventListener('input', function () {
                    var searchText = this.value.toLowerCase();

                    var filteredData1 = defaultTagNames.filter(item => item.tagName.toLowerCase().includes(searchText));
                    var filteredData2 = tagAddedTagNames.filter(item => item.tagName.toLowerCase().includes(searchText));

                    displayData(filteredData1, filteredData2);
                });

                function displayData(data1, data2) {
                    dataBody.innerHTML = '';

                    var maxRows = Math.max(data1.length, data2.length);

                    for (var i = 0; i < maxRows; i++) {
                        var row = document.createElement('tr');
                        var cell1 = document.createElement('td');
                        var cell2 = document.createElement('td');
                        var div1 = document.createElement('div');
                        var div2 = document.createElement('div');
                        var span1 = document.createElement('span');
                        var span2 = document.createElement('span');

                        div1.classList.add('d-flex', 'justify-content-center');
                        div2.classList.add('d-flex', 'justify-content-center');
                        span1.classList.add('tag-name', 'cursor-pointer');
                        span2.classList.add('tag-name', 'cursor-pointer');

                        if (i < data1.length) {
                            span1.textContent = data1[i].tagName;
                            span1.setAttribute('data-value', data1[i].id);
                            span1.setAttribute('data-type', data1[i].type);
                        }
                        if (i < data2.length) {
                            span2.textContent = data2[i].tagName;
                            span2.setAttribute('data-value', data2[i].id);
                            span2.setAttribute('data-type', data2[i].type);
                        }

                        div1.appendChild(span1);
                        div2.appendChild(span2);
                        cell1.appendChild(div1);
                        cell2.appendChild(div2);


                        if (i < data1.length) {
                            div1.innerHTML += `
                            <div class="dropdown">
                                <a href="#" role="button" id="dropdownMenuLink1_${i}" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="ri-more-2-fill"></i>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink1_${i}">
                                    <li><a class="dropdown-item edit-tag" href="#" data-bs-toggle="modal" data-bs-target="#modal-edit-tag-name" data-bs-dismiss="modal">Edit</a></li>
                                    <li><a class="dropdown-item del-tag" href="#">Delete</a></li>
                                </ul>
                            </div>
                        `;
                        }
                        if (i < data2.length) {
                            div2.innerHTML += `
                            <div class="dropdown">
                                <a href="#" role="button" id="dropdownMenuLink2_${i}" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="ri-more-2-fill"></i>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink2_${i}">
                                    <li><a class="dropdown-item edit-tag" href="#" data-bs-toggle="modal" data-bs-target="#modal-edit-tag-name" data-bs-dismiss="modal">Edit</a></li>
                                    <li><a class="dropdown-item del-tag" href="#">Delete</a></li>
                                </ul>
                            </div>
                        `;
                        }

                        row.appendChild(cell1);
                        row.appendChild(cell2);
                        dataBody.appendChild(row);
                    }

                    // Handle Update Tag
                    var idTagEdit = '';
                    document.querySelectorAll('.edit-tag').forEach(function (eEdit) {
                        eEdit.addEventListener('click', function (e) {
                            var tag = eEdit.closest('.d-flex').querySelector('span.tag-name');
                            idTagEdit = tag.getAttribute('data-value');
                            var tagName = tag.textContent.substring(1);
                            var typeTag = tag.getAttribute('data-type');
                            const editTagName = document.getElementById('edit-tag-name');
                            editTagName.value = tagName;

                            document.querySelectorAll('#edit-type-tag option').forEach(function (option) {
                                if (typeTag === option.value) option.selected = true;
                                else option.selected = false;
                            });
                        })
                    })

                    document.getElementById('save-edit-tag-name').addEventListener('click', function () {
                        const formDataEdiTag = new FormData();
                        const tagName = document.getElementById('edit-tag-name');
                        const typeTag = document.getElementById('edit-type-tag');
                        formDataEdiTag.append('id', idTagEdit);
                        formDataEdiTag.append('tagName', '#' + tagName.value);
                        formDataEdiTag.append('type', typeTag.value);

                        callAjaxByJsonWithDataForm("/api/v1/tags/updation", "POST", formDataEdiTag, function (rs) {
                            showListTag()
                        });
                    })

                    // Handle Delete Tag
                    document.querySelectorAll('.del-tag').forEach(function (eDel) {
                        eDel.addEventListener('click', function () {
                            var idTag = eDel.closest('.d-flex').querySelector('span.tag-name').getAttribute('data-value');
                            callAjaxByJsonWithData("/api/v1/tags/" + idTag, "DELETE", null, function (rs) {
                                showListTag()
                            });
                        })
                    })
                }

                const tagSelected = document.getElementById('tag-selected');
                const tagsDbSelected = document.getElementById('tag-db-selected').textContent;
                const selectedTagsArray = tagsDbSelected.split(',').map(tag => tag.trim()).filter(tag => tag !== '');
                if (tagsDbSelected.textContent != '') {
                    selectedTagsArray.forEach(function (eTag) {
                        tagSelected.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 tag-selected">
                                    <i class="ri-close-line label-icon align-middle fs-16 ms-2 remove-tag-selected"></i> ` + eTag + `</button>`
                    })
                }
                document.querySelectorAll('.remove-tag-selected').forEach(function (eRemove) {
                    eRemove.addEventListener('click', function () {
                        const btnRemoveTag = eRemove.parentElement;
                        if (btnRemoveTag) btnRemoveTag.classList.add('d-none');
                        const removedTagName = btnRemoveTag.textContent.trim();
                        const index = selectedTagsArray.indexOf(removedTagName);
                        if (index !== -1) {
                            selectedTagsArray.splice(index, 1);
                        }
                    });
                });
                document.querySelectorAll('.tag-name').forEach(function (e) {
                    e.addEventListener('click', function () {
                        const tagName = e.textContent;
                        if (!selectedTagsArray.includes(tagName.trim())) {
                            selectedTagsArray.push(tagName.trim());
                            if (tagName.trim() != '') {
                                tagSelected.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 tag-selected">
                    <i class="ri-close-line label-icon align-middle fs-16 ms-2 remove-tag-selected"></i> ` + tagName + `</button>`;
                            }
                            document.querySelectorAll('.remove-tag-selected').forEach(function (eRemove) {
                                eRemove.addEventListener('click', function () {
                                    const btnRemoveTag = eRemove.parentElement;
                                    if (btnRemoveTag) btnRemoveTag.classList.add('d-none');
                                    const removedTagName = btnRemoveTag.textContent.trim();
                                    const index = selectedTagsArray.indexOf(removedTagName);
                                    if (index !== -1) {
                                        selectedTagsArray.splice(index, 1);
                                    }
                                });
                            });
                        }
                    });
                });
            });
        }

        var idTask = $(this).data('id');

        var swal = showAlertLoading();
        callAjaxByJsonWithData('/api/v1/tasks/' + idTask, "GET", null, function (rs) {
            var dropzone = '';
            callAjaxByJsonWithData('/api/v1/settings/code?code='+ S_TASK, 'GET', null, function (setting) {
                setTimeout(function() {
                    dropzone = activeFile("#editTaskForm", setting);
                }, 100);

                swal.close();
            }, function (err) {
                swal.close();
            });

            var editContainer = $("#editTaskForm");
            showEditTaskForm(rs)
                .then(function (commentHTML) {
                    editContainer.html(commentHTML);

                    $('#title-edit').val(rs.title);

                    $('#content-edit').html(rs.content);
                    $('#editTaskForm .ql-toolbar.ql-snow').remove();
                    activeEditor("#editTaskForm");

                    var statusCode = rs.statusTask.code;
                    $('#statusTaskEdit').replaceWith('<span id="statusTaskEdit" class="badge ' + getStatusColor(statusCode) + '">' + statusCode + '</span>');

                    $('#selectActionEdit').html('<option value="">-- Select actions --</option>');
                    rs.statusTask.actions.forEach(function (action) {
                        var option = $('<option></option>');
                        option.attr('value', action.code);
                        option.text(action.name);
                        $('#selectActionEdit').append(option);
                    });

                    $('#selectProgressEdit').val(rs.progress);

                    if (!isBlank(rs.dueDate)) {
                        $('#dueDateEdit').val(formatDateValueToValueOfInputDate(rs.dueDate));
                        $('#dueDateEdit').attr('data-provider', 'flatpickr');
                    } else {
                        $('#dueDateEdit').val('');
                    }

                    $('#selectPriorityEdit').val(rs.priority.code);

                    // Tag
                    const sessionTag = document.getElementById('show-tag');
                    sessionTag.innerHTML = `<span id="tag-db-selected" class="fw-bold ms-2">` + rs.tag + `</span> <i id="btn-edit-tag" class="ri-edit-line fs-5 cursor-pointer ms-1"></i>`;

                    const btnEditTag = document.getElementById('btn-edit-tag');
                    if (btnEditTag) {
                        btnEditTag.addEventListener('click', function () {
                            var modal = new bootstrap.Modal(document.getElementById('tagModal'));
                            modal.show();
                            if (!this.clicked) {
                                this.clicked = true;
                                showListTag();
                            }

                        })
                    }

                    document.getElementById('save-tag-selected').addEventListener('click', function () {
                        var tagsSelected = '';
                        document.querySelectorAll('.tag-selected').forEach(function (eTag, index) {
                            if (!eTag.classList.contains('d-none')) {
                                const tagText = eTag.textContent.trim();
                                if (tagsSelected.length > 0) {
                                    tagsSelected += ', ';
                                }
                                tagsSelected += tagText;
                            }
                        });

                        const showTagSelect = document.getElementById('show-tag');
                        showTagSelect.innerHTML = `<span class="fw-bold ms-2" id="tag-db-selected">` + tagsSelected + `</span> <i id="btn-edit-tag" class="ri-edit-line fs-5 cursor-pointer ms-1"></i>`;

                        const btnEditTag = document.getElementById('btn-edit-tag');
                        if (btnEditTag) {
                            btnEditTag.addEventListener('click', function () {
                                var modal = new bootstrap.Modal(document.getElementById('tagModal'));
                                modal.show();
                            })
                        }
                    })

                    // Handle Click button add tag name
                    const btnAddTagName = document.getElementById('save-tag-name');
                    const messageTag = document.getElementById('message-new-tag-name');
                    btnAddTagName.addEventListener('click', function () {
                        const tagName = document.getElementById('new-tag-name');
                        const specialTag = '#' + tagName.value.trim();
                        var isDoubleTag = false;
                        document.querySelectorAll('.tag-name').forEach(function (eTagName) {
                            if (eTagName.textContent.trim() == specialTag) {
                                isDoubleTag = true;
                                messageTag.classList.remove('d-none');
                            }
                        })
                        if (isDoubleTag == false && tagName.value.trim() != '') {
                            messageTag.classList.add('d-none');
                            var formData = new FormData();
                            const typeTag = document.getElementById('type-tag');
                            formData.append('tagName', '#' + tagName.value.trim());
                            formData.append('type', typeTag.value);
                            callAjaxByJsonWithDataForm("/api/v1/tags/createTag", "POST", formData, function (rs) {
                                tagName.value = '';
                                var modal = new bootstrap.Modal(document.getElementById('editTaskModal'));
                                modal.show();
                                $('#add-tag-name').modal('hide');
                                showListTag();
                            });
                        }
                    })

                    // Pic
                    const sessionPic = document.getElementById('show-pic');
                    sessionPic.innerHTML = `<span class="fw-bold ms-2" id="pic-db-selected">` + rs.pic + `</span> <i id="btn-edit-pic" class="ri-edit-line fs-5 cursor-pointer ms-1"></i>`;

                    const btnEditPic = document.getElementById('btn-edit-pic');
                    if (btnEditPic) {
                        btnEditPic.addEventListener('click', function () {
                            var modal = new bootstrap.Modal(document.getElementById('picModal'));
                            modal.show();
                            if (!this.clicked) {
                                this.clicked = true;

                                callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs) {
                                    rs.forEach(function (user) {
                                        const tablePic = document.getElementById('table-pic');
                                        const tbody = tablePic.querySelector('tbody');
                                        const pic = `<tr><td class="cursor-pointer pic-username">` + user.fullname + `</td></tr>`;
                                        tbody.innerHTML += pic;
                                    });

                                    const picSelected = document.getElementById('pic-selected');
                                    const picsDbSelected = document.getElementById('pic-db-selected').textContent;
                                    const selectedPicsArray = picsDbSelected.split(',').map(pic => pic.trim()).filter(pic => pic !== '');
                                    if (picsDbSelected != '') {
                                        selectedPicsArray.forEach(function (ePic) {
                                            picSelected.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 pic-selected">
                                    <i class="ri-close-line label-icon align-middle fs-16 ms-2 remove-pic-selected"></i> ` + ePic + `</button>`
                                        })
                                    }
                                    document.querySelectorAll('.remove-pic-selected').forEach(function (eRemove) {
                                        eRemove.addEventListener('click', function () {
                                            const btnRemovePic = eRemove.parentElement;
                                            if (btnRemovePic) btnRemovePic.classList.add('d-none');
                                            const removedPicName = btnRemovePic.textContent.trim();
                                            const index = selectedPicsArray.indexOf(removedPicName);
                                            if (index !== -1) {
                                                selectedPicsArray.splice(index, 1);
                                            }
                                        });
                                    });
                                    document.querySelectorAll('.pic-username').forEach(function (ePic) {
                                        ePic.addEventListener('click', function () {
                                            const picName = ePic.textContent;
                                            if (!selectedPicsArray.includes(picName.trim())) {
                                                selectedPicsArray.push(picName.trim());
                                                if (picName.trim() != '') {
                                                    picSelected.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 pic-selected">
                    <i class="ri-close-line label-icon align-middle fs-16 ms-2 remove-pic-selected"></i> ` + picName + `</button>`;
                                                }
                                                document.querySelectorAll('.remove-pic-selected').forEach(function (eRemove) {
                                                    eRemove.addEventListener('click', function () {
                                                        const btnRemovePic = eRemove.parentElement;
                                                        if (btnRemovePic) btnRemovePic.classList.add('d-none');
                                                        const removedPicName = btnRemovePic.textContent.trim();
                                                        const index = selectedPicsArray.indexOf(removedPicName);
                                                        if (index !== -1) {
                                                            selectedPicsArray.splice(index, 1);
                                                        }
                                                    });
                                                });
                                            }
                                        });
                                    });

                                    const searchInput = document.getElementById('searchPic');

                                    const rows = document.querySelectorAll('#table-pic tbody tr');

                                    searchInput.addEventListener('input', function () {
                                        const searchText = this.value.trim().toLowerCase();

                                        rows.forEach(function (row) {
                                            const cells = row.querySelectorAll('.pic-username');
                                            let found = false;

                                            cells.forEach(function (cell) {
                                                const cellText = cell.textContent.trim().toLowerCase();
                                                if (cellText.includes(searchText)) {
                                                    found = true;
                                                }
                                            });

                                            if (found) {
                                                row.style.display = '';
                                            } else {
                                                row.style.display = 'none';
                                            }
                                        });
                                    });

                                    document.getElementById('btn-save-pic').addEventListener('click', function () {
                                        var picsSelected = '';
                                        document.querySelectorAll('.pic-selected').forEach(function (ePic, index) {
                                            if (!ePic.classList.contains('d-none')) {
                                                const picText = ePic.textContent.trim();
                                                if (picsSelected.length > 0) {
                                                    picsSelected += ', ';
                                                }
                                                picsSelected += picText;
                                            }
                                        });

                                        const showPicSelect = document.getElementById('show-pic');
                                        showPicSelect.innerHTML = `<span class="fw-bold ms-2" id="pic-db-selected">` + picsSelected + `</span> <i id="btn-edit-pic" class="ri-edit-line fs-5 cursor-pointer ms-1"></i>`;

                                        const btnEditPic = document.getElementById('btn-edit-pic');
                                        if (btnEditPic) {
                                            btnEditPic.addEventListener('click', function () {
                                                var modal = new bootstrap.Modal(document.getElementById('picModal'));
                                                modal.show();
                                            })
                                        }
                                    })
                                });
                            }
                        })
                    }

                    // Related Task
                    const sessionRelatedTask = document.getElementById('show-related-task');
                    sessionRelatedTask.innerHTML = `<span class="fw-bold ms-2" id="relatedTask-db-selected">` + rs.relatedTask + `</span> <i id="btn-edit-related-task" class="ri-edit-line fs-5 cursor-pointer ms-1"></i>`;

                    const btnEditRelatedTask = document.getElementById('btn-edit-related-task');
                    if (btnEditRelatedTask) {
                        btnEditRelatedTask.addEventListener('click', function () {
                            var modal = new bootstrap.Modal(document.getElementById('relatedTaskModal'));
                            modal.show();
                            if (!this.clicked) {
                                this.clicked = true;

                                callAjaxByJsonWithData('/api/v1/tasks/titles', 'GET', null, function (rs) {
                                    rs.forEach(function (task) {
                                        const tableTask = document.getElementById('table-task');
                                        const tbody = tableTask.querySelector('tbody');
                                        const titleTask = `<tr><td class="cursor-pointer task-title">` + task.title + `</td></tr>`;
                                        tbody.innerHTML += titleTask;
                                    });

                                    const relatedTaskSelected = document.getElementById('related-task-selected');
                                    const relatedTaskDbSelected = document.getElementById('relatedTask-db-selected').textContent;
                                    const selectedTasksArray = relatedTaskDbSelected.split(',').map(relatedTask => relatedTask.trim()).filter(relatedTask => relatedTask !== '');
                                    if (relatedTaskDbSelected != '') {
                                        selectedTasksArray.forEach(function (eRelatedTask) {
                                            relatedTaskSelected.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 related-task-selected">
                                    <i class="ri-close-line label-icon align-middle fs-16 ms-2 remove-related-task-selected"></i> ` + eRelatedTask + `</button>`
                                        })
                                    }

                                    document.querySelectorAll('.remove-related-task-selected').forEach(function (eRemove) {
                                        eRemove.addEventListener('click', function () {
                                            const btnRemoveRelatedTask = eRemove.parentElement;
                                            if (btnRemoveRelatedTask) btnRemoveRelatedTask.classList.add('d-none');
                                            const removedTaskTitle = btnRemoveRelatedTask.textContent.trim();
                                            const index = selectedTasksArray.indexOf(removedTaskTitle);
                                            if (index !== -1) {
                                                selectedTasksArray.splice(index, 1);
                                            }
                                        });
                                    });

                                    document.querySelectorAll('.task-title').forEach(function (eTask) {
                                        eTask.addEventListener('click', function () {
                                            const taskTitle = eTask.textContent;
                                            if (!selectedTasksArray.includes(taskTitle.trim())) {
                                                selectedTasksArray.push(taskTitle.trim());
                                                if (taskTitle.trim() != '') {
                                                    relatedTaskSelected.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 related-task-selected">
                    <i class="ri-close-line label-icon align-middle fs-16 ms-2 remove-related-task-selected"></i> ` + taskTitle + `</button>`;
                                                }
                                                document.querySelectorAll('.remove-related-task-selected').forEach(function (eRemove) {
                                                    eRemove.addEventListener('click', function () {
                                                        const btnRemoveRelatedTask = eRemove.parentElement;
                                                        if (btnRemoveRelatedTask) btnRemoveRelatedTask.classList.add('d-none');
                                                        const removedTaskTitle = btnRemoveRelatedTask.textContent.trim();
                                                        const index = selectedTasksArray.indexOf(removedTaskTitle);
                                                        if (index !== -1) {
                                                            selectedTasksArray.splice(index, 1);
                                                        }
                                                    });
                                                });
                                            }
                                        });
                                    });


                                    const searchInput = document.getElementById('searchTask');

                                    const rows = document.querySelectorAll('#table-task tbody tr');

                                    searchInput.addEventListener('input', function () {
                                        const searchText = this.value.trim().toLowerCase();

                                        rows.forEach(function (row) {
                                            const cells = row.querySelectorAll('.task-title');
                                            let found = false;

                                            cells.forEach(function (cell) {
                                                const cellText = cell.textContent.trim().toLowerCase();
                                                if (cellText.includes(searchText)) {
                                                    found = true;
                                                }
                                            });

                                            if (found) {
                                                row.style.display = '';
                                            } else {
                                                row.style.display = 'none';
                                            }
                                        });
                                    });

                                    document.getElementById('btn-save-task').addEventListener('click', function () {
                                        var taskSelected = '';
                                        document.querySelectorAll('.related-task-selected').forEach(function (eRelatedTask, index) {
                                            if (!eRelatedTask.classList.contains('d-none')) {
                                                const relatedTaskText = eRelatedTask.textContent.trim();
                                                if (taskSelected.length > 0) {
                                                    taskSelected += ', ';
                                                }
                                                taskSelected += relatedTaskText;
                                            }
                                        });
                                        const showTaskSelect = document.getElementById('show-related-task');
                                        showTaskSelect.innerHTML = `<span class="fw-bold ms-2" id="relatedTask-db-selected">` + taskSelected + `</span> <i id="btn-edit-related-task" class="ri-edit-line fs-5 cursor-pointer ms-1"></i>`;

                                        const btnEditRelatedTask = document.getElementById('btn-edit-related-task');
                                        if (btnEditRelatedTask) {
                                            btnEditRelatedTask.addEventListener('click', function () {
                                                var modal = new bootstrap.Modal(document.getElementById('relatedTaskModal'));
                                                modal.show();
                                            })
                                        }
                                    })
                                });
                            }
                        })
                    }

                    //handle case
                    if ([T_REGISTERED, T_POSTPONED, T_CLOSED].includes(statusCode)) {
                        $('#selectProgressEdit').prop('disabled', true);
                    } else $('#selectProgressEdit').prop('disabled', false);

                    if (statusCode == T_POSTPONED) {
                        $('#selectPriorityEdit').prop('disabled', true);
                    } else $('#selectPriorityEdit').prop('disabled', false);

                    var selectElement = $('#selectUsernameEdit');
                    selectElement.empty();
                    // username
                    if (isDeleveloper()) {
                        $('.username-edit-task').text(rs.user.fullname);
                        var option = $('<option></option>');
                        option.attr('value', rs.user.id);
                        option.text(rs.user.fullname);
                        selectElement.append(option);
                        $('button[data-bs-target="#add-tag-name"]').addClass('d-none');
                        swal.close();
                        $('#editTaskModal').modal('show');
                    } else {
                        callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (users) {
                            users.forEach(function (user) {
                                var option = $('<option></option>');
                                option.attr('value', user.id);
                                option.text(user.fullname);

                                if (user.id == rs.user.id) {
                                    option.attr('selected', 'selected');
                                }

                                selectElement.append(option);
                            });

                            $('#selectUsernameEdit').removeClass('d-none');

                            swal.close();
                            $('#editTaskModal').modal('show');
                        });
                    }
                }).catch(function (error) {
                console.error(error);
            });

            Validator({
                form: '#editTaskForm',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#title-edit'),
                    Validator.isRequired('#content-edit'),
                    Validator.isThen("#dueDateEdit", function () {
                        var status = $('#statusTaskEdit').text();
                        var action = $('#selectActionEdit').val();
                        var dueDate = $('#dueDateEdit').val();

                        if (status == T_REGISTERED) {
                            if (action == '') {
                                if (dueDate == '') return 1; // valid
                                return 2; // validate dueday
                            } else {
                                if (dueDate == '') return 3; // dueday empty
                                return 2;
                            }
                        } else {
                            if (dueDate == '') return 3;

                            if (status == T_POSTPONED && action != '') {
                                return 2;
                            }
                            return 1;
                        }
                    })
                ],
                onSubmit: function (formData) {
                    formData.append('id', idTask);
                    formData.append('content', $('#content-edit').html());
                    const tagSelected = document.getElementById('tag-db-selected');
                    const picSelected = document.getElementById('pic-db-selected');
                    const relatedTaskSelected = document.getElementById('relatedTask-db-selected');
                    var tag = '', pic = '', relatedTask = '';
                    if (tagSelected) tag = tagSelected.textContent;
                    if (picSelected) pic = picSelected.textContent;
                    if (relatedTaskSelected) relatedTask = relatedTaskSelected.textContent;
                    formData.append('tag', tag)
                    formData.append('pic', pic);
                    formData.append('relatedTask', relatedTask)
                    var dateString = document.getElementById('dueDateEdit').value;
                    var dueDate = new Date(dateString);
                    formData.append('dueDate', dueDate);
                    var oldFiles = $('#editTaskForm').find('a.file-name-item').map(function() {
                        return $(this).text();
                    }).get().join(',');
                    formData.append('remainFiles', oldFiles);

                    dropzone.files.forEach((file) => {
                        formData.append('filesTask', file);
                    });

                    $('#editTaskForm .spinner-border').removeClass('d-none');
                    callAjaxByDataFormWithDataForm("/api/v1/tasks/updation", "POST", formData, function (rs) {
                        tableTask.ajax.reload(function () {
                            $('#editTaskForm .spinner-border').addClass('d-none');
                            $("#editTaskModal").modal("hide");
                            showAlert(SUCCESS_ALERT, 'Update success!');
                            loadCountStatus();
                            window.location.reload();
                        });
                    });
                }
            });
        });
    });

    $('#reset-search').on('click', function () {
        $('.search-task').val('');
        tasksRequest.picSearch = $('#picSearch').val();
        tasksRequest.tagSearch = $('#tagSearch').val();
        tasksRequest.titleSearch = $('#titleSearch').val();
        // Filter by task
        document.querySelectorAll('.task-status').forEach(function (e) {
            e.addEventListener('click', function () {
                var taskStatus = this.getAttribute('data-value');
                tasksRequest.statusTask = taskStatus;
            })
        })
        tasksRequest.page = 1;

        tableTask.ajax.reload(function () {
        });
    });

    function showEditTaskModal() {
        var modal = new bootstrap.Modal(document.getElementById('editTaskModal'));
        modal.show();
        $('#add-tag-name').modal('hide');
        showListTag();
    }

</script>
</body>
</html>
