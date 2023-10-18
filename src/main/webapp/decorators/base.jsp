<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <%-- datatable --%>
    <link rel="stylesheet" href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <%-- summernote --%>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">

    <dec:head/>

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
            id: <%="'" + Principal.getUserCurrent().getId() + "'"%>,
            fullname: <%="'" + Principal.getUserCurrent().getFullname() + "'"%>,
            role: <%="'" + Principal.getUserCurrent().getRole() + "'"%>,
            avatar: <%=Principal.getUserCurrent().getAvatar() != null?"'/upload/user/"+Principal.getUserCurrent().getAvatar() + "'":"''"%>
        };
    </script>
</head>
<body>
<%@ include file="/common/layout-component/header.jsp"%>

<main class="content-wrapper">
    <dec:body/>
</main>

<%@ include file="/common/layout-component/footer.jsp"%>

<%-- bootstrap --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%-- summernote --%>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<%-- sweetalert --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    $('.avatar-login').attr('src', userCurrent.avatar);
    $('.fullname-login').text(userCurrent.fullname);
    $('.profile-user-login').attr('href', '/users/' +userCurrent.id);
    var scheduleLink = '';
    if(userCurrent.role != U_DEVELOPER) scheduleLink = '/schedules';
    else scheduleLink = '/schedules/detail/'+userCurrent.id;
    $('.schedule-login').attr('href', scheduleLink);
    if(userCurrent.role == U_DEVELOPER){
        $('.human-login').remove();
        $('.setting-login').remove();
    }
</script>
</body>
</html>
