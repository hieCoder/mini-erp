<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="form" action="/users" method="GET">
    <div class="container">   
        <h1 class="mt-4">List User Calendar</h1>
        <%--        <div class="row mt-4">--%>
        <%--            <div class="col-md-6">--%>
        <%--                <div class="form-group">--%>
        <%--                    <label for="search">Search</label>--%>
        <%--                    <div class="input-group">--%>
        <%--                        <input id="search" name="search" type="text" class="form-control"--%>
        <%--                               placeholder="Search">--%>
        <%--                        <div class="input-group-append">--%>
        <%--                            <button class="btn btn-primary" type="submit">Search</button>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <table class="table mt-4 table-bordered">
            <thead>
            <tr>
                <th>NO.</th>
                <th class="sortable-header">Fullname</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="user" varStatus="loop">
                <tr>
                        <%--          <th scope="row">${(users.pageNumber - 1) * users.pageSize + loop.index + 1}</th>&ndash;%&gt;--%>
                    <td>${loop.index + 1}</td>
                    <td><a href="/management-time/${user.id}" class="text-decoration-none">
                        <c:out value="${user.fullname}"/></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- Pagination -->
        <%--    <div class="row justify-content-center">--%>
        <%--      <ul class="pagination">--%>
        <%--        <li class="page-item">--%>
        <%--          <c:if test="${users.hasPrevious}">--%>
        <%--            <button class="page-link" type="submit" name="page" value="1"><<</button>--%>
        <%--          </c:if>--%>
        <%--        </li>--%>
        <%--        <li class="page-item">--%>
        <%--          <c:if test="${users.hasPrevious}">--%>
        <%--            <button class="page-link" type="submit" name="page" value="${users.pageNumber - 1}"><</button>--%>
        <%--          </c:if>--%>
        <%--        </li>--%>
        <%--        <c:forEach var="page" begin="1" end="${users.totalPages}">--%>
        <%--          <c:choose>--%>
        <%--            <c:when test="${page == users.pageNumber}">--%>
        <%--              <li class="page-item active"><a class="page-link" href="#">${page}</a></li>--%>
        <%--            </c:when>--%>
        <%--            <c:otherwise>--%>
        <%--              <li class="page-item">--%>
        <%--                <button class="page-link" type="submit" name="page" value="${page}">${page}</button>--%>
        <%--              </li>--%>
        <%--            </c:otherwise>--%>
        <%--          </c:choose>--%>
        <%--        </c:forEach>--%>
        <%--        <li class="page-item">--%>
        <%--          <c:if test="${users.hasNext}">--%>
        <%--            <button class="page-link" type="submit" name="page" value="${users.pageNumber + 1}">></button>--%>
        <%--          </c:if>--%>
        <%--        </li>--%>
        <%--        <li class="page-item">--%>
        <%--          <c:if test="${users.hasNext}">--%>
        <%--            <button class="page-link" type="submit" name="page" value="${users.totalPages}">>></button>--%>
        <%--          </c:if>--%>
        <%--        </li>--%>
        <%--      </ul>--%>
        <%--    </div>--%>
    </div>
</form>


</body>
</html>
