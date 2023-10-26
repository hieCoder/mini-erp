<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <security:authorize access = "isAuthenticated()">
        <nav class="navbar navbar-expand-lg navbar-light d-flex justify-content-around align-items-center">
            <a class="navbar-brand" href="/home">
                <img src="/upload/logo.png" alt="Logo Công Ty" height="30">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-around align-items-center ml-5 pl-5" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-light" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Task
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown1">
                            <a class="dropdown-item" href="/tasks">Task</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/weekly-reports">Weekly report</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item schedule-login">Schedule</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  text-light" href="/notifications">Notification</a>
                    </li>
                    <li class="nav-item dropdown management-login">
                        <a class="nav-link dropdown-toggle text-light" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Management
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
                            <a class="dropdown-item human-login" href="/users">Human</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/accounting">Accounting</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/timesheets">Timesheets</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-light" href="#" id="navbarDropdown3" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Management time
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown3">
                            <a class="dropdown-item management-time-day-login">Management day</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/books">Reading book</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown setting-login">
                        <a class="nav-link dropdown-toggle text-light" href="#" id="navbarDropdown4" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Setting
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown4">
                            <a class="dropdown-item" href="/settings/file">File</a>
                        </div>
                    </li>
                </ul>
            </div>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-light d-flex align-items-center" href="#" id="userDropdown"
                       role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%--                        <div class="d-flex align-items-center">--%>
                            <%--                            <img alt="Avatar" width="40" height="40" class="img-thumbnail avatar-login">--%>
                            <%--                            <div class="ml-4">--%>
                            <%--                                <div class="row">--%>
                            <%--                                    <span class="position-login">Phòng Ban</span>--%>
                            <%--                                </div>--%>
                            <%--                                <div class="row">--%>
                            <%--                                    <span class="fullname-login"></span>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                            <%--                        </div>--%>
                        <div class="row">
                            <div class="col-md-4 d-flex flex-column align-items-center">
                                <img alt="Avatar" width="40" height="40" class="img-thumbnail avatar-login">
                                <figcation class="fullname-login"></figcation>
                            </div>
                            <div class="col-md-6 d-flex flex-column justify-content-center">
                                <span class="department-login" style="font-size: 14px;font-style: italic; font-weight: bold;"></span>
                                <span class="position-login" style="text-align: center; font-size: 13px;"></span>
                            </div>
                        </div>
                    </a>
                    <span class="caret"></span>
                    <div class="dropdown-menu" aria-labelledby="userDropdown">
                        <a class="dropdown-item profile-user-login">Profile</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/logout">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
    </security:authorize>
</header>