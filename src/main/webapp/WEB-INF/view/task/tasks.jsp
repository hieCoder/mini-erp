<%@ page import="com.shsoftvina.erpshsoftvina.constant.TaskConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Tasks</title>
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
        <div class="card" id="tasksList">
            <div class="card-header border-0">
                <div class="d-flex align-items-center">
                    <h5 class="card-title mb-0 flex-grow-1">All Tasks</h5>
                    <div class="flex-shrink-0">
                        <button class="btn btn-danger add-btn" data-bs-toggle="modal" data-bs-target="#showModal"><i class="ri-add-line align-bottom me-1"></i> Create Task</button>
                        <button class="btn btn-soft-danger" onClick="deleteMultiple()"><i class="ri-delete-bin-2-line"></i></button>
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
                <div class="d-flex justify-content-center mt-2">
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

<div class="modal fade flip" id="deleteOrder" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a task ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" id="deleteRecord-close" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                        <button class="btn btn-danger" id="delete-record">Yes, Delete It</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<div class="modal fade zoomIn" id="showModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel">Register Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-modal"></button>
            </div>
            <form action="">
                <div class="modal-body">
                    <input type="hidden" id="tasksId" />
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <label for="selectUsername" class="form-label">Username: <span class="username-register-task"></span></label>
                            <select id="selectUsername" class="form-select d-none" aria-label="Default select example">
                            </select>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="tasksTitle-field" class="form-label">Title</label>
                                <input type="text" id="tasksTitle-field" class="form-control" placeholder="Title" required />
                            </div>
                        </div>
                        <!--end col-->
                        <div class="col-lg-12">
                            <label for="content" class="form-label">Content</label>
                            <div id="content" class="ckeditor-classic"></div>
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="duedate-field" class="form-label">Due Date</label>
                            <input type="text" id="duedate-field" class="form-control" data-provider="flatpickr" placeholder="Due date" required />
                        </div>
                        <!--end col-->
                        <div class="col-lg-6">
                            <label for="priority-field" class="form-label">Priority</label>
                            <select class="form-control" data-choices data-choices-search-false id="priority-field">
                                <option value="High">High</option>
                                <option value="Medium">Medium</option>
                                <option value="Low">Low</option>
                            </select>
                        </div>
                        <!--end col-->
                    </div>
                    <!--end row-->
                </div>
                <div class="modal-footer">
                    <div class="hstack gap-2 justify-content-end">
                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-success" id="add-btn">Register Task</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!--end modal-->
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
                    return json;
                }
            },
            columns: [
                {
                    render: function(data, type, row) {
                        return `<th scope="row">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="chk_child" value="option1">
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
                        return `<div class="d-flex">
                                    <div class="flex-grow-1 tasks_name"><a class="fw-medium link-primary">` + data + `</a></div>
                                    <div class="flex-shrink-0 ms-4">
                                        <ul class="list-inline tasks-list-menu mb-0">
                                            <li class="list-inline-item"><a href="apps-tasks-details.html"><i class="ri-eye-fill align-bottom me-2 text-muted"></i></a></li>
                                            <li class="list-inline-item"><a class="edit-item-btn" href="#showModal" data-bs-toggle="modal"><i class="ri-pencil-fill align-bottom me-2 text-muted"></i></a></li>
                                            <li class="list-inline-item">
                                                <a class="remove-item-btn" data-bs-toggle="modal" href="#deleteOrder">
                                                    <i class="ri-delete-bin-fill align-bottom me-2 text-muted"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>`;
                    }
                },
                { data: 'fullnameUser' },
                { data: 'priority.code',
                    render: function(data, type, row) {
                        var colorClass = getPriorityColor(data);
                        return `<span class="badge ` + colorClass + ` text-uppercase">` + data + `</span>`;
                    }
                },
                {
                    data: 'progress',
                    render: function(data, type, row) {
                        return `<div class="progress mb-4">
                            <div class="progress-bar bg-success" role="progressbar" style="width:` + data
                            +`%" aria-valuenow="` + data+`" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>`;
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

        loadPaging();

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

    var isFirstTime = true;
    $(document).ready(function() {
        $('#showModal').on('shown.bs.modal', function() {
            // username
            if(isDeleveloper()){
                $('.username-register-task').text(userCurrent.fullname);
            } else{
                if (isFirstTime) {
                    var selectElement = $('#selectUsername');
                    selectElement.empty();
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

                        isFirstTime = false;
                    });

                    $('#selectUsername').removeClass('d-none');
                }
            }


            // // content
            // $('#content').summernote({
            //     maxHeight: 140
            // });
            //
            // Validator({
            //     form:'#registerTaskForm',
            //     errorSelector: '.form-message',
            //     rules:[
            //         Validator.isRequired('#title'),
            //         Validator.isDayAfterToday("#dueDate", 'Due day is not before today'),
            //         Validator.isRequired('#content'),
            //     ],
            //     onSubmit: function (formData) {
            //         formData.append('content', $('#content').summernote().summernote('code'));
            //         callAjaxByJsonWithDataForm("/api/v1/tasks/register", "POST", formData, function (rs) {
            //             window.location.href = "/tasks?registerSuccess";
            //         });
            //     }
            // });
        });
    });
</script>
</body>
</html>
