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
    <!-- dropzone css -->
    <link rel="stylesheet" href="/assets/libs/dropzone/dropzone.css" type="text/css" />
</head>
<body>

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
                            <div class="col-lg-12">
                                <label for="content" class="form-label">Content</label>
                                <div id="content" class="snow-editor h-auto " style="height: 150px !important;"></div>
                                <small class="form-message"></small>
                            </div>
                            <div class="col-lg-12">
                                <label class="form-label">Attach file</label>
                                <div class="card-body attach-file-container">
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
                                <label for="dueDate" class="form-label">Due date</label>
                                <input type="text" id="dueDate" class="form-control"
                                       data-provider="flatpickr" placeholder="Due date"/>
                                <small class="form-message"></small>
                            </div>
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
                              <div class="d-flex align-items-center">
                                  <label class="form-label m-0">TAG: </label>
                                  <div id="show-tag-selected" class="d-flex align-items-center">
                                      <button id="add-tag" type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#tagModal">ADD TAG</button>
                                  </div>
                              </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="d-flex align-items-center">
                                    <label class="form-label m-0">PIC: </label>
                                    <div id="show-pic-selected" class="d-flex align-items-center">
                                        <button id="btn-add-pic" type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#picModal">ADD PIC</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="d-flex align-items-center">
                                    <label class="form-label m-0">Related Task: </label>
                                    <div id="show-related-task-selected" class="d-flex align-items-center">
                                        <button id="btn-add-related-task" type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#relatedTaskModal">ADD Related Task</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="hstack gap-2 justify-content-end mt-2">
                            <button type="submit" class="btn btn-success btn-load" disabled>
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Register</span>
                            </span>
                            </button>
                            <a href="/tasks" type="button" class="btn btn-light">Back</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Add Tag To Tag -->
<div id="tagModal" class="modal fade" tabindex="-1" aria-labelledby="..." aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">TAG</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 border p-1" id="tag-selected" style="height: 45px">
                </div>
                <div class="mt-2 text-center align-items-center" data-simplebar style="max-height: 400px">
                    <div class="d-flex justify-content-between align-items-center">
                        <input type="text" id="searchTag" class="form-control" placeholder="Search Tag..." style="width: 30%">
                        <button type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#add-tag-name" data-bs-dismiss="modal">+ TAG NAME</button>
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
                <button id="save-tag-selected" type="button" class="btn btn-primary" data-bs-dismiss="modal">Save Changes</button>
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
                <input id="new-tag-name" class="form-control" type="text" placeholder="Enter here..." maxlength="10" required>
                <span id="message-new-tag-name" class="text-danger d-none">Tag already exists</span>

                <label for="type-tag" class="form-label float-start mt-3">Type</label>
                <select id="type-tag" class="form-select mb-3" aria-label="Default select example">
                    <option value="DEFAULT_TAG" selected>Default Tag</option>
                    <option value="TAG_ADDED">Tag Normal</option>
                </select>
            </div>
            <div class="modal-footer">
                <button id="save-tag-name" type="button" class="btn btn-primary">ADD</button>
                <button type="button" class="btn btn-light" data-bs-target="#tagModal" data-bs-toggle="modal" data-bs-dismiss="modal">Back</button>
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
                    <h5 class="modal-title" >Edit tag Name</h5>
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
                    <button id="save-edit-tag-name" type="button" class="btn btn-primary" data-bs-target="#tagModal" data-bs-toggle="modal" data-bs-dismiss="modal">Save</button>
                    <button type="button" class="btn btn-light" data-bs-target="#tagModal" data-bs-toggle="modal" data-bs-dismiss="modal">Back</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- Modal Add Pic --%>
<div id="picModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">PIC</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 border p-1" id="pic-selected" style="height: 45px"></div>
                <div class="mt-2 text-center align-items-center">
                    <div class="d-flex justify-content-between align-items-center">
                        <input type="text" id="searchPic" class="form-control" placeholder="Search Pic..." style="width: 30%">
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
                <button id="btn-save-pic" type="button" class="btn btn-primary" data-bs-dismiss="modal">Save Changes</button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%-- Modal Add Related Task--%>
<div id="relatedTaskModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 border p-1" id="related-task-selected" style="height: 45px"></div>
                <div class="mt-2 text-center align-items-center">
                    <div class="d-flex justify-content-between align-items-center">
                        <input type="text" id="searchTask" class="form-control" placeholder="Search Task..." style="width: 30%">
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
                <button id="btn-save-task" type="button" class="btn btn-primary" data-bs-dismiss="modal">Save Changes</button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
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
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>
<script src="/assets/custom/js/task/task-detail.js"></script>
<script>

    document.addEventListener("DOMContentLoaded", function() {
        var dueDateInput = document.getElementById('dueDate');
        var submitButton = document.querySelector('.btn-load');

        dueDateInput.addEventListener('input', function() {
            if (dueDateInput.value.trim() === '') {
                submitButton.disabled = true;
            } else {
                submitButton.disabled = false;
            }
        });
    });


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

        const showTagSelect = document.getElementById('show-tag-selected');
        if (tagsSelected != '') {
            showTagSelect.innerHTML = `<span class="fw-bold ms-2" id="tags-selected">` + tagsSelected + `</span> <i id="btn-edit-tag" class="ri-edit-line fs-4 cursor-pointer ms-1"></i>`;
        } else {
            showTagSelect.innerHTML = ` <button id="add-tag" type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#tagModal">ADD TAG</button>`
        }

        const btnEditTag = document.getElementById('btn-edit-tag');
        if (btnEditTag) {
            btnEditTag.addEventListener('click', function () {
                var modal = new bootstrap.Modal(document.getElementById('tagModal'));
                modal.show();
            })
        }
    })

    document.getElementById('btn-add-pic').addEventListener('click', function () {
        if (!this.clicked) {
            this.clicked = true;

            callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs) {
                rs.forEach(function (user) {
                    const tablePic = document.getElementById('table-pic');
                    const tbody = tablePic.querySelector('tbody');
                    const pic = `<tr><td class="cursor-pointer pic-username">` + user.fullname + `</td></tr>`;
                    tbody.innerHTML += pic;
                });

                let selectedPicsArray = [];
                const inputSelectPic = document.getElementById('pic-selected');
                document.querySelectorAll('.pic-username').forEach(function (ePic) {
                    ePic.addEventListener('click', function () {
                        const picName = ePic.textContent;
                        if (!selectedPicsArray.includes(picName.trim())) {
                            selectedPicsArray.push(picName.trim());
                            if (picName.trim() != '') {
                                inputSelectPic.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 pic-selected">
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

                    rows.forEach(function(row) {
                        const cells = row.querySelectorAll('.pic-username');
                        let found = false;

                        cells.forEach(function(cell) {
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

                    const showPicSelect = document.getElementById('show-pic-selected');
                    if (picsSelected != '') {
                        showPicSelect.innerHTML = `<span class="fw-bold ms-2" id="pics-selected">` + picsSelected + `</span> <i id="btn-edit-pic" class="ri-edit-line fs-4 cursor-pointer ms-1"></i>`;
                    } else {
                        showPicSelect.innerHTML = `<button id="btn-add-pic" type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#picModal">ADD PIC</button>`
                    }

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
    });

    document.getElementById('btn-add-related-task').addEventListener('click', function () {
        if (!this.clicked) {
            this.clicked = true;

            callAjaxByJsonWithData('/api/v1/tasks/titles', 'GET', null, function (rs) {
                rs.forEach(function (task) {
                    const tableTask = document.getElementById('table-task');
                    const tbody = tableTask.querySelector('tbody');
                    const titleTask = `<tr><td class="cursor-pointer task-title">` + task.title + `</td></tr>`;
                    tbody.innerHTML += titleTask;
                });

                let selectedTasksArray = [];
                const inputSelectTask = document.getElementById('related-task-selected');
                document.querySelectorAll('.task-title').forEach(function (eTask) {
                    eTask.addEventListener('click', function () {
                        const taskTitle = eTask.textContent;
                        if (!selectedTasksArray.includes(taskTitle.trim())) {
                            selectedTasksArray.push(taskTitle.trim());
                            if (taskTitle.trim() != '') {
                                inputSelectTask.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 task-selected">
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

                    rows.forEach(function(row) {
                        const cells = row.querySelectorAll('.task-title');
                        let found = false;

                        cells.forEach(function(cell) {
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
                    document.querySelectorAll('.task-selected').forEach(function (eTask, index) {
                        if (!eTask.classList.contains('d-none')) {
                            const tagText = eTask.textContent.trim();
                            if (taskSelected.length > 0) {
                                taskSelected += ', ';
                            }
                            taskSelected += tagText;
                        }
                    });
                    const showTaskSelect = document.getElementById('show-related-task-selected');
                    if (taskSelected != '') {
                        showTaskSelect.innerHTML = `<span class="fw-bold ms-2" id="relatedTasks-selected">` + taskSelected + `</span> <i id="btn-edit-related-task" class="ri-edit-line fs-4 cursor-pointer ms-1"></i>`;
                    } else {
                        showTaskSelect.innerHTML = `<button id="btn-add-related-task" type="button" class="btn btn-primary ms-1" data-bs-toggle="modal" data-bs-target="#relatedTaskModal">ADD Related Task</button>`
                    }

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
    });

    function showListTag() {
        callAjaxByJsonWithData('/api/v1/tags', 'GET', null, function (rs) {
            let table = new DataTable('#scroll-vertical', {
                "scrollY":        "210px",
                "scrollCollapse": true,
                "paging":         false,
                "searching":      false,
                "ordering":       false,
                "info":           false
            });

            const defaultTagNames  = [];
            const tagAddedTagNames  = [];

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

            document.getElementById('searchTag').addEventListener('input', function() {
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
                        span2.setAttribute('data-value',data2[i].id);
                        span2.setAttribute('data-type', data2[i].type);
                    }

                    div1.appendChild(span1);
                    div2.appendChild(span2);
                    cell1.appendChild(div1);
                    cell2.appendChild(div2);


                    if (i < data1.length) {
                        div1.innerHTML += `
                            <div class="dropdown edit-tag-admin">
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
                            <div class="dropdown edit-tag-admin">
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

                        document.querySelectorAll('#edit-type-tag option').forEach(function(option) {
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

                if (isDeleveloper()) {
                    $('.edit-tag-admin').addClass('d-none');
                }
            }

            let selectedTagsArray = [];
            const selectedTag = document.getElementById('tag-selected');
            document.querySelectorAll('.tag-name').forEach(function (e) {
                e.addEventListener('click', function () {
                    const tagName = e.textContent;
                    if (!selectedTagsArray.includes(tagName.trim())) {
                        selectedTagsArray.push(tagName.trim());
                        if (tagName.trim() != '') {
                            selectedTag.innerHTML += `<button type="button" class="btn btn-primary btn-label waves-effect right waves-light rounded-pill ms-1 tag-selected">
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

    // Handle click btn ADD Tag to task
    document.getElementById('add-tag').addEventListener('click', function () {
        showListTag();

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
               $('#add-tag-name').modal('hide');
               $('#tagModal').modal('show');
               messageTag.classList.add('d-none');
               var formData = new FormData();
               const typeTag = document.getElementById('type-tag');
               formData.append('tagName', '#' + tagName.value.trim());
               formData.append('type', typeTag.value);
               callAjaxByJsonWithDataForm("/api/v1/tags/createTag", "POST", formData, function (rs) {
                   tagName.value = '';
                   showListTag();
               });
           }
        })

    })

    $(document).ready(function () {
        var dropzone = '';
        callAjaxByJsonWithData('/api/v1/settings/code?code='+ S_TASK, 'GET', null, function (setting) {
            dropzone = activeFile('#registerTaskForm', setting);
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
                $('button[data-bs-target="#add-tag-name"]').addClass('d-none');
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
                    const tagSelected = document.getElementById('tags-selected');
                    const picSelected = document.getElementById('pics-selected');
                    const relatedTaskSelected = document.getElementById('relatedTasks-selected');
                    var tag = '', pic = '', relatedTask = '';
                    if (tagSelected) tag = tagSelected.textContent;
                    if (picSelected) pic = picSelected.textContent;
                    if (relatedTaskSelected) relatedTask = relatedTaskSelected.textContent;
                    formData.append('content', $('#content').html());
                    formData.append('tag', tag)
                    formData.append('pic', pic);
                    formData.append('relatedTask', relatedTask)
                    var dateString = document.getElementById('dueDate').value;
                    var dueDate = new Date(dateString);
                    formData.append('dueDate', dueDate);
                    dropzone.files.forEach((file) => {
                        formData.append('filesTask', file);
                    });
                    $('#registerTaskForm .spinner-border').removeClass('d-none');
                    callAjaxByDataFormWithDataForm("/api/v1/tasks/register", "POST", formData, function (rs) {
                        loadCountStatus();
                        window.location.href = '/tasks';
                    });
                }
            });
        });
    })
</script>
</body>
</html>
