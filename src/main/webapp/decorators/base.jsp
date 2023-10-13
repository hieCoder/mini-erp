<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><dec:title default="Base page" /></title>
    <%-- main --%>
    <link rel="stylesheet" href="/assets/css/main.css">
    <%-- bootstrap --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <%-- datatable --%>
    <link rel="stylesheet" href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <%-- summernote --%>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">

    <%-- main --%>
    <script src="/assets/js/main.js"></script>
    <%-- jquery --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <%-- datatable --%>
    <script src="//cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <%-- twbsPagination --%>
    <script src="/assets/js/jquery.twbsPagination.js"></script>
    <script src="/assets/js/validation.js"></script>
    <script>
        var userCurrent = {
            id: <%=Principal.getUserCurrent().getId()%>,
            fullname: <%="'" + Principal.getUserCurrent().getFullname() + "'"%>,
            role: <%="'" + Principal.getUserCurrent().getRole() + "'"%>
        };
    </script>
</head>
<body>
<%@ include file="/common/layout-component/header.jsp"%>

<div class="content-wrapper">
    <dec:body/>
</div>

<%@ include file="/common/layout-component/footer.jsp"%>
<%-- bootstrap --%>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<%-- summernote --%>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<%-- sweetalert --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>