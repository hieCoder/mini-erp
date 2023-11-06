<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Users</title>
    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="container-fluid">
        <div class="col-xxl-12">
            <div class="card mt-xxl-n5">
                <form id="form" action="/users" method="GET">
                    <div class="container">
                        <h1 class="mt-4">List User</h1>
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="search">Search:</label>
                                    <div class="input-group">
                                        <input id="search" name="search" type="text" class="form-control"
                                               placeholder="Search by username or userid">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="submit">Search</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label for="statusUser">Status:</label>
                                    <div class="input-group">
                                        <select id="statusUser" name="status" class="form-select"
                                                onchange="this.form.submit()">
                                            <
                                            <option value="ACTIVE">ACTIVE</option>
                                            <option value="INACTIVE">INACTIVE</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label for="pageSize">Page Count:</label>
                                    <div class="input-group">
                                        <select id="pageSize" name="pageSize" class="form-select"
                                                onchange="this.form.submit()">
                                            <option value="10">10</option>
                                            <option value="15">15</option>
                                            <option value="20">20</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label for="pageSize">Account pending:</label>
                                    <div class="input-group text-right">
                                        <button type="button" id="penddingModal"
                                                class="btn btn-warning">View
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label for="sort">Sort By Username</label>
                                    <div class="input-group">
                                        <select id="sort" name="sort" class="form-select" onchange="this.form.submit()">
                                            <option value="ASC">A - Z</option>
                                            <option value="DESC">Z - A</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <table class="table border align-middle table-nowrap table-striped-columns mt-4">
                            <thead>
                            <tr>
                                <th>NO.</th>
                                <th>ID</th>
                                <th class="sortable-header">Username</th>
                                <th>User ID</th>
                                <th>Department</th>
                                <th>Position</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${users.getListUser()}" varStatus="loop">
                                <tr>
                                    <th scope="row">${(users.pageNumber - 1) * users.pageSize + loop.index + 1}</th>
                                    <td>${user.getId()}</td>
                                    <td><a href="/users/${user.getId()}" style="color: blue">${user.getFullname()}</a>
                                    </td>
                                    <td>${user.getEmail()}</td>
                                    <td>${user.getDepartment().getName()}</td>
                                    <td>${user.getPosition().getName()}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <!-- Pagination -->
                        <div class="row justify-content-center" style="margin-left: 2px">
                            <ul class="pagination">
                                <li class="page-item">
                                    <c:if test="${users.hasPrevious}">
                                        <button class="page-link" type="submit" name="page" value="1"><<</button>
                                    </c:if>
                                </li>
                                <li class="page-item">
                                    <c:if test="${users.hasPrevious}">
                                        <button class="page-link" type="submit" name="page"
                                                value="${users.pageNumber - 1}"><
                                        </button>
                                    </c:if>
                                </li>
                                <c:forEach var="page" begin="1" end="${users.totalPages}">
                                    <c:choose>
                                        <c:when test="${page == users.pageNumber}">
                                            <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <button class="page-link" type="submit" name="page"
                                                        value="${page}">${page}</button>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item">
                                    <c:if test="${users.hasNext}">
                                        <button class="page-link" type="submit" name="page"
                                                value="${users.pageNumber + 1}">>
                                        </button>
                                    </c:if>
                                </li>
                                <li class="page-item">
                                    <c:if test="${users.hasNext}">
                                        <button class="page-link" type="submit" name="page" value="${users.totalPages}">
                                            >>
                                        </button>
                                    </c:if>
                                </li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- container-fluid -->
</div>

<!-- Modal  approval -->
<div class="modal fade" id="modal-account-pending" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light p-3">
                <h5 class="modal-title" id="exampleModalLabel">Account Pending</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                        id="close-modal"></button>
            </div>

            <div class="modal-body">
                <table class="table align-middle table-nowrap table-striped-columns"
                       id="pendingTable">
                    <thead class="table-light">
                    <tr>
                        <th>Username</th>
                        <th>User ID</th>
                        <th>Created date</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody class="list form-check-all">

                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <div class="hstack gap-2 justify-content-end">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Modal  reject -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-light p-3">
                <h5 class="modal-title">Confirm Reject</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                Are you sure you want to reject this item?
            </div>
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-danger" id="confirmReject">Reject</button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

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
<script src="/assets/js/pages/datatables.init.js"></script>
<!-- List js -->
<script src="/assets/libs/list.js/list.min.js"></script>
<!-- Pagination js -->
<script src="/assets/libs/list.pagination.js/list.pagination.min.js"></script>

<%-------------------------------------------- ALERTS JAVASCRIPT--------------------------------------------%>
<!-- Sweet Alerts js -->
<script src="assets/libs/sweetalert2/sweetalert2.min.js"></script>


<%-------------------------------------------- CUSTOM JAVASCRIPT--------------------------------------------%>
<script>

    document.getElementById('penddingModal').addEventListener('click', function () {
        $('#modal-account-pending').modal('show');
        $('#pendingTable').DataTable().destroy();
        // Tạo DataTable
        let table = new DataTable('#pendingTable', {
            pagingType: "full_numbers",
            pageLength: 10,
            ordering: false,
            ajax: {
                url: '/api/v1/users?status=PENDING',
                contentType: 'application/json',
                method: 'GET',
                dataSrc: "listUser"
            },
            columns: [
                {data: 'fullname'},
                {data: 'email'},
                {data: 'createdDate'},
                {
                    data: 'role',
                    render: function (data, type, row) {
                        return '<select style="width: 160px;" class="form-select" name="role">' +
                            '<option value="">-- Select role --</option>' +
                            '<option value="OWNER" ' + (data === 'OWNER' ? 'selected' : '') + '>Owner</option>' +
                            '<option value="MANAGER" ' + (data === 'MANAGER' ? 'selected' : '') + '>Manager</option>' +
                            '<option value="DEVELOPER" ' + (data === 'DEVELOPER' ? 'selected' : '') + '>Developer</option>' +
                            '</select>';
                    }
                },
                {
                    render: function (data, type, row) {
                        return '<button type="button" class="approval-btn btn btn-primary" data-status="ACTIVE" data-id="' + row.id + '">Approval</button>' +
                            '<button type="button" class="reject-btn btn btn-danger ml-10" data-status="REJECT" data-id="' + row.id + '">Reject</button>';
                    }
                }
            ]
        });
        table.ajax.reload();

        $('#pendingTable').on('click', '.approval-btn', function (event) {

            var data = table.row($(this).parents('tr')).data();
            // if (this.position == null) {
            //     Swal.fire(
            //         {
            //             title: 'Oops...',
            //             text: 'You must choose a role!',
            //             icon: 'error',
            //             confirmButtonClass: 'btn btn-primary w-xs mt-2',
            //             buttonsStyling: false,
            //             showCloseButton: true
            //         }
            //     )
            // }

            var obj = {
                email: data.email,
                role: $(this).closest('tr').find('select[name="role"]').val(),
                status: $(this).data('status'),
                id: $(this).data('id')
            };

            callAjaxByJsonWithData('/api/v1/users/register/approval', 'PUT', obj, function (rs) {
                if (rs) {
                    table.ajax.reload();
                }
                sessionStorage.setItem('result', 'approvalSuccess')
                location.reload();
            });
        });

        $('#pendingTable').on('click', '.reject-btn', function () {

            $('#confirmModal').modal('show');

            var id = $(this).data('id');

            $('#confirmReject').on('click', function () {
                callAjaxByJsonWithData('/api/v1/users/register/reject/' + id, 'DELETE', null, function (rs) {
                    if (rs) {
                        table.ajax.reload();
                    }
                    sessionStorage.setItem('result', 'rejectSuccess')
                    location.reload();
                });
                $('#confirmModal').modal('hide');
            });

        });
    })
</script>

<script>
    // // Lưu giá trị lựa chọn "Page Count," "Status," và "Search" vào Local Storage khi thay đổi
    document.getElementById("pageSize").addEventListener("change", function () {
        localStorage.setItem("selectedPageSize", this.value);
    });

    document.getElementById("statusUser").addEventListener("change", function () {
        localStorage.setItem("selectedStatus", this.value);
    });

    document.getElementById("search").addEventListener("input", function () {
        localStorage.setItem("selectedSearch", this.value);
    });

    document.getElementById("sort").addEventListener("input", function () {
        localStorage.setItem("selectedSort", this.value);
    });

    // Khôi phục giá trị lựa chọn "Page Count," "Status," và "Search" từ Local Storage khi trang được load
    window.addEventListener("load", function () {
        window.scrollTo(0, window.innerHeight / 3);
        var selectedPageSize = localStorage.getItem("selectedPageSize");
        if (selectedPageSize) {
            document.getElementById("pageSize").value = selectedPageSize;
        }

        var selectedStatus = localStorage.getItem("selectedStatus");
        if (selectedStatus) {
            document.getElementById("statusUser").value = selectedStatus;
        }

        var selectedSort = localStorage.getItem("selectedSort");
        if (selectedSort) {
            document.getElementById("sort").value = selectedSort;
        }

        var selectedSearch = localStorage.getItem("selectedSearch");
        if (selectedSearch) {
            document.getElementById("search").value = selectedSearch;
        }
    });
</script>

<%--Notification--%>
<script>
    // Show modal notification
    document.addEventListener("DOMContentLoaded", function () {
        var result = sessionStorage.getItem('result');
        if (result != null) notificationSuccess(sessionStorage.getItem('result'));
        sessionStorage.clear();
    });

    // Notification Success
    function notificationSuccess(result) {
        var title;
        var text;

        switch (result) {
            case 'approvalSuccess':
                title = 'Approval Success';
                break;
            case 'rejectSuccess':
                title = 'Reject Success';
                break;
        }
        Swal.fire(
            {
                title: title,
                text: text,
                icon: 'success',
                confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                cancelButtonClass: 'btn btn-danger w-xs mt-2',
                buttonsStyling: false,
                showCloseButton: true
            }
        )
    }
</script>
</body>
</html>
