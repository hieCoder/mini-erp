<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Users</title>
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
                                        <button data-toggle="modal" data-target="#modal-account-pending" type="button"
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
                        <table class="table border align-middle table-nowrap table-striped-columns mt-4"
                               style="min-height: 300px">
                            <thead>
                            <tr>
                                <th>NO.</th>
                                <th>ID</th>
                                <th class="sortable-header">Username

                                </th>
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
                                    <td><a href="/users/${user.getId()}">${user.getFullname()}</a></td>
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


<!-- Modal Notification -->
<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="resultModalLabel">Result</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="resultMessage">
                <!-- Message Success -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal  approval -->
<div class="modal fade" id="modal-account-pending" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 1300px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">List account pending</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="datatable-account-pending" class="table-bordered">
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>User ID</th>
                        <th>Created date</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel2">Confirm Reject</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to reject this item?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="confirmReject">Reject</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        table = $('#datatable-account-pending').DataTable({
            ajax: {
                url: '/api/v1/users?status=PENDING',
                contentType: 'application/json',
                method: 'GET',
                dataSrc: 'listUser'
            },
            columns: [
                {data: 'fullname'},
                {data: 'email'},
                {data: 'createdDate'},
                {
                    render: function (data, type, row) {
                        return '<select style="width: 150px;" class="form-control" id="exampleFormControlSelect1" name="role">' +
                            '<option value="">-- Select role --</option>' +
                            '<option value="OWNER">Owner</option>' +
                            '<option value="MANAGER">Manager</option>' +
                            '<option value="DEVELOPER">Developer</option>' +
                            '</select>';
                    }
                },
                {
                    render: function (data, type, row) {
                        return '<button type="button" class="approval-btn btn btn-primary mr-1" data-status="ACTIVE" data-id="' + row.id + '">Approval</button>' +
                            '<button type="button" class="reject-btn btn btn-danger mr-1" data-status="REJECT" data-id="' + row.id + '">Reject</button>';
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        $('#datatable-account-pending').on('click', '.approval-btn', function () {
            var data = table.row($(this).parents('tr')).data();
            var obj = {
                email: data.email,
                role: $(this).closest('tr').find('select[name="role"]').val(),
                status: $(this).data('status'),
                id: $(this).data('id')
            };

            $('#datatable-account-pending').after(createLoadingHtml());
            callAjaxByJsonWithData('/api/v1/users/register/approval', 'PUT', obj, function (rs) {
                if (rs) {
                    table.ajax.reload();
                }
                location.reload();
            });
        });


        $('#datatable-account-pending').on('click', '.reject-btn', function () {

            $('#confirmModal').modal('show');

            var id = $(this).data('id');

            $('#confirmReject').on('click', function () {
                $('#datatable-account-pending').after(createLoadingHtml());
                callAjaxByJsonWithData('/api/v1/users/register/reject/' + id, 'DELETE', null, function (rs) {
                    if (rs) {
                        table.ajax.reload();
                    }
                    location.reload();
                });

                $('#confirmModal').modal('hide');
            });

        });
    });
</script>

<script>
    // Lưu giá trị lựa chọn "Page Count," "Status," và "Search" vào Local Storage khi thay đổi
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

    // Notification Delete User Success
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            $('#resultMessage').text(result === 'deleteSuccess' ? 'Delete User Success' : '');
            $('#resultModal').modal('show');
            sessionStorage.clear();
        }
    });

    // Khôi phục giá trị lựa chọn "Page Count," "Status," và "Search" từ Local Storage khi trang được load
    window.addEventListener("load", function () {
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

<script>
    // Show modal notification
    document.addEventListener("DOMContentLoaded", function () {
        var result = localStorage.getItem('result');
        if (result != null) notificationSuccess(localStorage.getItem('result'));
        localStorage.clear()
    });

    // Notification Success
    function notificationSuccess(result) {
        var title;
        var text;

        switch (result) {
            case 'delUserSuccess':
                title = 'Delete Success';
                break;
        }
        Swal.fire(
            {
                title: title,
                text: text,
                icon: 'success',
                showCancelButton: true,
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
