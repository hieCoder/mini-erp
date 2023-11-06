<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schedule List</title>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title mb-0">Schedule List</h4>
            </div><!-- end card header -->
            <div class="card-body">
                <div id="scheduleList">
                    <div class="table-responsive table-card mt-3 mb-1">
                        <table class="table align-middle table-nowrap">
                            <thead class="table-light">
                            <tr>
                                <th>NO.</th>
                                <th>Username</th>
                            </tr>
                            </thead>
                            <tbody class="list form-check-all">
                            <c:forEach varStatus="loop"  var="user" items="${requestScope.list}">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td class="fw-bold"><a target="_blank" href="/schedules/detail/${user.id}"><c:out value="${user.fullname}"/></a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                    </div>

                </div>
            </div><!-- end card -->
        </div>
        <!-- end col -->
    </div>
    <!-- end col -->
</div>
</body>
</html>
