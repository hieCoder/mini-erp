<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        .form-group-password {
            position: relative;
        }

        #change-password-button {
            position: absolute;
            right: 0;
            top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <form id="formUpdateUser">
            <div class="row">
                <!-- Phần 1: Hình ảnh avatar và tên người dùng -->
                <div class="col-md-4">
                    <div class="text-center">
                        <img src="${user.getAvatar()}" class="img-fluid" alt="User Avatar" width="200">
                        <input name="avatar" type="file" class="form-control mt-2" id="avatar">
                        <small class="text-muted ml-2">Choose New Avatar</small>
                        <h4 class="mt-2">${user.getFullname()}</h4>
                    </div>
                </div>
                <div class="col-md-8">
                    <!-- Phần 2: Form thông tin người dùng -->
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" name="address" class="form-control" id="address" value="${user.getAddress()}">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="fullname">Username:</label>
                        <input type="text" class="form-control" name="fullname" id="fullname" value="${user.getFullname()}">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="dateOfBirth">Date of birth:</label>
                        <input type="date" class="form-control" id="dateOfBirth" value="${user.dateOfBirth}">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone number:</label>
                        <input type="tel" class="form-control" name="phone" id="phone" value="${user.getPhone()}">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="emergencyPhone">Emergency phone:</label>
                        <input type="tel" class="form-control" name="emergencyPhone" id="emergencyPhone" value="${user.getEmergencyPhone()}">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="resume">Resume file:</label>
                        <c:choose>
                            <c:when test="${empty user.getResume()}">
                                <div id="resumeContainer" style="display: none;">
                                    <a href="#" style="display: none;">Download Resume</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div id="resumeContainer">
                                    <a href="${user.getResume()}" download target="_blank">Download Resume</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <input type="file" class="form-control mt-2" name="resume" id="resume">
                        <small class="text-muted ml-2">Choose new resume</small>
                    </div>
                    <div class="form-group">
                        <label for="timeSheetsCode">TimeSheets code:</label>
                        <input type="text" class="form-control" name="timesheetsCode" id="timeSheetsCode" value="${user.getTimesheetsCode()}">
                    </div>
                    <div class="form-group hide">
                        <label for="type">Type:</label>
                        <select name="type" class="form-control" id="type">
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
                    </div>
                    <div class="form-group hide">
                        <label for="department">Department:</label>
                        <select name="department" class="form-control" id="department">
                            <option value="ADMINISTRATION"
                                    <c:if test="${user.department.code.equals('ADMINISTRATION')}">selected</c:if>>
                                Administration
                            </option>
                            <option value="MANAGEMENT"
                                    <c:if test="${user.department.code.equals('MANAGEMENT')}">selected</c:if>>
                                Management
                            </option>
                            <option value="UI_UX" <c:if test="${user.department.code.equals('UI_UX')}">selected</c:if>>
                                UI/UX
                            </option>
                            <option value="DEV1" <c:if test="${user.department.code.equals('DEV1')}">selected</c:if>>
                                Dev1
                            </option>
                            <option value="DEV2" <c:if test="${user.department.code.equals('DEV2')}">selected</c:if>>
                                Dev2
                            </option>
                        </select>
                    </div>
                    <div class="form-group hide">
                        <label for="userId">User ID:</label>
                        <input name="email" type="email" class="form-control" id="userId" value="${user.getEmail()}">
                    </div>
                    <div class="form-group-password hide">
                        <label for="password">Password: </label>
                        <a id="change-password-button" class="text-primary text-decoration-none" style="cursor: pointer;">Change
                            password</a>
                        <div id="password-form" style="display: none;">
                            <input name="password" type="password" class="form-control" id="password" value="" placeholder="New Password">
                            <span id="messageNewPassword"  class="text-danger"></span>
                        </div>
                    </div>
                    <div class="form-group hide">
                        <label for="atm">ATM:</label>
                        <input name="atm" type="text" class="form-control" id="atm" value="${user.getAtm()}">
                    </div>
                    <div class="form-group hide">
                        <label for="role">Role:</label>
                        <select name="role" class="form-control" id="role">
                            <option value="OWNER" <c:if test="${user.role.code.equals('OWNER')}">selected</c:if>>
                                Owner
                            </option>
                            <option value="MANAGER" <c:if test="${user.role.code.equals('MANAGER')}">selected</c:if>>
                                Manager
                            </option>
                            <option value="DEVELOPER" <c:if test="${user.role.code.equals('DEVELOPER')}">selected</c:if>>
                                Developer
                            </option>
                        </select>
                    </div>
                    <div class="form-group hide">
                        <label for="position">Position:</label>
                        <select name="position" class="form-control" id="position">
                            <option value="INTERN" <c:if test="${user.position.code.equals('INTERN')}">selected</c:if>>
                                Intern
                            </option>
                            <option value="JUNIOR" <c:if test="${user.position.code.equals('JUNIOR')}">selected</c:if>>
                                Junior
                            </option>
                            <option value="SENIOR" <c:if test="${user.position.code.equals('SENIOR')}">selected</c:if>>
                                Senior
                            </option>
                            <option value="MANAGER" <c:if test="${user.position.code.equals('MANAGER')}">selected</c:if>>
                                Manager
                            </option>
                            <option value="SENIOR_MANAGER"
                                    <c:if test="${user.position.code.equals('SENIOR_MANAGER')}">selected</c:if>>
                                Senior manager
                            </option>
                            <option value="OWNER" <c:if test="${user.position.code.equals('OWNER')}">selected</c:if>>
                                Owner
                            </option>
                        </select>
                    </div>
                    <div class="form-group hide">
                        <label for="contract">Contract:</label>
                        <button id="contract" type="button" class="btn btn-warning font-weight-bold" data-toggle="modal"
                                data-target="#contractModal">
                            View
                        </button>
                    </div>
                    <div class="form-group hide">
                        <label for="working-day">Working day:</label>
                        <div class="input-group" id="working-day">
                            <select class="form-control" id="working-year">
                                <option value="">-- Select year --</option>
                            </select>
                            <select class="form-control" id="working-month" style="display: none;">
                                <option>-- Select month --</option>
                            </select>
                            <input type="text" class="form-control" id="totalWorkingDay" readonly placeholder="Result">
                        </div>
                    </div>
                    <div class="form-group container-button">
                        <button value="${user.getId()}" type="submit" class="btn btn-primary" id="updateUserButton">Save</button>
                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteUserModal" id="delUser">Delete</button>
                        <a class="btn btn-secondary cancle-button">Cancel</a>
                    </div>
                </div>
            </div>
        </form>
    </div>

<!-- Modal List Contract  -->
<div class="modal fade" id="contractModal" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Contract history</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Basic Salary</th>
                        <th>Allowance</th>
                        <th>Insurance Type</th>
                        <th>Insurance Money</th>
                        <th>Contract</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="contract" items="${user.contracts}">
                        <tr>
                            <td>${contract.getBasicSalary()}$</td>
                            <td>${contract.getAllowance()}$</td>
                            <td>${contract.getInsuranceType().getName()}</td>
                            <td>${contract.getInsuranceMoney()}$</td>
                            <td><a href="${contract.getContract()}" download target="_blank" class="contractLink">Contract
                                Files</a></td>
                            <td>
                                <button value="${contract.getId()}" type="button"
                                        class="btn btn-primary edit-contract-button">Edit
                                </button>
                                <button value="${contract.getId()}" type="button"
                                        class="btn btn-danger delete-contract-button mt-2">Delete
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-body text-center">
                <button type="button" class="btn btn-primary px-4 add-contract-button">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal ADD Contract  -->
<div class="modal fade" id="addContractModal" tabindex="-1" role="dialog" aria-labelledby="addContractModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-center">Add Contract</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formAddContract">
                    <div class="form-group">
                        <label for="editBasicSalary">Basic Salary:</label>
                        <input type="number" class="form-control" id="addBasicSalary" name="basicSalary">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="editAllowance">Allowance:</label>
                        <input type="number" class="form-control" id="addAllowance" name="allowance">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceType">Insurance Type:</label>
                        <select class="form-control" id="addInsuranceType" name="insuranceType">
                            <option value="HEALTH_INSURANCE">Health insurance</option>
                            <option value="SOCIAL_INSURANCE">Social insurance</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceMoney">Insurance Money:</label>
                        <input type="number" class="form-control" id="addInsuranceMoney" name="insuranceMoney">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="newContract">Contract</label>
                        <input type="file" class="form-control mt-2" id="newContract" name="contract">
                    </div>
                    <div class="form-group container-button-add-contract">
                        <button value="${user.getId()}" type="submit" class="btn btn-primary" id="addContractButton">Confirm
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Contract Edit -->
<div class="modal fade" id="editContractModal" tabindex="-1" role="dialog" aria-labelledby="editContractModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-center">Edit Contract</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editContractForm">
                    <div class="form-group">
                        <label for="editBasicSalary">Basic Salary:</label>
                        <input type="number" class="form-control" id="editBasicSalary" name="basicSalary">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="editAllowance">Allowance:</label>
                        <input type="number" class="form-control" id="editAllowance" name="allowance">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceType">Insurance Type:</label>
                        <select class="form-control" id="editInsuranceType" name="insuranceType">
                            <option value="HEALTH_INSURANCE">Health insurance</option>
                            <option value="SOCIAL_INSURANCE">Social insurance</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceMoney">Insurance Money:</label>
                        <input type="number" class="form-control" id="editInsuranceMoney" name="insuranceMoney">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="contractUser">Contract Files: </label>
                        <a href="" download target="_blank" id="contractFile">Download Contract</a>
                        <input type="file" class="form-control mt-2" id="contractUser" name="contract">
                        <small class="text-muted ml-2">Choose New Contract</small>
                    </div>
                    <div class="form-group container-button-edit-contract">
                        <button type="submit" class="btn btn-primary" id="confirmContractButton">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Delete Contract-->
<div class="modal fade" id="deleteContractModal" tabindex="-1" role="dialog" aria-labelledby="deleteContractModalLabel"
     aria-hidden="true" style="z-index: 999999; margin-top: 235px">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this contract?
            </div>
            <div class="modal-footer container-button-delete-contract">
                <button type="button" class="btn btn-info confirm-delete-button">Confirm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Delete User -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" role="dialog" aria-labelledby="deleteUserModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this user?
            </div>
            <div class="modal-footer container-button-delete-user">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button value="${user.getId()}" type="button" class="btn btn-danger" id="deleteUser">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Notification Success -->
<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="resultModalLabel">Result</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="resultMessage">
                <!-- Message Success -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>

<%--Handle User--%>
<script>
    var isNewPassword = false;
    var linkCancle = '/users';
    if(userCurrent.role == U_DEVELOPER) linkCancle = '/home';
    $('.cancle-button').attr('href', linkCancle);

    // Lắng nghe sự kiện khi người dùng nhấn nút "Change Password"
    document.getElementById("change-password-button").addEventListener("click", function () {
        var inputPassword = document.getElementById("password-form");
        if (inputPassword.style.display == "none") {
            inputPassword.style.display = "block";
            isNewPassword = true;
        }
        else {
            inputPassword.style.display = "none";
            isNewPassword = false;
        }


    });

    Validator({
        form:'#formUpdateUser',
        errorSelector: '.form-message',
        rules:[
            Validator.isRequired('#address'),
            Validator.isRequired('#fullname'),
            Validator.isRequired('#dateOfBirth'),
            Validator.isRequired('#phone'),
            Validator.isRequired('#emergencyPhone')
        ],
        onSubmit: function (formData) {

            $('.container-button').after(createLoadingHtml());


            formData.append('id', '${user.id}');

            var dobString = document.getElementById('dateOfBirth').value;
            var jsDate = new Date(dobString);
            var dateOfBirth = new Date(jsDate.getTime()); // Chuyển đổi thành đối tượng Java Date
            formData.append('dateOfBirth', dateOfBirth);

            var newPassword = document.getElementById('password').value;


            if (isNewPassword) {
                var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{6,}$/;
                var message = regex.test(newPassword)?undefined:'Password must have at least 6 characters and include letters, numbers and special characters';
                if (newPassword != '') {
                    if (message == undefined) {
                        callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {
                            sessionStorage.setItem('result', 'updateSuccess');
                            location.href = "/users/" + '${user.getId()}';
                        }, 'formUpdateUser');
                    } else {
                        document.getElementById('messageNewPassword').textContent = message;
                        resetForm('formUpdateUser');
                    }
                } else {
                    document.getElementById('messageNewPassword').textContent = message;
                    resetForm('formUpdateUser');
                }
            } else {
                callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {
                    sessionStorage.setItem('result', 'updateSuccess');
                    location.href = "/users/" + '${user.getId()}';
                }, 'formUpdateUser');
            }

        }
    });

    // Lắng nghe sự kiện khi người dùng nhấn nút "Confirm Delete User"
    document.addEventListener("DOMContentLoaded", function () {

        var deleteUserButtons = document.getElementById('deleteUser');
        var userId = deleteUserButtons.value;

        // Show File Name Contract
        var contractLinks = document.getElementsByClassName("contractLink");
        for (var i = 0; i < contractLinks.length; i++) {
            var contractLink = contractLinks[i];
            var contractHref = contractLink.getAttribute("href");
            var contractfileName = contractHref.substring(contractHref.indexOf("-") + 1);

            // Đặt nội dung mặc định cho thẻ <a> bằng cách sử dụng textContent.
            contractLink.textContent = contractfileName;
        }


        // Xử lý khi nút Delete được nhấn trong modal
        deleteUserButtons.addEventListener("click", function () {
            if (userId) {

                $('.container-button-delete-user').after(createLoadingHtml());

                callAjaxByJsonWithData('/api/v1/users/' + userId, 'DELETE', null, function (rs) {
                    sessionStorage.setItem('result', 'deleteSuccess');
                    window.location.href = "/users";
                });
            }
        });
    });

    // Notification Success
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            let message;
            switch (result) {
                case 'updateSuccess':
                    message = 'Update User Success';
                    break;
                case 'addContractSuccess':
                    message = 'Add Contract Success';
                    break;
                case 'editContractSuccess':
                    message = 'Edit Contract Success';
                    break;
                case 'deleteContractSuccess':
                    message = 'Delete Contract Success';
                    break;
                default:
                    message = 'Unknown Result';
            }
            $('#resultMessage').text(message);
            $('#resultModal').modal('show');
            sessionStorage.clear();
        }
    });
</script>

<%--Handle WorkingDay--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy tham chiếu đến các phần tử HTML
        var yearSelect = document.getElementById('working-year');
        var monthSelect = document.getElementById('working-month');
        var totalWorkingDayInput = document.getElementById('totalWorkingDay');

        var data;
        callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.getId()}', 'GET', null, function (rs) {
            data = rs;
            yearSelect.innerHTML = '<option value="">-- Select Year --</option>';
            data.forEach(function (entry) {
                var option = document.createElement('option');
                option.value = entry.year;
                option.textContent = entry.year;
                yearSelect.appendChild(option);
            });
        });

        // Thêm sự kiện nghe cho việc thay đổi lựa chọn năm
        yearSelect.addEventListener('change', function () {
            $('#working-day').after(createLoadingHtml());
            callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.getId()}' +"?year=" + yearSelect.value, 'GET', null, function (rs) {
                var dataMonth = rs;
                // Xóa các option cũ trong dropdown year
                monthSelect.innerHTML = '<option value="">-- Select Month --</option>';

                // Thêm các option mới từ dữ liệu API
                dataMonth.forEach(function (entry) {
                    var option = document.createElement('option');
                    option.value = entry.month;
                    option.textContent = entry.month;
                    monthSelect.appendChild(option);
                });
                monthSelect.addEventListener('change', function () {
                    var selectedMonth = monthSelect.value;
                    var selectedData = dataMonth.find(function (entry) {
                        return entry.month === parseInt(selectedMonth);
                    });
                    totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";
                });
                $('div.custom-spinner').parent().remove();
            });

            if (yearSelect.value != "") {
                var selectedYear = yearSelect.value;
                var selectedData = data.find(function (entry) {
                    return entry.year === parseInt(selectedYear);
                });
                totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";
                monthSelect.style.display = 'block';
            } else {
                totalWorkingDayInput.value = null;
                monthSelect.style.display = 'none';
            }
        });
    });
</script>

<%--Handle Contract--%>
<script>
    // Lắng nghe sự kiện khi người dùng nhấn nút "Add Contract"
    document.addEventListener("DOMContentLoaded", function () {
        var addButtons = document.querySelectorAll(".add-contract-button");

        // Show modal Edit Contract
        addButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                $("#addContractModal").modal("show");
            });
        });
    });

    Validator({
        form:'#formAddContract',
        errorSelector: '.form-message',
        rules:[
            Validator.isRequired('#addBasicSalary'),
            Validator.isRequired('#addAllowance'),
            Validator.isRequired('#addInsuranceMoney')
        ],
        onSubmit: function (formData) {

            $('.container-button-add-contract').after(createLoadingHtml());

            formData.append('userId', '${user.id}');

            callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {
                sessionStorage.setItem('result', 'addContractSuccess');
                localStorage.setItem("showModal", "true");
                location.reload();
            }, 'formAddContract');
        }
    });


    // Lắng nghe sự kiện khi người dùng nhấn nút "Edit Contract"
    document.addEventListener("DOMContentLoaded", function () {
        var editButtons = document.querySelectorAll(".edit-contract-button");
        var contractIdEdit;

        // Show modal Edit Contract
        editButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                contractIdEdit = button.value;
                $("#editContractModal").modal("show");

                if (contractIdEdit) {

                    callAjaxByJsonWithData('/api/v1/contracts/' + contractIdEdit, 'GET', null, function (rs) {
                        var responseData = rs

                        // Đổ dữ liệu từ API vào các trường của modal
                        document.getElementById("editBasicSalary").value = responseData.basicSalary;
                        document.getElementById("editAllowance").value = responseData.allowance;

                        var selectElement = document.getElementById("editInsuranceType");
                        var editInsuranceType = responseData.insuranceType.name;
                        for (var i = 0; i < selectElement.options.length; i++) {
                            if (selectElement.options[i].text === editInsuranceType) {
                                // Option đã tồn tại, di chuyển option đó lên đầu
                                selectElement.insertBefore(selectElement.options[i], selectElement.options[0]);
                                break;
                            }
                        }
                        selectElement.selectedIndex = 0;

                        document.getElementById("editInsuranceMoney").value = responseData.insuranceMoney;
                        document.getElementById("contractFile").setAttribute("href", responseData.contract);
                    });
                }
            });
        });
    });

    // Lắng nghe sự kiện khi người dùng nhấn nút "Confirm Edit Contract"
    document.addEventListener('DOMContentLoaded', function () {
        var confirmButton = document.getElementById("confirmContractButton");
        var contractId = document.querySelectorAll(".edit-contract-button");
        var contractIdValue;

        contractId.forEach(function (button) {
            button.addEventListener("click", function () {
                contractIdValue = button.value;
            });
        });

        Validator({
            form:'#editContractForm',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#editBasicSalary'),
                Validator.isRequired('#editAllowance'),
                Validator.isRequired('#editInsuranceMoney')
            ],
            onSubmit: function (formData) {

                $('.container-button-edit-contract').after(createLoadingHtml());

                formData.append('id', contractIdValue);
                callAjaxByDataFormWithDataForm('/api/v1/contracts/updation', 'POST', formData, function (rs) {
                    sessionStorage.setItem('result', 'editContractSuccess');
                    localStorage.setItem("showModal", "true");
                    location.reload();
                }, 'editContractForm');
            }
        });
    });

    // Lắng nghe sự kiện khi người dùng nhấn nút "Confirm Delete Contract"
    document.addEventListener("DOMContentLoaded", function () {
        var deleteButtons = document.querySelectorAll(".delete-contract-button");
        var confirmButton = document.querySelector(".confirm-delete-button");
        var contractIdToDelete;

        // Xử lý khi nút Delete được nhấn
        deleteButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                contractIdToDelete = button.value;

                // Đặt trạng thái hiển thị modal trong Local Storage thành true
                localStorage.setItem("showModal", "true");
                $("#deleteContractModal").modal("show");
            });
        });

        // Xử lý khi nút Confirm được nhấn trong modal
        confirmButton.addEventListener("click", function () {
            if (contractIdToDelete) {
                $('.container-button-delete-contract').after(createLoadingHtml());
                callAjaxByJsonWithData('/api/v1/contracts/' + contractIdToDelete, 'DELETE', null, function (rs) {
                    sessionStorage.setItem('result', 'deleteContractSuccess');
                    localStorage.setItem("showModal", "true");
                    location.reload();
                });
            }
        });
    });
    window.onload = function () {
        // Kiểm tra trạng thái hiển thị modal trong Local Storage và hiển thị modal nếu cần
        if (localStorage.getItem("showModal") === "true") {
            $("#contractModal").modal("show");
            // Đặt trạng thái hiển thị modal trong Local Storage thành false để tránh hiển thị lần tiếp theo
            localStorage.setItem("showModal", "false");
        }
    };

</script>

<%--Handle Role--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy vai trò của người dùng
        var roleUser = userCurrent.role;

        var fieldsToHide = document.getElementsByClassName("hide");

        // Danh sách các trường và nút cần ẩn
        var buttonsToHide = ["delUser"];

        for (var i = 0; i < fieldsToHide.length; i++) {
            var div = fieldsToHide[i];
            if (div) {
                if (roleUser === U_DEVELOPER) {
                    div.style.display = "none";
                } else {
                    div.style.display = "block";
                }
            }
        }

        // Ẩn các nút
        buttonsToHide.forEach(function (buttonName) {
            var button = document.getElementById(buttonName);
            if (button) {
                if (roleUser === U_DEVELOPER) {
                    button.style.display = "none";
                } else {
                    button.style.display = "inline-block";
                }
            }
        });
    });
</script>
</body>
</html>