<%@ page import="com.shsoftvina.erpshsoftvina.constant.TaskConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Tasks</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <h1>Status</h1>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table id="data-table-status" class="table">
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <h1>List Task</h1>
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
            <div class="row mt-3">
                <div class="col-md-8">
                    <div class="d-flex justify-content-center">
                        <input class="form-control mr-1" id="search-input" type="text" placeholder="Title, username, hashtag">
                        <button id="search-button" type="button" class="btn btn-info mr-5">Search</button>
                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#registerTaskModal">
                            Register</button>
                    </div>
                </div>
                <div class="col-md-4 d-flex align-items-end justify-content-end">
                    <label for="page-count-select" class="mr-2">Page count:</label>
                    <select class="form-control w-auto" id="page-count-select">
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                    </select>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table id="data-table-task" class="table">
                            <thead>
                            <tr>
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
                        </table>
                    </div>
                    <div>
                        <ul id="pagination" class="pagination mt-2 justify-content-center"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- modal register --%>
    <div class="modal fade" id="registerTaskModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form id="registerTaskForm">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Register task</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Username:</label>
                            <select id="selectUsername" name="userId" class="form-control" aria-label="Default select example"></select>
                        </div>
                        <div class="form-group">
                            <label for="title">Title:</label>
                            <input id="title" name="title" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Title">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="content">Content:</label>
                            <div id="content" class="summernote"></div>
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="dueDate">Due date:</label>
                            <input id="dueDate" name="dueDate" type="date" class="form-control">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label>Priority:</label>
                            <select id="selectPriority" name="priority" class="form-control" aria-label="Default select example">
                                <option value="LOW" class="text-warning">Low</option>
                                <option value="MEDIUM" class="text-primary">Medium</option>
                                <option value="HIGH" class="text-danger">High</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Register</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="/assets/js/task/task.js"></script>
<script>

    var tasksRequest = {
        page: 1,
        pageSize: $('#page-count-select').val(),
        statusTask: '',
        search: ''
    }

    var tableTask, tableStatus;
    $(document).ready(function (){
        tableTask = $('#data-table-task').DataTable({
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
                { data: 'id' },
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
                        var href = '/tasks/' + row.id;
                        return '<a href="' + href + '">' + data + '</a>';
                    }
                },
                { data: 'fullnameUser' },
                { data: 'priority.code',
                    render: function(data, type, row) {
                        var colorClass = getPriorityColor(data);
                        return '<span class="badge ' + colorClass + '">' + data + '</span>';
                    }
                },
                {
                    data: 'progress',
                    render: function(data, type, row) {
                        var minWidth = 25; // Độ rộng tối thiểu
                        var width = Math.max(data, minWidth); // Đảm bảo rộng ít nhất là 50%
                        return '<div class="progress" style="height: 20px;"><div class="progress-bar bg-success" role="progressbar" style="width: ' + width + '%" aria-valuenow="' + data + '" aria-valuemin="0" aria-valuemax="100">' + data + '%</div></div>';
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

        $('#search-button').on('click', function() {
            var keyword = $('#search-input').val();
            tasksRequest.search = keyword;
            tasksRequest.page = 1;
            tableTask.ajax.reload();
            loadPaging();
        });

        $('#page-count-select').on('change', function() {
            var selectedValue = $(this).val();
            tasksRequest.pageSize = selectedValue;
            tasksRequest.page = 1;
            tableTask.ajax.reload();
            loadPaging();
        });

        loadPaging();
        tableStatus = $('#data-table-status').DataTable({
            ajax: {
                url: '/api/v1/tasks/status-task-count',
                contentType: 'application/json',
                method: 'GET',
                dataSrc: ''
            },
            columns: [
                {
                    data: 'statusTask',
                    render: function(data, type, row) {
                        var colorClass = getStatusColor(data.code);
                        return '<span class="badge ' + colorClass + '">' + data.name + '</span>';
                    }
                },
                {
                    data: 'statusTask.code',
                    render: function(data, type, row) {
                        return '<a class="numberStatus" href="#" status="' + data + '">' + row.taskCount + '</a>';
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        $('#data-table-status').on('click', 'a.numberStatus', function(e) {
            e.preventDefault();
            var statusTask = $(this).attr('status');
            tasksRequest.statusTask = statusTask;
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

            var totalPage = 0;
            if(totalItem <= tasksRequest.pageSize) totalPage = 1;
            else totalPage = Math.ceil(totalItem / tasksRequest.pageSize);

            //paging
            var totalPages = totalPage;
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

        $('#registerTaskModal').on('shown.bs.modal', function() {

            // username
            if(isDeleveloper()){
                var selectElement = $('#selectUsername');
                selectElement.empty();
                selectElement.append('<option value="'+ userCurrent.id+'">'+userCurrent.fullname+"</option>");
                $('#selectUsername').prop('disabled', true);
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
                }
            }


            // content
            $('#content').summernote({
                maxHeight: 140
            });

            Validator({
                form:'#registerTaskForm',
                errorSelector: '.form-message',
                rules:[
                    Validator.isRequired('#title'),
                    Validator.isDayAfterToday("#dueDate", 'Due day is not before today'),
                    Validator.isRequired('#content'),
                ],
                onSubmit: function (formData) {
                    formData.append('content', $('#content').summernote().summernote('code'));
                    callAjaxByJsonWithDataForm("/api/v1/tasks/register", "POST", formData, function (rs) {
                        window.location.href = "/tasks?registerSuccess";
                    });
                }
            });
        });
    });
</script>
</body>
</html>
