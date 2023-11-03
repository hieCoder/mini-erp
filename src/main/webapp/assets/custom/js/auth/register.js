$(document).ready(function () {
    Validator({
        form:'#registerForm',
        errorSelector: '.form-message',
        rules:[
            Validator.isRequired('#fullname'),
            Validator.isRequired('#email'),
            Validator.isEmail('#email'),
            Validator.isRequired('#password-input'),
            Validator.isFormatPassword('#password-input'),
            Validator.isRequired('#password-confirm-input'),
            Validator.isConfirmed('#password-confirm-input',function () {
                return document.querySelector('#registerForm #password-input').value;
            }, 'Password is not macth')
        ],
        onSubmit: function (formData) {
            callAjaxByJsonWithDataForm("/api/v1/auth/register", "POST", formData, function (rs) {
                window.location.href = "/login?registerSuccess";
            }, function (err) {
                window.location.href = "/register?fail=userIdExisted";
            });
        }
    });
});