<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/10/2023
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="form" action="/users" method="GET">
    <div class="container">
        <h1 class="mt-4">LIST USER</h1>
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="search">Search</label>
                    <div class="input-group">
                        <input id="search" name="search" type="text" class="form-control" placeholder="Search">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="submit">Search</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" class="form-select" onchange="this.form.submit()">
                        <option value="ACTIVE">ACTIVE</option>
                        <option value="INACTIVE">INACTIVE</option>
                        <option value="PENDING">PENDING</option>
                        <option value="REJECT">REJECT</option>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label for="pageSize">Page Count</label>
                    <select id="pageSize" name="pageSize" class="form-select" onchange="this.form.submit()">
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                    </select>
                </div>
            </div>

        </div>
        <table class="table mt-4 table-bordered">
            <thead>
            <tr>
                <th>NO.</th>
                <th>ID</th>
                <th class="sortable-header">Username
                    <button style="border: none; margin: 0" class="btn-link" type="submit" name="sort" value="ASC">&#9650;</button>
                    <button style="border: none; margin: 0" class="btn-link" type="submit" name="sort" value="DESC">&#9660;</button>
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
                    <td><a href="/userDetail/${user.getId()}">${user.getFullname()}</a></td>
                    <td>${user.getEmail()}</td>
                    <td>${user.getDepartment().getName()}</td>
                    <td>${user.getPosition().getName()}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- Pagination -->
        <div class="row justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <c:if test="${users.hasPrevious}">
                        <button class="page-link" type="submit" name="page" value="1"><<</button>
                    </c:if>
                </li>
                <li class="page-item">
                    <c:if test="${users.hasPrevious}">
                        <button class="page-link" type="submit" name="page" value="${users.pageNumber - 1}"><</button>
                    </c:if>
                </li>
                <c:forEach var="page" begin="1" end="${users.totalPages}">
                    <c:choose>
                        <c:when test="${page == users.pageNumber}">
                            <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <button class="page-link" type="submit" name="page" value="${page}">${page}</button>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <li class="page-item">
                    <c:if test="${users.hasNext}">
                        <button class="page-link" type="submit" name="page" value="${users.pageNumber + 1}">></button>
                    </c:if>
                </li>
                <li class="page-item">
                    <c:if test="${users.hasNext}">
                        <button class="page-link" type="submit" name="page" value="${users.totalPages}">>></button>
                    </c:if>
                </li>
            </ul>
        </div>

    </div>
</form>

<script>
    // Lưu giá trị lựa chọn "Page Count," "Status," và "Search" vào Local Storage khi thay đổi
    document.getElementById("pageSize").addEventListener("change", function() {
        localStorage.setItem("selectedPageSize", this.value);
    });

    document.getElementById("status").addEventListener("change", function() {
        localStorage.setItem("selectedStatus", this.value);
    });

    document.getElementById("search").addEventListener("input", function() {
        localStorage.setItem("selectedSearch", this.value);
    });




    // Khôi phục giá trị lựa chọn "Page Count," "Status," và "Search" từ Local Storage khi trang được load
    window.addEventListener("load", function() {
        var selectedPageSize = localStorage.getItem("selectedPageSize");
        if (selectedPageSize) {
            document.getElementById("pageSize").value = selectedPageSize;
        }

        var selectedStatus = localStorage.getItem("selectedStatus");
        if (selectedStatus) {
            document.getElementById("status").value = selectedStatus;
        }

        var selectedSearch = localStorage.getItem("selectedSearch");
        if (selectedSearch) {
            document.getElementById("search").value = selectedSearch;
        }
    });


</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>
