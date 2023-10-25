<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<div class="container">

    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center mt-4">Login</h2>
            <c:if test="${param.logout != null}">
                <div class="alert alert-success">
                    Logout success
                </div>
            </c:if>
            <c:if test="${param.registerSuccess != null}">
                <div class="alert alert-success">
                    Register success! Waiting Owner approval
                </div>
            </c:if>
            <c:if test="${param.userNotFound != null}">
                <div class="alert alert-danger">
                    Email is not registered in the system
                </div>
            </c:if>
            <c:if test="${param.userLock != null}">
                <div class="alert alert-danger">
                    User is lock
                </div>
            </c:if>
            <c:if test="${param.userPending != null}">
                <div class="alert alert-danger">
                    User is pending
                </div>
            </c:if>
            <c:if test="${param.passwordInvalid != null}">
                <div class="alert alert-danger">
                    Password incorrect
                </div>
            </c:if>
            <form action="/j_spring_security_check" method="post">
                <div class="form-group">
                    <label for="username">User ID:</label>
                    <input type="email" class="form-control" id="username" name="username" placeholder="User ID" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Login</button>
            </form>
            <p class="text-center mt-3">Don't have an account? <a href="/register">Register</a></p>
        </div>
    </div>
</div>
</body>
</html>