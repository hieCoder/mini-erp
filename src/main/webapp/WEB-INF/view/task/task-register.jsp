<%@ page import="com.shsoftvina.erpshsoftvina.constant.TaskConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Tasks</title>

    <!--datatable css-->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
    <!--datatable responsive css-->
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Task Register</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks management</a></li>
                    <li class="breadcrumb-item active">Task Register</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-lg-12">
        <div class="card" id="tasksList">
            <div class="card-header border-0">
                <div class="d-flex align-items-center">
                    <h5 class="card-title mb-0 flex-grow-1">Task Register</h5>
                </div>
            </div>
            <div class="card-body border border-dashed border-end-0 border-start-0">
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
                                    <input type="text" id="title" name="title" class="form-control"
                                           placeholder="Title"/>
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
                            <div class="col-lg-6">
                                <label class="form-label">TAG: </label>
                                <button type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#tagModal">ADD TAG</button>
                                <div id="tagModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog modal-xl">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">TAG</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <select class="form-control" id="choices-multiple-remove-button" data-choices data-choices-removeItem name="choices-multiple-remove-button" multiple>
                                                            <option value="Choice 1">Choice 1</option>
                                                            <option value="Choice 2">Choice 2</option>
                                                            <option value="Choice 3">Choice 3</option>
                                                            <option value="Choice 4">Choice 4</option>
                                                        </select>

                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <table id="scroll-vertical" class="table table-bordered dt-responsive nowrap align-middle mdl-data-table" style="width:100%">
                                                        <thead>
                                                        <tr>
                                                            <th>Project</th>
                                                            <th>Task</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>Symox v1.0.0</td>
                                                            <td><a href="#!">Add Dynamic Contact List</a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Doot - Chat App Template</td>
                                                            <td><a href="#!">Additional Calendar</a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Qexal - Landing Page</td>
                                                            <td><a href="#!">Make a creating an account profile</a></td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary ">Save Changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-lg-6">
                                <label class="form-label">PIC: </label>
                                <button type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#picModal">ADD PIC</button>
                                <div id="picModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog modal-xl">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="picModalLabel">Modal Heading</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
                                            </div>
                                            <div class="modal-body">
                                                <h5 class="fs-15">
                                                    Overflowing text to show scroll behavior
                                                </h5>
                                                <p class="text-muted">One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like back, and if he lifted his head a little he could see his brown belly, slightly domed and divided by arches into stiff sections.</p>
                                                <p class="text-muted">The bedding was hardly able to cover it and seemed ready to slide off any moment. His many legs, pitifully thin compared with the size of the rest of him, waved about helplessly as he looked. "What's happened to me?" he thought.</p>
                                                <p class="text-muted">It wasn't a dream. His room, a proper human room although a little too small, lay peacefully between its four familiar walls.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary ">Save Changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <label class="form-label">Related Task: </label>
                                <button type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#picModal">ADD Related Task</button>
                                <div id="relatedTaskModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog modal-xl">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="relatedTaskModalLabel">Modal Heading</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
                                            </div>
                                            <div class="modal-body">
                                                <h5 class="fs-15">
                                                    Overflowing text to show scroll behavior
                                                </h5>
                                                <p class="text-muted">One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like back, and if he lifted his head a little he could see his brown belly, slightly domed and divided by arches into stiff sections.</p>
                                                <p class="text-muted">The bedding was hardly able to cover it and seemed ready to slide off any moment. His many legs, pitifully thin compared with the size of the rest of him, waved about helplessly as he looked. "What's happened to me?" he thought.</p>
                                                <p class="text-muted">It wasn't a dream. His room, a proper human room although a little too small, lay peacefully between its four familiar walls.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary ">Save Changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="hstack gap-2 justify-content-end mt-2">
                        <button type="submit" class="btn btn-success btn-load">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Register</span>
                            </span>
                        </button>
                        <button type="button" class="btn btn-light">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="/assets/custom/js/task/task.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script>

    // Data table add tag
    document.addEventListener('DOMContentLoaded', function () {
        let table = new DataTable('#scroll-vertical', {
            "scrollY":        "210px",
            "scrollCollapse": true,
            "paging":         false
        });
    });

    $(document).ready(function () {
        $('#title').val('');

        $('#content .ql-editor').html('<p><br></p>');
        $('#registerTaskForm .ql-toolbar.ql-snow').remove();
        activeEditor("#registerTaskForm");

        $('#dueDate').val('');
        $('#registerTaskForm .spinner-border').addClass('d-none');

        var selectElement = $('#selectUsername');
        if (isDeleveloper()) {
            selectElement.empty();
            $('.username-register-task').text(userCurrent.fullname);
            var option = $('<option></option>');
            option.attr('value', userCurrent.id);
            option.text(userCurrent.fullname);
            selectElement.append(option);

            $('#registerTaskModal').modal('show');
        } else {
            selectElement.empty();

            var swal = showAlertLoading();
            callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs) {
                $('#selectUsername').removeClass('d-none');

                rs.forEach(function (user) {
                    var option = $('<option></option>');
                    option.attr('value', user.id);
                    option.text(user.fullname);

                    if (user.id == userCurrent.id) {
                        option.attr('selected', 'selected');
                    }

                    selectElement.append(option);
                });

                swal.close();

            });
        }

        Validator({
            form: '#registerTaskForm',
            errorSelector: '.form-message',
            rules: [
                Validator.isRequired('#title'),
                Validator.isRequired('#content'),
                Validator.isDayAfterTodayOrNull("#dueDate", 'Due day is not before today')
            ],
            onSubmit: function (formData) {
                formData.append('content', $('#content').html());

                $('#registerTaskForm .spinner-border').removeClass('d-none');
                callAjaxByJsonWithDataForm("/api/v1/tasks/register", "POST", formData, function (rs) {
                    showAlert(SUCCESS_ALERT, 'Register success!');
                    loadCountStatus();
                });
            }
        });
    })
</script>
</body>
</html>
