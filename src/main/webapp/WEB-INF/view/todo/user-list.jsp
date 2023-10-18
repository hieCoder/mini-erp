<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/13/2023
  Time: 9:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Management Time List</title>
</head>
<body>
<div class="container text-center mt-5">
    <h1>Management Time List</h1>
</div>

<div class="container mt-4">
    <table class="table">
        <thead>
        <tr>
            <th>NO.</th>
            <th>Username</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach varStatus="loop"  var="user" items="${requestScope.list}">
            <tr>
                <td>${loop.index + 1}</td>
                <td><a href="/management-time/${user.id}"><c:out value="${user.fullname}"/></a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
