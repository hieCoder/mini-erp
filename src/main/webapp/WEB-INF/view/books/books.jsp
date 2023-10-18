<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="form" action="" method="GET">
    <div class="container">
        <h1 class="mt-4">BOOKS</h1>
        <div class="row mt-4">
            <div class="col-md-6">
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
        </div>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">NO.</th>
                <th scope="col">ID</th>
                <th scope="col">Title</th>
                <th scope="col">Author</th>
                <th scope="col">Link</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <%--<c:forEach var="contract" items="${user.contracts}">--%>
                <tr>
                    <th scope="row">${(users.pageNumber - 1) * users.pageSize + loop.index + 1}</th>
                    <td>1123</td>
                    <td>conchimnon</td>
                    <td>trung hieu</td>
                    <td><a href="" target="_blank" class="contractLink text-decoration-none">Book Link</a></td>
                    <td>
                        <button value="" type="button"
                                class="btn btn-primary edit-contract-button">Edit
                        </button>
                        <button value="" type="button"
                                class="btn btn-danger delete-contract-button">Delete
                        </button>
                    </td>
                </tr>
            <%--</c:forEach>--%>
            </tbody>
        </table>
        <!-- Pagination -->
        <%--        <div class="row justify-content-center">--%>
        <%--            <ul class="pagination">--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasPrevious}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="1"><<</button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasPrevious}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="${users.pageNumber - 1}"><</button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--                <c:forEach var="page" begin="1" end="${users.totalPages}">--%>
        <%--                    <c:choose>--%>
        <%--                        <c:when test="${page == users.pageNumber}">--%>
        <%--                            <li class="page-item active"><a class="page-link" href="#">${page}</a></li>--%>
        <%--                        </c:when>--%>
        <%--                        <c:otherwise>--%>
        <%--                            <li class="page-item">--%>
        <%--                                <button class="page-link" type="submit" name="page" value="${page}">${page}</button>--%>
        <%--                            </li>--%>
        <%--                        </c:otherwise>--%>
        <%--                    </c:choose>--%>
        <%--                </c:forEach>--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasNext}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="${users.pageNumber + 1}">></button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasNext}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="${users.totalPages}">>></button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--            </ul>--%>
        <%--        </div>--%>
    </div>
</form>

<script>
    // Get value Search save to Local Storage
    document.getElementById("search").addEventListener("input", function () {
        localStorage.setItem("selectedSearch", this.value);
    });

    // Restore "Search" value from Local Storage
    window.addEventListener("load", function () {
        var selectedSearch = localStorage.getItem("selectedSearch");
        if (selectedSearch) {
            document.getElementById("search").value = selectedSearch;
        }
    });

</script>

</body>
</html>
