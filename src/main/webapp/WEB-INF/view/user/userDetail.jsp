<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User detail</title>

</head>
<body>
<%--==========================================New Code======================================================--%>
<div class="position-relative mx-n4 mt-n4">
    <div class="profile-wid-bg profile-setting-img">
        <img src="/assets/images/profile-bg.jpg" class="profile-wid-img" alt="">
        <div class="overlay-content">
            <div class="text-end p-3">
                <div class="p-0 ms-auto rounded-circle profile-photo-edit">
                    <input id="profile-foreground-img-file-input" type="file" class="profile-foreground-img-file-input">
                    <label for="profile-foreground-img-file-input" class="profile-photo-edit btn btn-light">
                        <i class="ri-image-edit-line align-bottom me-1"></i> Change Cover
                    </label>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row" style="margin-bottom: 60px;">
    <div class="col-xxl-3">
        <div class="card mt-n5">
            <div class="card-body p-4">
                <div class="text-center">
                    <div class="profile-user position-relative d-inline-block mx-auto  mb-4">
                        <img src="${user.getAvatar()}" id="avatar-user"
                             class="rounded-circle avatar-xl img-thumbnail user-profile-image" alt="user-profile-image">
                        <div class="avatar-xs p-0 rounded-circle profile-photo-edit">
                            <input id="avatar" type="file" class="profile-img-file-input" name="avatar"
                                   accept="image/*" id="avatar">
                            <label for="avatar" class="profile-photo-edit avatar-xs">
                                                    <span class="avatar-title rounded-circle bg-light text-body">
                                                        <i class="ri-camera-fill"></i>
                                                    </span>
                            </label>
                        </div>
                        <div id="delete-avatar-button"
                             style="position: absolute; top: -8px; right: -8px; color: black; padding: 0px; cursor: pointer; display: none;">
                            X
                        </div>
                    </div>
                    <h5 class="fs-16 mb-1">${user.fullname}</h5>
                    <p class="text-muted mb-0">${user.position.name} / ${user.department.name}</p>
                </div>
            </div>
        </div>
        <!--end card-->
        <div class="card">
            <div class="card-body">
                <div class="d-flex align-items-center mb-2">
                    <div class="flex-grow-1">
                        <h5 class="card-title mb-0">Total Working Day</h5>
                    </div>
                </div>
                <div class="input-group" id="working-day">
                    <select class="form-control" id="working-year">
                        <option value="">-- Select year --</option>
                    </select>
                    <select class="form-control" id="working-month" style="display: none;">
                        <option>-- Select month --</option>
                    </select>
                    <input type="text" class="form-control" id="totalWorkingDay" readonly
                           placeholder="Result" disabled>
                </div>
            </div>
        </div>
        <div class="card">
            <button type="submit" class="btn btn-danger">Delete User</button>
        </div>
    </div>
    <!--end col-->
    <div class="col-xxl-9">
        <div class="card mt-xxl-n5">
            <div class="card-header">
                <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab">
                            <i class="fas fa-home"></i> Basic Information
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#changePassword" role="tab">
                            <i class="far fa-user"></i> Detail Information
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#experience" role="tab">
                            <i class="far fa-envelope"></i> Resume
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#privacy" role="tab">
                            <i class="far fa-envelope"></i> Contract
                        </a>
                    </li>
                </ul>
            </div>
            <div class="card-body p-4">
                <div class="tab-content">
                    <div class="tab-pane active" id="personalDetails" role="tabpanel">
                        <form action="javascript:void(0);">
                            <div class="row">
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="userName" class="form-label">Username</label>
                                        <input type="text" class="form-control" placeholder="Enter Username"
                                               id="userName" name="fullname" value="${user.fullname}" required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="phonenumberInput" class="form-label">Phone Number</label>
                                        <input type="number" class="form-control" placeholder="+(84)xxx xxx xxx"
                                               id="phonenumberInput" name="phone" value="${user.phone}" required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="emergencyPhone" class="form-label">Emergency Phone</label>
                                        <input type="number" class="form-control" placeholder="+(84)xxx xxx xxx"
                                               id="emergencyPhone" name="emergencyPhone" value="${user.emergencyPhone}"
                                               required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="address1ControlTextarea" class="form-label">Address</label>
                                        <input type="text" class="form-control" placeholder="Address"
                                               id="address1ControlTextarea" name="address" value="${user.address}"
                                               required>
                                    </div>
                                </div><!--end col-->
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="dateOfBirth" class="form-label">Date of birth</label>
                                        <input type="date" class="form-control" id="dateOfBirth"
                                               value="${user.dateOfBirth}" required>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="timeSheetsCode" class="form-label">TimeSheets Code</label>
                                        <input type="text" class="form-control" placeholder="Enter TimeSheets Code"
                                               id="timeSheetsCode" name="timesheetsCode" value="${user.timesheetsCode}">
                                    </div>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="gender" class="form-label">Gender</label>
                                        <select id="gender" class="form-select" name="gender" required>
                                            <option value="" selected>Choose...</option>
                                            <option value="MALE"
                                                    <c:if test="${user.gender.code.equals('MALE')}">selected</c:if>
                                            >Male
                                            </option>
                                            <option value="FEMALE"
                                                    <c:if test="${user.gender.code.equals('FEMALE')}">selected</c:if>
                                            >Female
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->
                                <div class="col-lg-12">
                                    <div class="hstack gap-2 justify-content-end">
                                        <button type="submit" class="btn btn-primary">Updates</button>
                                        <button type="button" class="btn btn-soft-success">Cancel</button>
                                    </div>
                                </div>
                            </div><!--end row-->
                        </form>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="changePassword" role="tabpanel">
                        <form action="javascript:void(0);">
                            <div class="row g-2">
                                <div class="col-6">
                                    <label for="type" class="form-label">Type</label>
                                    <select id="type" class="form-select" name="type">
                                        <option value="" selected>Choose...</option>
                                        <option value="OFFICIAL"
                                                <c:if test="${user.type.code.equals('OFFICIAL')}">selected</c:if>
                                        >Official
                                        </option>
                                        <option value="PROBATION"
                                                <c:if test="${user.type.code.equals('PROBATION')}">selected</c:if>
                                        >Probation
                                        </option>
                                        <option value="PARTTIME"
                                                <c:if test="${user.type.code.equals('PARTTIME')}">selected</c:if>
                                        >Parttime
                                        </option>
                                    </select>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="department" class="form-label">Department</label>
                                        <select id="department" class="form-select" name="department">
                                            <option value="" selected>Choose...</option>
                                            <option value="ADMINISTRATION"
                                                    <c:if test="${user.department.code.equals('ADMINISTRATION')}">selected</c:if>>
                                                Administration
                                            </option>
                                            <option value="MANAGEMENT"
                                                    <c:if test="${user.department.code.equals('MANAGEMENT')}">selected</c:if>>
                                                Management
                                            </option>
                                            <option value="UI_UX"
                                                    <c:if test="${user.department.code.equals('UI_UX')}">selected</c:if>>
                                                UI/UX
                                            </option>
                                            <option value="DEV1"
                                                    <c:if test="${user.department.code.equals('DEV1')}">selected</c:if>>
                                                Dev1
                                            </option>
                                            <option value="DEV2"
                                                    <c:if test="${user.department.code.equals('DEV2')}">selected</c:if>>
                                                Dev2
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label for="userId" class="form-label">User ID</label>
                                        <input type="email" class="form-control" id="userId"
                                               placeholder="Enter User Id" name="email" value="${user.email}">
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label for="changePassword" class="form-label">Password: </label>
                                        <a id="change-password-button" class="text-primary text-decoration-none"
                                           style="cursor: pointer;">Change password</a>
                                    </div>
                                </div>
                                <div class="col-6 hide" style="display: none">
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password*</label>
                                        <div class="position-relative auth-pass-inputgroup mb-3">
                                            <input type="password" class="form-control" placeholder="Enter new password"
                                                   id="newPassword" name="password">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 hide" style="display: none;">
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm Password*</label>
                                        <div class="position-relative auth-pass-inputgroup mb-3">
                                            <input type="password" class="form-control" placeholder="Confirm password"
                                                   id="confirmPassword">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="atm" class="form-label">ATM</label>
                                        <input type="text" class="form-control" placeholder="ATM" id="atm" name="atm"
                                               value="${user.atm}">
                                    </div>
                                </div>
                                <div class="col-6">
                                    <label for="role" class="form-label">Role</label>
                                    <select id="role" class="form-select" name="role">
                                        <option selected>Choose...</option>
                                        <option value="OWNER"
                                                <c:if test="${user.role.code.equals('OWNER')}">selected</c:if>>
                                            Owner
                                        </option>
                                        <option value="MANAGER"
                                                <c:if test="${user.role.code.equals('MANAGER')}">selected</c:if>>
                                            Manager
                                        </option>
                                        <option value="DEVELOPER"
                                                <c:if test="${user.role.code.equals('DEVELOPER')}">selected</c:if>>
                                            Developer
                                        </option>
                                    </select>
                                </div><!--end col-->
                                <div class="col-6">
                                    <div class="mb-3">
                                        <label for="position" class="form-label">Position</label>
                                        <select id="position" class="form-select" name="position">
                                            <option value="" selected>Choose...</option>
                                            <option value="INTERN"
                                                    <c:if test="${user.position.code.equals('INTERN')}">selected</c:if>>
                                                Intern
                                            </option>
                                            <option value="JUNIOR"
                                                    <c:if test="${user.position.code.equals('JUNIOR')}">selected</c:if>>
                                                Junior
                                            </option>
                                            <option value="SENIOR"
                                                    <c:if test="${user.position.code.equals('SENIOR')}">selected</c:if>>
                                                Senior
                                            </option>
                                            <option value="MANAGER"
                                                    <c:if test="${user.position.code.equals('MANAGER')}">selected</c:if>>
                                                Manager
                                            </option>
                                            <option value="SENIOR_MANAGER"
                                                    <c:if test="${user.position.code.equals('SENIOR_MANAGER')}">selected</c:if>>
                                                Senior manager
                                            </option>
                                            <option value="OWNER"
                                                    <c:if test="${user.position.code.equals('OWNER')}">selected</c:if>>
                                                Owner
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->
                                <div class="col-lg-12">
                                    <div class="hstack gap-2 justify-content-end">
                                        <button type="submit" class="btn btn-primary">Updates</button>
                                        <button type="button" class="btn btn-soft-success">Cancel</button>
                                    </div>
                                </div>
                            </div>
                            <!--end row-->
                        </form>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="experience" role="tabpanel">
                        <form>
                            heello
                            <div class="hstack gap-2 justify-content-end">
                                <button type="submit" class="btn btn-primary">Save</button>
                                <button type="button" class="btn btn-soft-success">Cancel</button>
                            </div>
                        </form>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="privacy" role="tabpanel">
                        <div class="hstack gap-2 justify-content-end">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn btn-soft-success">Cancel</button>
                        </div>
                    </div>
                    <!--end tab-pane-->
                </div>
            </div>
        </div>
    </div>
    <!--end col-->
</div>
<footer class="footer">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <script>document.write(new Date().getFullYear())</script>
                © Velzon.
            </div>
            <div class="col-sm-6">
                <div class="text-sm-end d-none d-sm-block">
                    Design & Develop by Themesbrand
                </div>
            </div>
        </div>
    </div>
</footer>

<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>

<script src="/assets/js/pages/profile-setting.init.js"></script>
<script src="assets/libs/prismjs/prism.js"></script>
<script>

    document.getElementById('change-password-button').addEventListener('click', function () {
        var elements = document.querySelectorAll('.hide');
        for (var i = 0; i < elements.length; i++) {
            if (elements[i].style.display == 'none') {
                elements[i].style.display = 'block';
            } else {
                elements[i].style.display = 'none';
            }
        }
    });


</script>
<%--Handle User--%>
<script>
    <%--    // Handle button view Of resume--%>
    <%--    document.addEventListener("DOMContentLoaded", function () {--%>
    <%--        cutShortLink();--%>
    <%--        // Show modal view files resume--%>
    <%--        var viewResumeButton = document.getElementById('viewFileResume');--%>
    <%--        viewResumeButton.addEventListener('click', function () {--%>
    <%--            $('#filesResume').modal('show');--%>
    <%--            var viewFilesResumeButton = document.querySelectorAll('.delete-fileResume-button');--%>
    <%--            viewFilesResumeButton.forEach(function (button) {--%>
    <%--                button.addEventListener('click', function () {--%>
    <%--                    this.closest('.delete-fileResume').remove();--%>
    <%--                });--%>
    <%--            });--%>
    <%--        });--%>
    <%--    });--%>

    <%--    // document.getElementById('resume').addEventListener('change', function() {--%>
    <%--    //     document.getElementById('selectedFiles').style.display = 'block';--%>
    <%--    //     var selectedFiles = document.getElementById('resume').files;--%>
    <%--    //     var filesList = document.getElementById('listFiles');--%>
    <%--    //     for (var i = 0; i < selectedFiles.length; i++) {--%>
    <%--    //         var fileName = selectedFiles[i].name;--%>
    <%--    //         var listItem = document.createElement('div');--%>
    <%--    //         listItem.classList.add('col-md-3', 'm-3');--%>
    <%--    //         listItem.textContent = fileName;--%>
    <%--    //         filesList.appendChild(listItem);--%>
    <%--    //         cutShortLink();--%>
    <%--    //     }--%>
    <%--    // });--%>

    <%--    // Format filename--%>
    <%--    function formatName(ClassName) {--%>
    <%--        for (var i = 0; i < ClassName.length; i++) {--%>
    <%--            var link = ClassName[i];--%>
    <%--            var href = link.getAttribute("href");--%>
    <%--            var fileName = href.substring(href.indexOf("-") + 1);--%>
    <%--            if (fileName.length > 15) {--%>
    <%--                var extension = fileName.substring(fileName.lastIndexOf("."));--%>
    <%--                fileName = fileName.substring(0, 12) + "..." + extension;--%>
    <%--            }--%>

    <%--            link.textContent = fileName;--%>
    <%--        }--%>
    <%--    };--%>




    // Show image of user choose
    document.getElementById("avatar").addEventListener("change", function (e) {
        document.getElementById("delete-avatar-button").style.display = "block";
        document.getElementById("delete-avatar-button").addEventListener("click", function () {
            document.getElementById("avatar-user").src = userCurrent.avatar;
            document.getElementById("delete-avatar-button").style.display = "none";
            document.getElementById("avatar").value = "";

        });
    });


    <%--    var isNewPassword = false;--%>
    <%--    var linkCancle = '/users';--%>
    <%--    if (userCurrent.role == U_DEVELOPER) linkCancle = '/home';--%>
    <%--    $('.cancle-button').attr('href', linkCancle);--%>

    <%--    // Handle user click on "Change Password"--%>
    <%--    document.getElementById("change-password-button").addEventListener("click", function () {--%>
    <%--        var inputPassword = document.getElementById("password-form");--%>
    <%--        if (inputPassword.style.display == "none") {--%>
    <%--            inputPassword.style.display = "block";--%>
    <%--            isNewPassword = true;--%>
    <%--        } else {--%>
    <%--            inputPassword.style.display = "none";--%>
    <%--            isNewPassword = false;--%>
    <%--        }--%>
    <%--    });--%>

    <%--    Validator({--%>
    <%--        form: '#formUpdateUser',--%>
    <%--        errorSelector: '.form-message',--%>
    <%--        rules: [--%>
    <%--            Validator.isRequired('#address'),--%>
    <%--            Validator.isRequired('#fullname'),--%>
    <%--            Validator.isRequired('#dateOfBirth'),--%>
    <%--            Validator.isDayBeforeToday('#dateOfBirth'),--%>
    <%--            Validator.isRequired('#phone'),--%>
    <%--            Validator.isPhoneVN('#phone'),--%>
    <%--            Validator.isRequired('#emergencyPhone')--%>
    <%--        ],--%>
    <%--        onSubmit: function (formData) {--%>

    <%--            $('.container-button').after(createLoadingHtml());--%>


    <%--            formData.append('id', '${user.id}');--%>

    <%--            // ADD dateOfBirth after format--%>
    <%--            var dobString = document.getElementById('dateOfBirth').value;--%>
    <%--            var jsDate = new Date(dobString);--%>
    <%--            var dateOfBirth = new Date(jsDate.getTime());--%>
    <%--            formData.append('dateOfBirth', dateOfBirth);--%>

    <%--            // ADD all file resume--%>
    <%--            var filesResume = document.querySelectorAll('.fileName-Resume');--%>
    <%--            var filenamesResume = [];--%>
    <%--            filesResume.forEach(function (element) {--%>
    <%--                var href = element.getAttribute('href');--%>
    <%--                var parts = href.split('/');--%>
    <%--                var fileName = parts[parts.length - 1];--%>
    <%--                filenamesResume.push(fileName);--%>
    <%--            });--%>

    <%--            var result = filenamesResume.join(",");--%>
    <%--            formData.append('remainResumeFiles', result);--%>

    <%--            if (isNewPassword) {--%>
    <%--                var newPassword = document.getElementById('password').value;--%>
    <%--                var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{6,}$/;--%>
    <%--                var message = regex.test(newPassword) ? undefined : 'Password must have at least 6 characters and include letters, numbers and special characters';--%>
    <%--                if (newPassword != '') {--%>
    <%--                    if (message == undefined) {--%>
    <%--                        callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {--%>
    <%--                            sessionStorage.setItem('result', 'updateSuccess');--%>
    <%--                            location.href = "/users/" + '${user.getId()}';--%>
    <%--                        }, 'formUpdateUser');--%>
    <%--                    } else {--%>
    <%--                        document.getElementById('messageNewPassword').textContent = message;--%>
    <%--                        resetForm('formUpdateUser');--%>
    <%--                    }--%>
    <%--                } else {--%>
    <%--                    document.getElementById('messageNewPassword').textContent = message;--%>
    <%--                    resetForm('formUpdateUser');--%>
    <%--                }--%>
    <%--            } else {--%>
    <%--                formData.delete('password');--%>
    <%--                callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {--%>
    <%--                    sessionStorage.setItem('result', 'updateSuccess');--%>
    <%--                    location.href = "/users/" + '${user.getId()}';--%>
    <%--                }, 'formUpdateUser');--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>

    <%--    // Handle when user click button "Confirm Delete User"--%>
    <%--    document.addEventListener("DOMContentLoaded", function () {--%>

    <%--        var deleteUserButtons = document.getElementById('deleteUser');--%>
    <%--        var userId = deleteUserButtons.value;--%>

    <%--        // Show File Name Contract--%>
    <%--        var contractLinks = document.getElementsByClassName("contractLink");--%>
    <%--        formatName(contractLinks);--%>

    <%--        // Handler button Delete in modal Delete--%>
    <%--        deleteUserButtons.addEventListener("click", function () {--%>
    <%--            if (userId) {--%>
    <%--                $('.container-button-delete-user').after(createLoadingHtml());--%>

    <%--                callAjaxByJsonWithData('/api/v1/users/' + userId, 'DELETE', null, function (rs) {--%>
    <%--                    sessionStorage.setItem('result', 'deleteSuccess');--%>
    <%--                    window.location.href = "/users";--%>
    <%--                });--%>
    <%--            }--%>
    <%--        });--%>
    <%--    });--%>

    <%--    // Notification Success--%>
    <%--    document.addEventListener('DOMContentLoaded', function () {--%>
    <%--        const result = sessionStorage.getItem('result');--%>
    <%--        if (result) {--%>
    <%--            let message;--%>
    <%--            switch (result) {--%>
    <%--                case 'updateSuccess':--%>
    <%--                    message = 'Update User Success';--%>
    <%--                    break;--%>
    <%--                case 'addContractSuccess':--%>
    <%--                    message = 'Add Contract Success';--%>
    <%--                    break;--%>
    <%--                case 'editContractSuccess':--%>
    <%--                    message = 'Edit Contract Success';--%>
    <%--                    break;--%>
    <%--                case 'deleteContractSuccess':--%>
    <%--                    message = 'Delete Contract Success';--%>
    <%--                    break;--%>
    <%--                default:--%>
    <%--                    message = 'Unknown Result';--%>
    <%--            }--%>
    <%--            $('#resultMessage').text(message);--%>
    <%--            $('#resultModal').modal('show');--%>
    <%--            sessionStorage.clear();--%>
    <%--        }--%>
    <%--    });--%>
</script>

<%--&lt;%&ndash;Handle WorkingDay&ndash;%&gt;--%>
<%--<script>--%>
<%--    document.addEventListener("DOMContentLoaded", function () {--%>
<%--        if (!isDeleveloper()) {--%>
<%--            // Lấy tham chiếu đến các phần tử HTML--%>
<%--            var yearSelect = document.getElementById('working-year');--%>
<%--            var monthSelect = document.getElementById('working-month');--%>
<%--            var totalWorkingDayInput = document.getElementById('totalWorkingDay');--%>

<%--            var data;--%>
<%--            callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.getId()}', 'GET', null, function (rs) {--%>
<%--                data = rs;--%>
<%--                yearSelect.innerHTML = '<option value="">-- Select Year --</option>';--%>
<%--                data.forEach(function (entry) {--%>
<%--                    var option = document.createElement('option');--%>
<%--                    option.value = entry.year;--%>
<%--                    option.textContent = entry.year;--%>
<%--                    yearSelect.appendChild(option);--%>
<%--                });--%>
<%--            });--%>

<%--            // Thêm sự kiện nghe cho việc thay đổi lựa chọn năm--%>
<%--            yearSelect.addEventListener('change', function () {--%>
<%--                $('#working-day').after(createLoadingHtml());--%>
<%--                callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.getId()}' + "?year=" + yearSelect.value, 'GET', null, function (rs) {--%>
<%--                    var dataMonth = rs;--%>
<%--                    // Xóa các option cũ trong dropdown year--%>
<%--                    monthSelect.innerHTML = '<option value="">-- Select Month --</option>';--%>

<%--                    // Thêm các option mới từ dữ liệu API--%>
<%--                    dataMonth.forEach(function (entry) {--%>
<%--                        var option = document.createElement('option');--%>
<%--                        option.value = entry.month;--%>
<%--                        option.textContent = entry.month;--%>
<%--                        monthSelect.appendChild(option);--%>
<%--                    });--%>
<%--                    monthSelect.addEventListener('change', function () {--%>
<%--                        var selectedMonth = monthSelect.value;--%>
<%--                        var selectedData = dataMonth.find(function (entry) {--%>
<%--                            return entry.month === parseInt(selectedMonth);--%>
<%--                        });--%>
<%--                        totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";--%>
<%--                    });--%>
<%--                    $('div.custom-spinner').parent().remove();--%>
<%--                });--%>

<%--                if (yearSelect.value != "") {--%>
<%--                    var selectedYear = yearSelect.value;--%>
<%--                    var selectedData = data.find(function (entry) {--%>
<%--                        return entry.year === parseInt(selectedYear);--%>
<%--                    });--%>
<%--                    totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";--%>
<%--                    monthSelect.style.display = 'block';--%>
<%--                } else {--%>
<%--                    totalWorkingDayInput.value = null;--%>
<%--                    monthSelect.style.display = 'none';--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>

<%--&lt;%&ndash;Handle Contract&ndash;%&gt;--%>
<%--<script>--%>
<%--    // Function formatAllowance--%>
<%--    function allowanceFormat(data) {--%>
<%--        var data = JSON.parse(data);--%>
<%--        var keyValueString = '';--%>
<%--        for (var key in data) {--%>
<%--            if (data.hasOwnProperty(key)) {--%>
<%--                keyValueString += '<strong>' + key + '</strong>' + ' : ' + data[key] + 'đ' + '<br><br>';--%>
<%--            }--%>
<%--        }--%>
<%--        keyValueString = keyValueString.slice(0, -2);--%>

<%--        return keyValueString;--%>
<%--    }--%>

<%--    // Handle when user click button "Edit Allowance"--%>
<%--    document.getElementById("showEditFields").addEventListener("click", function () {--%>
<%--        var editFields = document.getElementById("editFields");--%>
<%--        if (editFields.style.display === "none" || editFields.style.display === "") {--%>
<%--            editFields.style.display = "block";--%>
<%--        } else {--%>
<%--            editFields.style.display = "none";--%>
<%--        }--%>
<%--    });--%>

<%--    // Handle when user click button "Add Contract"--%>
<%--    document.addEventListener("DOMContentLoaded", function () {--%>
<%--        var addButtons = document.querySelectorAll(".add-contract-button");--%>

<%--        // Show modal Edit Contract--%>
<%--        addButtons.forEach(function (button) {--%>
<%--            button.addEventListener("click", function () {--%>
<%--                $("#addContractModal").modal("show");--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--    Validator({--%>
<%--        form: '#formAddContract',--%>
<%--        errorSelector: '.form-message',--%>
<%--        rules: [--%>
<%--            Validator.isRequired('#addBasicSalary'),--%>
<%--            Validator.isRequired('#addInsuranceMoney'),--%>
<%--            Validator.isRequired('#telephone'),--%>
<%--            Validator.isRequired('#meal'),--%>
<%--            Validator.isRequired('#gasoline'),--%>
<%--            Validator.isRequired('#uniform'),--%>
<%--            Validator.isRequired('#attendance'),--%>
<%--            Validator.isRequired('#other')--%>
<%--        ],--%>
<%--        onSubmit: function (formData) {--%>

<%--            $('.container-button-add-contract').after(createLoadingHtml());--%>

<%--            var telPhone = document.getElementById('telephone').value;--%>
<%--            var meal = document.getElementById('meal').value;--%>
<%--            var gasoline = document.getElementById('gasoline').value;--%>
<%--            var uniform = document.getElementById('uniform').value;--%>
<%--            var attendance = document.getElementById('attendance').value;--%>
<%--            var other = document.getElementById('other').value;--%>

<%--            formData.append('userId', '${user.id}');--%>
<%--            formData.append('allowance', JSON.stringify({--%>
<%--                "Telephone": telPhone,--%>
<%--                "Meal": meal,--%>
<%--                "Gasoline": gasoline,--%>
<%--                "Uniform": uniform,--%>
<%--                "Attendance": attendance,--%>
<%--                "Other": other--%>
<%--            }));--%>
<%--            callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {--%>
<%--                sessionStorage.setItem('result', 'addContractSuccess');--%>
<%--                localStorage.setItem("showModal", "true");--%>
<%--                location.reload();--%>
<%--            }, 'formAddContract');--%>
<%--        }--%>
<%--    });--%>

<%--    // Handle when user click 'History Update' button--%>
<%--    document.addEventListener("DOMContentLoaded", function () {--%>
<%--        var tdElements = document.getElementsByClassName('format-allowance');--%>
<%--        for (var i = 0; i < tdElements.length; i++) {--%>
<%--            var tdElement = tdElements[i];--%>
<%--            var jsonText = tdElement.textContent;--%>

<%--            tdElement.innerHTML = allowanceFormat(jsonText);--%>
<%--        }--%>
<%--        var historyButtons = document.querySelectorAll('.history-contract-button');--%>
<%--        var contractIdHistory;--%>

<%--        historyButtons.forEach(function (button) {--%>
<%--            button.addEventListener('click', function () {--%>
<%--                contractIdHistory = button.value;--%>
<%--                $('#contractHistoryModal').modal('show');--%>

<%--                if ($.fn.DataTable.isDataTable('#table-history-contract')) {--%>
<%--                    $('#table-history-contract').DataTable().destroy();--%>
<%--                }--%>

<%--                if (contractIdHistory) {--%>
<%--                    table = $('#table-history-contract').DataTable({--%>
<%--                        ajax: {--%>
<%--                            url: '/api/v1/contracts/' + contractIdHistory,--%>
<%--                            contentType: 'application/json',--%>
<%--                            method: 'GET',--%>
<%--                            dataSrc: 'historyContract'--%>
<%--                        },--%>
<%--                        columns: [--%>
<%--                            {data: 'basicSalary'},--%>
<%--                            {--%>
<%--                                data: 'allowance',--%>
<%--                                render: function (data, type, row) {--%>
<%--                                    return allowanceFormat(data);--%>
<%--                                }--%>
<%--                            },--%>
<%--                            {data: 'insuranceType.name'},--%>
<%--                            {data: 'insuranceMoney'},--%>
<%--                            {--%>
<%--                                data: 'contract',--%>
<%--                                render: function (data, type, row) {--%>
<%--                                    if (data != null) {--%>
<%--                                        return '<a class="cut-file-name" href="' + data + '">' + data + '</a>';--%>
<%--                                    }--%>
<%--                                    return '';--%>
<%--                                }--%>
<%--                            },--%>
<%--                            {data: 'createdDate'}--%>
<%--                        ],--%>
<%--                        ordering: false,--%>
<%--                        searching: false,--%>
<%--                        lengthChange: false,--%>
<%--                        paging: false,--%>
<%--                        info: false,--%>
<%--                        initComplete: function () {--%>
<%--                            cutShortLink();--%>
<%--                        }--%>
<%--                    });--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--    // Handle when user click button "Edit Contract"--%>
<%--    document.addEventListener("DOMContentLoaded", function () {--%>
<%--        var editButtons = document.querySelectorAll(".edit-contract-button");--%>
<%--        var contractIdEdit;--%>

<%--        // Show modal Edit Contract--%>
<%--        editButtons.forEach(function (button) {--%>
<%--            button.addEventListener("click", function () {--%>
<%--                contractIdEdit = button.value;--%>
<%--                $("#editContractModal").modal("show");--%>

<%--                if (contractIdEdit) {--%>

<%--                    callAjaxByJsonWithData('/api/v1/contracts/' + contractIdEdit, 'GET', null, function (rs) {--%>
<%--                        var responseData = rs--%>

<%--                        // Đổ dữ liệu từ API vào các trường của modal--%>
<%--                        document.getElementById("editBasicSalary").value = responseData.basicSalary;--%>
<%--                        // document.getElementById("editAllowance").value = responseData.allowance;--%>
<%--                        var allowance = JSON.parse(responseData.allowance);--%>
<%--                        document.getElementById('editTelephone').value = allowance.Telephone;--%>
<%--                        document.getElementById('editMeal').value = allowance.Meal;--%>
<%--                        document.getElementById('editGasoline').value = allowance.Gasoline;--%>
<%--                        document.getElementById('editUniform').value = allowance.Uniform;--%>
<%--                        document.getElementById('editAttendance').value = allowance.Attendance;--%>
<%--                        document.getElementById('editOther').value = allowance.Other;--%>

<%--                        var selectElement = document.getElementById("editInsuranceType");--%>
<%--                        var editInsuranceType = responseData.insuranceType.name;--%>
<%--                        for (var i = 0; i < selectElement.options.length; i++) {--%>
<%--                            if (selectElement.options[i].text === editInsuranceType) {--%>
<%--                                // Option đã tồn tại, di chuyển option đó lên đầu--%>
<%--                                selectElement.insertBefore(selectElement.options[i], selectElement.options[0]);--%>
<%--                                break;--%>
<%--                            }--%>
<%--                        }--%>
<%--                        selectElement.selectedIndex = 0;--%>

<%--                        document.getElementById("editInsuranceMoney").value = responseData.insuranceMoney;--%>
<%--                    });--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--    // Handle when user click button "Confirm Edit Contract"--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        var confirmButton = document.getElementById("confirmContractButton");--%>
<%--        var contractId = document.querySelectorAll(".edit-contract-button");--%>
<%--        var contractIdValue;--%>

<%--        contractId.forEach(function (button) {--%>
<%--            button.addEventListener("click", function () {--%>
<%--                contractIdValue = button.value;--%>
<%--            });--%>
<%--        });--%>

<%--        Validator({--%>
<%--            form: '#editContractForm',--%>
<%--            errorSelector: '.form-message',--%>
<%--            rules: [--%>
<%--                Validator.isRequired('#editBasicSalary'),--%>
<%--                Validator.isRequired('#editInsuranceMoney')--%>
<%--            ],--%>
<%--            onSubmit: function (formData) {--%>

<%--                $('.container-button-edit-contract').after(createLoadingHtml());--%>

<%--                var telPhone = document.getElementById('editTelephone').value;--%>
<%--                var meal = document.getElementById('editMeal').value;--%>
<%--                var gasoline = document.getElementById('editGasoline').value;--%>
<%--                var uniform = document.getElementById('editUniform').value;--%>
<%--                var attendance = document.getElementById('editAttendance').value;--%>
<%--                var other = document.getElementById('editOther').value;--%>

<%--                formData.append('allowance', JSON.stringify({--%>
<%--                    "Telephone": telPhone,--%>
<%--                    "Meal": meal,--%>
<%--                    "Gasoline": gasoline,--%>
<%--                    "Uniform": uniform,--%>
<%--                    "Attendance": attendance,--%>
<%--                    "Other": other--%>
<%--                }));--%>


<%--                formData.append('userId', '${user.id}');--%>
<%--                formData.append('parentId', contractIdValue);--%>
<%--                callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {--%>

<%--                }, 'formAddContract');--%>

<%--                formData.delete('parentId');--%>
<%--                formData.delete('userId');--%>
<%--                formData.append('id', contractIdValue);--%>
<%--                callAjaxByDataFormWithDataForm('/api/v1/contracts/updation', 'POST', formData, function (rs) {--%>
<%--                    sessionStorage.setItem('result', 'editContractSuccess');--%>
<%--                    localStorage.setItem("showModal", "true");--%>
<%--                    location.reload();--%>
<%--                }, 'editContractForm');--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>

<%--    // Handle when user click button "Confirm Delete Contract"--%>
<%--    document.addEventListener("DOMContentLoaded", function () {--%>
<%--        var deleteButtons = document.querySelectorAll(".delete-contract-button");--%>
<%--        var confirmButton = document.querySelector(".confirm-delete-button");--%>
<%--        var contractIdToDelete;--%>

<%--        // Xử lý khi nút Delete được nhấn--%>
<%--        deleteButtons.forEach(function (button) {--%>
<%--            button.addEventListener("click", function () {--%>
<%--                contractIdToDelete = button.value;--%>

<%--                // Đặt trạng thái hiển thị modal trong Local Storage thành true--%>
<%--                localStorage.setItem("showModal", "true");--%>
<%--                $("#deleteContractModal").modal("show");--%>
<%--            });--%>
<%--        });--%>

<%--        // Xử lý khi nút Confirm được nhấn trong modal--%>
<%--        confirmButton.addEventListener("click", function () {--%>
<%--            if (contractIdToDelete) {--%>
<%--                $('.container-button-delete-contract').after(createLoadingHtml());--%>
<%--                callAjaxByJsonWithData('/api/v1/contracts/' + contractIdToDelete, 'DELETE', null, function (rs) {--%>
<%--                    sessionStorage.setItem('result', 'deleteContractSuccess');--%>
<%--                    localStorage.setItem("showModal", "true");--%>
<%--                    location.reload();--%>
<%--                });--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--    window.onload = function () {--%>
<%--        // Show Modal when page reload--%>
<%--        if (localStorage.getItem("showModal") === "true") {--%>
<%--            $("#contractModal").modal("show");--%>
<%--            // Đặt trạng thái hiển thị modal trong Local Storage thành false để tránh hiển thị lần tiếp theo--%>
<%--            localStorage.setItem("showModal", "false");--%>
<%--        }--%>
<%--    };--%>

<%--</script>--%>

<%--&lt;%&ndash;Handle Role&ndash;%&gt;--%>
<%--<script>--%>
<%--    document.addEventListener("DOMContentLoaded", function () {--%>

<%--        if (isDeleveloper()) {--%>
<%--            $('.hide').remove();--%>
<%--            $('#delUser').remove();--%>
<%--        } else {--%>
<%--            $('.hide').css('display', 'block');--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>