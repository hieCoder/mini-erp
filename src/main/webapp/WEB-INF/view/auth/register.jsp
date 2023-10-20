<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center mt-4">Register</h2>
            <form id="registerForm">
                <div class="form-group">
                    <label for="fullname">Username:</label>
                    <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Username">
                    <small class="form-message"></small>
                </div>
                <div class="form-group">
                    <label for="email">User ID:</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="User ID">
                    <small class="form-message"></small>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                    <small class="form-message"></small>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password">
                    <small class="form-message"></small>
                </div>
                <button id="registerBtn" type="submit" class="btn btn-primary btn-block">Register</button>
            </form>
            <p class="text-center mt-3">Back to login? <a href="/login">Login</a></p>
        </div>
    </div>
</div>
<script>

    Validator({
        form:'#registerForm',
        errorSelector: '.form-message',
        rules:[
            Validator.isRequired('#fullname'),
            Validator.isRequired('#email'),
            Validator.isEmail('#email'),
            Validator.isRequired('#password'),
            Validator.isFormatPassword('#password'),
            Validator.isRequired('#confirmPassword'),
            Validator.isFormatPassword('#confirmPassword'),
            Validator.isConfirmed('#confirmPassword',function () {
                return document.querySelector('#registerForm #password').value;
            }, 'Password is not macth')
        ],
        onSubmit: function (formData) {
            callAjaxByJsonWithDataForm("/api/v1/auth/register", "POST", formData, function (rs) {
                window.location.href = "/login?registerSuccess";
            }, 'registerForm');
        }
    });
</script>
</body>
</html>