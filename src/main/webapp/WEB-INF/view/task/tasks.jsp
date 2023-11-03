<%@ page import="com.shsoftvina.erpshsoftvina.constant.TaskConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Tasks</title>

    <!-- quill css -->
    <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
    <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
    <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Tasks List</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks</a></li>
                    <li class="breadcrumb-item active">Tasks List</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-xxl-3 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Total Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-value counter-total-task" data-target="234">0</span></h2>
                        <p class="mb-0 text-muted"><span class="badge bg-light text-success mb-0"> <i class="ri-arrow-up-line align-middle"></i> 17.32 %</span> vs. previous month</p>
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
    <div class="col-xxl-3 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Closed Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-value counter-closed-task" data-target="116.21">0</span></h2>
                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i class="ri-arrow-down-line align-middle"></i> 2.52 % </span> vs. previous month</p>
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
    <div class="col-xxl-3 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Opened Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-value counter-opened-task" data-target="64.5">0</span></h2>
                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous month</p>
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
    <div class="col-xxl-3 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Reopened Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-value counter-reopend-task" data-target="64.5">0</span></h2>
                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous month</p>
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
    <div class="col-xxl-3 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Postponed Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-value counter-postponed-task" data-target="64.5">0</span></h2>
                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous month</p>
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
    <div class="col-xxl-3 col-sm-6">
        <div class="card card-animate">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="fw-medium text-muted mb-0">Registered Tasks</p>
                        <h2 class="mt-4 ff-secondary fw-semibold"><span class="counter-value counter-registered-task" data-target="64.5">0</span></h2>
                        <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous month</p>
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
         <c:if test="${param.registerSuccess != null}">
            <div class="alert alert-success">
                Register success!
            </div>
        </c:if>
        <c:if test="${param.deleteSuccess != null}">
            <div class="alert alert-success">
                Delete success!
            </div>
        </c:if>
        <c:if test="${param.updateSuccess != null}">
            <div class="alert alert-success">
                Update success!
            </div>
        </c:if>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="card" id="tasksList">
            <div class="card-header border-0">
                <div class="d-flex align-items-center">
                    <h5 class="card-title mb-0 flex-grow-1">All Tasks</h5>
                    <div class="flex-shrink-0">
                        <button class="btn btn-danger add-btn" data-bs-toggle="modal" data-bs-target="#registerTaskModal"><i class="ri-add-line align-bottom me-1"></i> Register task</button>
                        <button class="btn btn-soft-danger" id="delete-mul-task"><i class="ri-delete-bin-2-line"></i></button>
                    </div>
                </div>
            </div>
            <div class="card-body border border-dashed border-end-0 border-start-0">
                <form>
                    <div class="row g-3">
                        <div class="col-xxl-7 col-sm-12">
                            <div class="search-box">
                                <input id="search-input" type="text" class="form-control search bg-light border-light" placeholder="Search by username, title, content">
                                <i class="ri-search-line search-icon"></i>
                            </div>
                        </div>
                        <!--end col-->
                        <div class="col-xxl-2 col-sm-4">
                            <div class="input-light">
                                <select class="form-control" data-choices data-choices-search-false name="choices-single-default" id="idStatus">
                                    <option value="" selected>All</option>
                                    <option value="REGISTER">Registered</option>
                                    <option value="OPENED">Opened</option>
                                    <option value="POSTPONED">Postponed</option>
                                    <option value="REOPENED">Reopend</option>
                                    <option value="CLOSED">Closed</option>
                                </select>
                            </div>
                        </div>
                        <!--end col-->
                        <div class="col-xxl-1 col-sm-4">
                            <button id="filter-btn" type="button" class="btn btn-primary w-100"> <i class="ri-equalizer-fill me-1 align-bottom"></i>
                                Filters
                            </button>
                        </div>
                        <!--end col-->
                        <div class="col-xxl-2 col-sm-4 d-flex align-items-center justify-content-end">
                            <label style="margin-right: 5px;">Show entries: </label>
                            <select id="page-count-select" class="form-select" aria-label=".form-select-lg example">
                                <option value="10">10</option>
                                <option value="15">15</option>
                                <option value="20">20</option>
                            </select>
                        </div>
                        <!--end col-->
                    </div>
                    <!--end row-->
                </form>
            </div>
            <!--end card-body-->
            <div class="card-body">
                <div class="table-responsive table-card mb-4">
                    <table class="table align-middle table-nowrap mb-0 w-100" id="tasksTable">
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
                            <th>Username</th>
                            <th>Priority</th>
                            <th>Progress</th>
                            <th>Start date</th>
                            <th>Due/Closed date</th>
                        </tr>
                        </thead>
                        <tbody class="list form-check-all"></tbody>
                    </table>
                    <!--end table-->
                    <div class="noresult" style="display: none">
                        <div class="text-center">
                            <lord-icon src="https://cdn.lordicon.com/msoeawqm.json" trigger="loop" colors="primary:#121331,secondary:#08a88a" style="width:75px;height:75px"></lord-icon>
                            <h5 class="mt-2">Sorry! No Result Found</h5>
                            <p class="text-muted mb-0">We've searched more than 200k+ tasks We did not find any tasks for you search.</p>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center">
                    <div class="pagination-wrap hstack gap-2">
                        <ul id="pagination" class="pagination"></ul>
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
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a task ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger" id="delete-task" data-id="">Yes, Delete It</button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" id="delete-task-close" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<div class="modal fade zoomIn" id="registerTaskModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel">Register Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-modal"></button>
            </div>
            <form id="registerTaskForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <label for="selectUsername" class="form-label">Username: <span class="username-register-task"></span></label>
                            <select id="selectUsername" name="userId" class="form-select d-none" aria-label="Default select example">
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
                            <input type="text" id="dueDate" name="dueDate" class="form-control" data-provider="flatpickr" placeholder="Due date"/>
                            <small class="form-message"></small>
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="selectPriority" class="form-label">Priority</label>
                            <select id="selectPriority" name="priority"  class="form-control" data-choices data-choices-search-false>
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
                        <button type="submit" class="btn btn-success" id="add-btn">Register</button>
                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!--end modal-->

<div class="modal fade zoomIn" id="editTaskModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel-edit-task">Update task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-modal"></button>
            </div>
            <form id="editTaskForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <label for="selectUsernameEdit" class="form-label">Username: <span class="username-edit-task"></span></label>
                            <select id="selectUsernameEdit" name="userId" class="form-select d-none" aria-label="Default select example">
                            </select>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="title" class="form-label">Title</label>
                                <input type="text" id="title-edit" name="title" class="form-control" placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <!--end col-->
                        <div class="col-lg-12">
                            <label for="content" class="form-label">Content</label>
                            <div id="content-edit" class="snow-editor h-auto"></div>
                            <small class="form-message"></small>
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="selectActionEdit" class="form-label">Status:<span id="statusTaskEdit"></span></label>
                            <select id="selectActionEdit" name="action" class="form-control"></select>
                        </div>
                        <!--end col-->
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
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="dueDateEdit" class="form-label">Due date</label>
                            <input type="text" id="dueDateEdit" name="dueDate" class="form-control" data-provider="flatpickr" placeholder="Due date"/>
                            <small class="form-message"></small>
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="selectPriority" class="form-label">Priority</label>
                            <select id="selectPriorityEdit" name="priority" class="form-control">
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
                        <button type="submit" class="btn btn-success" id="update-task-btn">Update</button>
                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!--end modal-->

<!-- ckeditor -->
<script src="/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>
<!-- init js -->
<script src="/assets/js/pages/form-editor.init.js"></script>

<script src="/assets/custom/js/task/task.js"></script>
<script>

    var tasksRequest = {
        page: 1,
        pageSize: $('#page-count-select').val(),
        statusTask: '',
        search: ''
    }
    var tableTask = null;

    $(document).ready(function (){
        callAjaxByJsonWithData('/api/v1/tasks/status-task-count', 'GET', null, function (rs) {
            $(".counter-total-task").attr("data-target", getTaskCountByCode(rs, T_ALL));
            $(".counter-closed-task").attr("data-target", getTaskCountByCode(rs, T_CLOSED));
            $(".counter-postponed-task").attr("data-target", getTaskCountByCode(rs, T_POSTPONED));
            $(".counter-opened-task").attr("data-target", getTaskCountByCode(rs, T_OPENED));
            $(".counter-registered-task").attr("data-target", getTaskCountByCode(rs, T_REGISTERED));
            $(".counter-reopend-task").attr("data-target", getTaskCountByCode(rs, T_REOPENED));
        });

        tableTask = $('#tasksTable').DataTable({
            ajax: {
                url: '/api/v1/tasks',
                contentType: 'application/json',
                method: 'POST',
                data: function (d) {
                    return JSON.stringify(tasksRequest);
                },
                dataSrc: function (json) {
                    if(json.length != 0) loadPaging();
                    return json;
                }
            },
            columns: [
                {
                    render: function(data, type, row) {
                        return `<th scope="row">
                            <div class="form-check">
                                <input data-id="` + row.id + `" class="form-check-input" type="checkbox" name="chk_child" value="option1">
                            </div>
                        </th>`;
                    }
                },
                {
                    data: 'id',
                    render: function(data, type, row) {
                        return `<a class="fw-medium link-primary">` + data + `</a>`;
                    }
                },
                {
                    data: 'statusTask.code',
                    render: function(data, type, row) {
                        var colorClass = getStatusColor(data);
                        return '<span class="badge ' + colorClass + '">' + data + '</span>';
                    }
                },
                {
                    data: 'title',
                    render: function(data, type, row) {
                        var editAndRemoveE = '';
                        if(isAdminOrUserLogin(row.user.id)){
                            editAndRemoveE = `<li class="list-inline-item"><a class="edit-item-task-btn" href="#editTaskModal" data-id="` + row.id + `" data-bs-toggle="modal"><i class="ri-pencil-fill align-bottom me-2 text-muted"></i></a></li>
                                            <li class="list-inline-item">
                                                <a class="remove-item-task-btn" data-bs-toggle="modal" href="#deleteTaskModal" data-id="` + row.id + `">
                                                    <i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i>
                                                </a>
                                            </li>`;
                        }
                        return `<div class="d-flex">
                                    <div class="flex-grow-1 tasks_name"><a class="fw-medium link-primary">` + data + `</a></div>
                                    <div class="flex-shrink-0 ms-4">
                                        <ul class="list-inline tasks-list-menu mb-0">
                                            <li class="list-inline-item"><a href="/tasks/`+ row.id +`"><i class="ri-eye-fill align-bottom me-2 text-muted"></i></a></li>`
                                            + editAndRemoveE +`
                                        </ul>
                                    </div>
                                </div>`;
                    }
                },
                { data: 'user.fullname' },
                { data: 'priority.code',
                    render: function(data, type, row) {
                        var colorClass = getPriorityColor(data);
                        return `<span class="badge ` + colorClass + ` text-uppercase">` + data + `</span>`;
                    }
                },
                {
                    data: 'progress',
                    render: function(data, type, row) {
                        return getProgressE(data);
                    }
                },
                { data: 'startDate' },
                { data: 'dueOrCloseDate' }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        $('#filter-btn').on('click', function() {
            tasksRequest.search = $('#search-input').val();
            tasksRequest.statusTask = $('#idStatus').val();
            tableTask.ajax.reload();
        });

        $('#page-count-select').on('change', function() {
            var selectedValue = $(this).val();
            tasksRequest.pageSize = selectedValue;
            tasksRequest.page = 1;
            tableTask.ajax.reload();
            loadPaging();
        });
    });

    function loadPaging(){
        callAjaxByJsonWithData('/api/v1/tasks/count', 'POST', tasksRequest, function (totalItem) {

            if (window.pagObj) {
                window.pagObj.twbsPagination('destroy');
            }

            //paging
            var totalPages = 0;
            if(totalItem <= tasksRequest.pageSize) totalPages = 1;
            else totalPages = Math.ceil(totalItem / tasksRequest.pageSize);
            var currentPage = tasksRequest.page;

            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    visiblePages: <%=TaskConstant.visiblePages%>,
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
</script>
<script>

    $(document).ready(function() {
        var isFirstTimeOpenModalRegister = true;
        $('#registerTaskModal').on('shown.bs.modal', function() {
            var selectElement = $('#selectUsername');
            selectElement.empty();

            // username
            if(isDeleveloper()){
                $('.username-register-task').text(userCurrent.fullname);
                var option = $('<option></option>');
                option.attr('value', userCurrent.id);
                option.text(userCurrent.fullname);
                selectElement.append(option);
            } else{
                if (isFirstTimeOpenModalRegister) {
                    callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function(rs) {
                        rs.forEach(function(user) {
                            var option = $('<option></option>');
                            option.attr('value', user.id);
                            option.text(user.fullname);

                            if (user.id == userCurrent.id) {
                                option.attr('selected', 'selected');
                            }

                            selectElement.append(option);
                        });

                        isFirstTimeOpenModalRegister = false;
                    });

                    $('#selectUsername').removeClass('d-none');
                }
            }

            Validator({
                form:'#registerTaskForm',
                errorSelector: '.form-message',
                rules:[
                    Validator.isRequired('#title'),
                    Validator.isRequired('#content'),
                    Validator.isDayAfterTodayOrNull("#dueDate", 'Due day is not before today')
                ],
                onSubmit: function (formData) {
                    formData.append('content', $('#content').html());
                    callAjaxByJsonWithDataForm("/api/v1/tasks/register", "POST", formData, function (rs) {
                        window.location.href = "/tasks?registerSuccess";
                    });
                }
            });
        });
    });

    $(document).on('click', '.remove-item-task-btn', function (e) {
        var idTask = $(this).data('id');
        $('#delete-task').attr('data-id', idTask);
    });

    $(document).on('click', '#delete-task', function (e) {
        var idTask = $(this).attr('data-id');
        callAjaxByJsonWithData("/api/v1/tasks/" + idTask, "DELETE", null, function (rs) {
            window.location.href = "/tasks?deleteSuccess";
        });
    });

    $(document).on('click', '#checkAll', function (e) {
        if ($(this).prop('checked')) {
            $('#tasksTable input[type="checkbox"]').prop('checked', true);
        } else {
            $('#tasksTable input[type="checkbox"]').prop('checked', false);
        }
    });

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
                if (e.value) {
                    callAjaxByJsonWithData("/api/v1/tasks/", "DELETE", checkedIds, function (rs) {
                        window.location.href = "/tasks?deleteSuccess";
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

    $(document).on('click', '.edit-item-task-btn', function (e) {
        var idTask = $(this).data('id');
        callAjaxByJsonWithData('/api/v1/tasks/' + idTask, "GET", null, function (rs) {

            var selectElement = $('#selectUsernameEdit');
            selectElement.empty();
            // username
            if(isDeleveloper()){
                $('.username-edit-task').text(rs.user.fullname);
                var option = $('<option></option>');
                option.attr('value', rs.user.id);
                option.text(rs.user.fullname);
                selectElement.append(option);
            } else{
                callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function(users) {
                    users.forEach(function(user) {
                        var option = $('<option></option>');
                        option.attr('value', user.id);
                        option.text(user.fullname);

                        if (user.id == rs.user.id) {
                            option.attr('selected', 'selected');
                        }

                        selectElement.append(option);
                    });
                });
                $('#selectUsernameEdit').removeClass('d-none');
            }

            $('#title-edit').val(rs.title);

            $('#content-edit').html(rs.content);

            var statusCode = rs.statusTask.code;
            $('#statusTaskEdit').replaceWith('<span id="statusTaskEdit" class="badge ' + getStatusColor(statusCode) + '">' + statusCode + '</span>');

            $('#selectActionEdit').html('<option value="">-- Select actions --</option>');
            rs.statusTask.actions.forEach(function(action) {
                var option = $('<option></option>');
                option.attr('value', action.code);
                option.text(action.name);
                $('#selectActionEdit').append(option);
            });

            $('#selectProgressEdit').val(rs.progress);

            if(rs.dueDate){
                $('#dueDateEdit').val(formatDateValueToValueOfInputDate(rs.dueDate));
            }

            $('#selectPriorityEdit').val(rs.priority.code);

            //handle case
            if([T_REGISTERED, T_POSTPONED, T_CLOSED].includes(statusCode)){
                $('#selectProgressEdit').prop('disabled', true);
            } else $('#selectProgressEdit').prop('disabled', false);

            if(statusCode == T_POSTPONED){
                $('#selectPriorityEdit').prop('disabled', true);
            } else $('#selectPriorityEdit').prop('disabled', false);
        });

        Validator({
            form:'#editTaskForm',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#title-edit'),
                Validator.isRequired('#content-edit'),
                Validator.isRequired("#dueDateEdit"),
                Validator.isDayAfterTodayOrNull("#dueDateEdit", 'Due day is not before today')
            ],
            onSubmit: function (formData) {
                formData.append('id', idTask);
                formData.append('content', $('#content-edit').html());

                callAjaxByJsonWithDataForm("/api/v1/tasks", "PUT", formData, function (rs) {
                    window.location.href = "/tasks?updateSuccess";
                });
            }
        });

    });
</script>
</body>
</html>
