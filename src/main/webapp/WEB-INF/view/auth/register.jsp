<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<%--<div class="container">--%>
<%--    <div class="row justify-content-center">--%>
<%--        <div class="col-md-6">--%>
<%--            <h2 class="text-center mt-4">Register</h2>--%>
<%--            <form id="registerForm">--%>
<%--                <div class="form-group">--%>
<%--                    <label for="fullname">Username:</label>--%>
<%--                    <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Username">--%>
<%--                    <small class="form-message"></small>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="email">User ID:</label>--%>
<%--                    <input type="email" class="form-control" id="email" name="email" placeholder="User ID">--%>
<%--                    <small class="form-message"></small>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="password">Password:</label>--%>
<%--                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">--%>
<%--                    <small class="form-message"></small>--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label for="confirmPassword">Confirm Password:</label>--%>
<%--                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password">--%>
<%--                    <small class="form-message"></small>--%>
<%--                </div>--%>
<%--                <button id="registerBtn" type="submit" class="btn btn-primary btn-block">Register</button>--%>
<%--            </form>--%>
<%--            <p class="text-center mt-3">Back to login? <a href="/login">Login</a></p>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<script>--%>

<%--    Validator({--%>
<%--        form:'#registerForm',--%>
<%--        errorSelector: '.form-message',--%>
<%--        rules:[--%>
<%--            Validator.isRequired('#fullname'),--%>
<%--            Validator.isRequired('#email'),--%>
<%--            Validator.isEmail('#email'),--%>
<%--            Validator.isRequired('#password'),--%>
<%--            Validator.isFormatPassword('#password'),--%>
<%--            Validator.isRequired('#confirmPassword'),--%>
<%--            Validator.isFormatPassword('#confirmPassword'),--%>
<%--            Validator.isConfirmed('#confirmPassword',function () {--%>
<%--                return document.querySelector('#registerForm #password').value;--%>
<%--            }, 'Password is not macth')--%>
<%--        ],--%>
<%--        onSubmit: function (formData) {--%>
<%--            callAjaxByJsonWithDataForm("/api/v1/auth/register", "POST", formData, function (rs) {--%>
<%--                window.location.href = "/login?registerSuccess";--%>
<%--            }, 'registerForm');--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>
<div class="col-md-8 col-lg-6 col-xl-5">
    <div class="card mt-4">

        <div class="card-body p-4">
            <div class="text-center mt-2">
                <h5 class="text-primary">Register</h5>
                <p class="text-muted">Welcome Sh Soft Vina !</p>
            </div>
            <div class="p-2 mt-4">
                <form class="needs-validation" novalidate action="index.html">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="username" placeholder="Enter username" required>
                        <div class="invalid-feedback">
                            Please enter username
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="userid" class="form-label">User ID <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="userid" placeholder="Enter User ID" required>
                        <div class="invalid-feedback">
                            Please enter email
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password-input">Password</label>
                        <div class="position-relative auth-pass-inputgroup">
                            <input type="password" class="form-control pe-5 password-input" onpaste="return false" placeholder="Enter password" id="password-input" aria-describedby="passwordInput" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                            <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon" type="button" id="password-addon"><i class="ri-eye-fill align-middle"></i></button>
                            <div class="invalid-feedback">
                                Please enter password
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="password-input">Password Confirm</label>
                        <div class="position-relative auth-pass-inputgroup">
                            <input type="password" class="form-control pe-5 password-input" onpaste="return false" placeholder="Enter password confirm" id="password-confirm-input" aria-describedby="passwordInput" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                            <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon" type="button" id="password-confirm-addon"><i class="ri-eye-fill align-middle"></i></button>
                            <div class="invalid-feedback">
                                Please enter password
                            </div>
                        </div>
                    </div>

                    <div id="password-contain" class="p-3 bg-light mb-2 rounded">
                        <h5 class="fs-13">Password must contain:</h5>
                        <p id="pass-length" class="invalid fs-12 mb-2">Minimum <b>8 characters</b></p>
                        <p id="pass-lower" class="invalid fs-12 mb-2">At <b>lowercase</b> letter (a-z)</p>
                        <p id="pass-upper" class="invalid fs-12 mb-2">At least <b>uppercase</b> letter (A-Z)</p>
                        <p id="pass-number" class="invalid fs-12 mb-0">A least <b>number</b> (0-9)</p>
                    </div>

                    <div class="mt-4">
                        <button class="btn btn-success w-100" type="submit">Register</button>
                    </div>
                </form>

            </div>
        </div>
        <!-- end card body -->
    </div>
    <!-- end card -->

    <div class="mt-4 text-center">
        <p class="mb-0">Already have an account ? <a href="/login" class="fw-semibold text-primary text-decoration-underline"> Login </a> </p>
    </div>

</div>
<!-- validation init -->
<script src="/assets/js/pages/form-validation.init.js"></script>
<!-- password create init -->
<script src="/assets/js/pages/passowrd-create.init.js"></script>
</body>
</html>