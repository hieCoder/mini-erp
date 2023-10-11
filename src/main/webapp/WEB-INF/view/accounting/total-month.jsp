<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Total Month Accounting</title>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <h1 class="text-center">Accounting</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <h3 class="mt-4">Years</h3>
            <ul class="list-group" id="yearList">
                <c:forEach varStatus="loop" items="${monthList.monthList}" var="date">
                    <li class="list-group-item year-item" data-toggle="collapse" href="#months${loop.index}">${date.year}</li>
                    <div class="collapse" id="months${loop.index}">
                        <ul class="list-group">
                            <c:forEach items="${date.month}" var="month">
                                <li class="list-group-item" onclick="redirectToAccounting('${month}')">${month}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script>
    function redirectToAccounting(month) {
        const trimmedMonth = month.replace(/\s/g, '');
        console.log(trimmedMonth);
        window.location.href = '/accounting/' + trimmedMonth;
    }
</script>
</body>
</html>
