<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
<%--    <security:authorize access = "isAuthenticated()">--%>
    <nav class="navbar navbar-expand-lg navbar-light d-flex justify-content-around align-items-center">
        <a class="navbar-brand" href="/home">
            <img src="icon-cong-ty.png" alt="Công Ty" width="30" height="30">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-around align-items-center ml-5 pl-5" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link  text-light" href="/tasks">Task</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-light" href="/schedules">Schedule</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-light" href="/notifications">Notification</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-light" href="/schedules">Well-being</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-light" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Management
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="/users">Human Resource</a>
                        <a class="dropdown-item" href="/accounting">Accounting</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/timesheets">Timesheets</a>
                        <a class="dropdown-item" href="/notifications">Notification</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link  text-light" href="/settings">Setting</a>
                </li>
            </ul>
        </div>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-light" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <img src="<%=Principal.getUserCurrent().getAvatar()%>" alt="Avatar" width="30" height="30" class="img-thumbnail">
                    <%=Principal.getUserCurrent().getUsername()%>
                </a>
                <div class="dropdown-menu" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="/users">Profile</a>
                    <a class="dropdown-item" href="/settings">Setting</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="/logout">Logout</a>
                </div>
            </li>
        </ul>
    </nav>
<%--    </security:authorize>--%>
</header>