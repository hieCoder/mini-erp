<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<%--<div class="container">--%>

<%--    <div class="row justify-content-center">--%>
<%--        <div class="col-md-6">--%>
<%--            <h2 class="text-center mt-4">Login</h2>--%>
<%--            <c:if test="${param.logout != null}">--%>
<%--                <div class="alert alert-success">--%>
<%--                    Logout success--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <c:if test="${param.registerSuccess != null}">--%>
<%--                <div class="alert alert-success">--%>
<%--                    Register success! Waiting Owner approval--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <c:if test="${param.userNotFound != null}">--%>
<%--                <div class="alert alert-danger">--%>
<%--                    Email is not registered in the system--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <c:if test="${param.userLock != null}">--%>
<%--                <div class="alert alert-danger">--%>
<%--                    User is lock--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <c:if test="${param.userPending != null}">--%>
<%--                <div class="alert alert-danger">--%>
<%--                    User is pending--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <c:if test="${param.passwordInvalid != null}">--%>
<%--                <div class="alert alert-danger">--%>
<%--                    Password incorrect--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--            <form action="/j_spring_security_check" method="post">--%>
<%--                <div class="form-group">--%>
<%--                    <label for="username">User ID:</label>--%>
<%--                    <input type="email" class="form-control" id="username" name="username" placeholder="User ID" required>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="password">Password:</label>--%>
<%--                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>--%>
<%--                </div>--%>
<%--                <button type="submit" class="btn btn-primary btn-block">Login</button>--%>
<%--            </form>--%>
<%--            <p class="text-center mt-3">Don't have an account? <a href="/register">Register</a></p>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<div class="col-md-8 col-lg-6 col-xl-5">
    <div class="card mt-4">

        <div class="card-body p-4">
            <div class="text-center mt-2">
                <h5 class="text-primary">Login</h5>
                <p class="text-muted">Welcome Sh Soft Vina !</p>
            </div>
            <div class="p-2 mt-4">
                <form action="/j_spring_security_check" method="post" id="formLogin">

                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success" role="alert">
                            Login success
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

                    <div class="mb-3">
                        <label for="username" class="form-label">User ID</label>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Enter User ID">
                        <small class="form-message"></small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password">Password</label>
                        <div class="position-relative auth-pass-inputgroup mb-3">
                            <input type="password" class="form-control pe-5 password-input" placeholder="Enter password" id="password" name="password">
                            <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon" type="button" id="password-addon"><i class="ri-eye-fill align-middle"></i></button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <button class="btn btn-success w-100" type="button" id="signInButton">Sign In</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- end card body -->
    </div>
    <!-- end card -->

    <div class="mt-4 text-center">
        <p class="mb-0">Don't have an account ? <a href="/register" class="fw-semibold text-primary text-decoration-underline"> Register </a> </p>
    </div>

</div>
<!-- password-addon init -->
<script src="/assets/js/pages/password-addon.init.js"></script>
<%-- jquery --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="/assets/custom/js/validation.js"></script>
<script>
    $(document).ready(function () {
        $("#signInButton").click(function () {
            console.log(123);
            $("#formLogin").submit();
        });
    });
</script>
</body>
</html>