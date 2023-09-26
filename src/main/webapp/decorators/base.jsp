<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><dec:title default="Base page" /></title>
    <link rel="stylesheet" href="/assets/css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<%@ include file="/common/layout-component/header.jsp"%>

<div class="content-wrapper">
    <dec:body/>
</div>

<%@ include file="/common/layout-component/footer.jsp"%>
</body>
</html>
