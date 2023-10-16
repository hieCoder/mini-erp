<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        .form-group {
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
<form action="" method="get">
    <div class="container">
        <div class="row">
            <!-- Phần 1: Hình ảnh avatar và tên người dùng -->
            <div class="col-md-4">
                <div class="text-center">
                    <img src="${user.getAvatar()}" class="img-fluid" alt="User Avatar" width="200">
                    <input type="file" class="form-control mt-2" id="avatar">
                    <small class="text-muted ml-2">Choose New Avatar</small>
                    <h3 class="mt-2">${user.getFullname()}</h3>
                </div>
            </div>

            <!-- Phần 2: Form thông tin người dùng -->
            <div class="col-md-8">
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" class="form-control" id="address" value="${user.getAddress()}">
                </div>
                <div class="form-group">
                    <label for="fullname">Username:</label>
                    <input type="text" class="form-control" id="fullname" value="${user.getFullname()}">
                </div>
                <div class="form-group">
                    <label for="dob">Date of birth:</label>
                    <input type="date" class="form-control" id="dob" value="${dateOfBirth}">
                </div>
                <div class="form-group">
                    <label for="phone">Phone number:</label>
                    <input type="tel" class="form-control" id="phone" value="${user.getPhone()}">
                </div>
                <div class="form-group">
                    <label for="emergencyPhone">Emergency phone:</label>
                    <input type="tel" class="form-control" id="emergencyPhone" value="${user.getEmergencyPhone()}">
                </div>
                <div class="form-group">
                    <label for="resume">Resume file:</label>
                    <a href="${user.getResume()}" download target="_blank" id="resumeLink">Download Resume</a>
                    <input type="file" class="form-control mt-2" id="resume">
                    <small class="text-muted ml-2">Choose new resume</small>
                </div>
                <div class="form-group">
                    <label for="timeSheetsCode">TimeSheets code:</label>
                    <input type="text" class="form-control" id="timeSheetsCode" value="${user.getTimesheetsCode()}">
                </div>
                <div class="form-group hide">
                    <label for="type">Type:</label>
                    <select class="form-control" id="type">
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
                    <select class="form-control" id="department">
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
                    <input type="email" class="form-control" id="userId" value="${user.getEmail()}">
                </div>
                <div class="form-group hide">
                    <label for="password">Password: </label>
                    <a id="change-password-button" class="text-primary" style="text-decoration: none">Change
                        password</a>
                    <div id="password-form" style="display: none;">
                        <input type="password" class="form-control" id="password" value="" placeholder="New Password">
                    </div>
                </div>
                <div class="form-group hide">
                    <label for="atm">ATM:</label>
                    <input type="text" class="form-control" id="atm" value="${user.getAtm()}">
                </div>
                <div class="form-group hide">
                    <label for="role">Role:</label>
                    <select class="form-control" id="role">
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
                    <select class="form-control" id="position">
                        <option value="INTERN" <c:if test="${user.position.code.equals('INTERN')}">selected</c:if>>
                            Inter
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
                <div class="form-group">
                    <button value="${user.getId()}" type="button" class="btn btn-primary" id="updateUserButton">Save
                    </button>
                    <button type="button" class="btn btn-danger ml-2" data-toggle="modal" data-target="#deleteUserModal"
                            id="delUser">
                        Delete
                    </button>
                    <a class="btn btn-secondary ml-2" href="/users">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</form>

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
                    <c:forEach var="contract" items="${contractUser}">
                        <tr>
                            <td>${contract.getBasicSalary()}$</td>
                            <td>${contract.getAllowance()}$</td>
                            <td>${contract.getInsuranceType().getName()}</td>
                            <td>${contract.getInsuranceMoney()}$</td>
                            <td><a href="${contract.getContract()}" download target="_blank" class="contractLink">Contract
                                Files</a></td>
                            <td>
                                <button value="${contract.getId()}" type="button"
                                        class="btn btn-primary mb-3 edit-contract-button">Edit
                                </button>
                                <button value="${contract.getId()}" type="button"
                                        class="btn btn-danger delete-contract-button">Delete
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
                <form action="/api/v1/contracts" method="post">
                    <div class="form-group">
                        <label for="editBasicSalary">Basic Salary:</label>
                        <input type="text" class="form-control" id="addBasicSalary" name="basicSalary">
                    </div>
                    <div class="form-group">
                        <label for="editAllowance">Allowance:</label>
                        <input type="text" class="form-control" id="addAllowance" name="allowance">
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
                        <input type="text" class="form-control" id="addInsuranceMoney" name="insuranceMoney">
                    </div>
                    <div class="form-group">
                        <label for="newContract">Contract</label>
                        <input type="file" class="form-control mt-2" id="newContract" name="contract">
                        <small class="text-muted ml-2">Choose New Contract</small>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button value="${user.getId()}" type="button" class="btn btn-primary" id="addContractButton">Confirm
                </button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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
                        <input type="text" class="form-control" id="editBasicSalary" name="editBasicSalary">
                    </div>
                    <div class="form-group">
                        <label for="editAllowance">Allowance:</label>
                        <input type="text" class="form-control" id="editAllowance" name="editAllowance">
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceType">Insurance Type:</label>
                        <select class="form-control" id="editInsuranceType" name="editInsuranceType">
                            <option value="HEALTH_INSURANCE">Health insurance</option>
                            <option value="SOCIAL_INSURANCE">Social insurance</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceMoney">Insurance Money:</label>
                        <input type="text" class="form-control" id="editInsuranceMoney" name="editInsuranceMoney">
                    </div>
                    <div class="form-group">
                        <label for="contractUser">Contract Files: </label>
                        <a href="" download target="_blank" id="contractFile">Download Contract</a>
                        <input type="file" class="form-control mt-2" id="contractUser">
                        <small class="text-muted ml-2">Choose New Contract</small>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="confirmContractButton">Confirm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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
            <div class="modal-footer">
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
            <div class="modal-footer">
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
    // Lắng nghe sự kiện khi người dùng nhấn nút "Change Password"
    document.getElementById("change-password-button").addEventListener("click", function () {
        var inputPassword = document.getElementById("password-form");
        if (inputPassword.style.display == "none") inputPassword.style.display = "block";
        else inputPassword.style.display = "none";
    });

    // Lắng nghe sự kiện khi người dùng nhấn nút "Save User"
    document.getElementById('updateUserButton').addEventListener('click', function () {

        // Lấy dữ liệu từ các trường trong form
        var id = this.value;
        var fullname = document.getElementById('fullname').value;
        var adderss = document.getElementById('address').value;
        var dobString = document.getElementById('dob').value;
        var jsDate = new Date(dobString);
        var dob = new Date(jsDate.getTime()); // Chuyển đổi thành đối tượng Java Date
        var phone = document.getElementById('phone').value;
        var emergencyPhone = document.getElementById('emergencyPhone').value;
        var fileAvatar = document.getElementById('avatar');
        var fileResume = document.getElementById('resume');
        var timeSheetsCode = document.getElementById('timeSheetsCode').value;
        var type = document.getElementById('type').value;
        var department = document.getElementById('department').value;
        var email = document.getElementById('userId').value;
        var atm = document.getElementById('atm').value;
        var password = document.getElementById('password').value;
        var role = document.getElementById('role').value;
        var position = document.getElementById('position').value;

        var user = new FormData();
        user.append('id', id);
        user.append('fullname', fullname);
        user.append('address', adderss);
        user.append('dateOfBirth', dob);
        user.append('phone', phone);
        user.append('emergencyPhone', emergencyPhone);
        user.append('timesheetsCode', timeSheetsCode);
        user.append('atm', atm);
        user.append('type', type);
        user.append('department', department);
        user.append('email', email);
        user.append('password', password);
        user.append('role', role);
        user.append('position', position);

        // Kiểm tra xem có tệp được chọn không
        if (fileAvatar.files.length > 0) {
            var fileAavar = fileAvatar.files[0];
            user.append('avatar', fileAavar);

        }
        if (fileResume.files.length > 0) {
            var fileResume = fileResume.files[0];
            user.append('resume', fileResume);
        }

        // Khởi tạo đối tượng XMLHttpRequest
        var xhr = new XMLHttpRequest();
        var url = '/api/v1/users/updation';

        // Thiết lập phương thức và URL cho yêu cầu
        xhr.open('POST', url, true);

        // Định nghĩa hàm xử lý kết quả trả về từ máy chủ
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    // Xử lý kết quả ở đây nếu cần
                    sessionStorage.setItem('result', 'updateSuccess');
                    location.href = "/users/" + ${user.getId()};
                } else {
                    // Xử lý lỗi nếu có
                    var errorMessage = "Lỗi:\n";
                    errorMessage += "The file transfer is just under 100MB.\n";
                    errorMessage += "Avatar: jpg, jpeg, png, svg.\n";
                    errorMessage += "Resume, Contract: pdf, csv, xlsx, doc, xls, pptx.";
                    alert(errorMessage);

                    console.log("Error File: " + xhr.status);
                }
            }
        };
        // Gửi yêu cầu với dữ liệu formData
        xhr.send(user);
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
                var xhr = new XMLHttpRequest();
                xhr.open("DELETE", "/api/v1/users/" + userId, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            // Tải lại trang
                            sessionStorage.setItem('result', 'deleteSuccess');
                            window.location.href = "/users";
                        } else {
                            // Xử lý khi API gọi không thành công
                            console.log("Delete User is False: " + xhr.status);
                        }
                    }
                };
                xhr.send();
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

        // Sử dụng XMLHttpRequest để gọi API
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '/api/v1/timesheets/workingday/' + ${user.getId()}, true);
        var data;
        xhr.onload = function () {
            if (xhr.status === 200) {
                data = JSON.parse(xhr.responseText);
                // Xóa các option cũ trong dropdown year
                yearSelect.innerHTML = '<option value="">-- Select Year --</option>';

                // Thêm các option mới từ dữ liệu API
                data.forEach(function (entry) {
                    var option = document.createElement('option');
                    option.value = entry.year;
                    option.textContent = entry.year;
                    yearSelect.appendChild(option);
                });
            } else {
                console.error("Can't get year: " + xhr.status);
            }
        };
        xhr.send();

        // Thêm sự kiện nghe cho việc thay đổi lựa chọn năm
        yearSelect.addEventListener('change', function () {
            xhr.open('GET', '/api/v1/timesheets/workingday/' + ${user.getId()} +"?year=" + yearSelect.value, true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    var dataMonth = JSON.parse(xhr.responseText);
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
                } else {
                    console.error("Can't get month: " + xhr.status);
                }
            };
            xhr.send();

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

    // Lắng nghe sự kiện click trên nút "Confirm Add Contract"
    document.getElementById('addContractButton').addEventListener('click', function () {

        // Lấy dữ liệu từ các trường trong form
        var userId = this.value;
        var basicSalary = document.getElementById('addBasicSalary').value;
        var allowance = document.getElementById('addAllowance').value;
        var insuranceType = document.getElementById('addInsuranceType').value;
        var insuranceMoney = document.getElementById('addInsuranceMoney').value;
        var fileInputContract = document.getElementById('newContract');


        var contract = new FormData();
        contract.append('basicSalary', basicSalary);
        contract.append('allowance', allowance);
        contract.append('insuranceType', insuranceType);
        contract.append('insuranceMoney', insuranceMoney);
        contract.append('userId', userId);

        // Kiểm tra xem có tệp được chọn không
        if (fileInputContract.files.length > 0) {
            var file = fileInputContract.files[0];
            contract.append('contract', file);
        }

        // Khởi tạo đối tượng XMLHttpRequest
        var xhr = new XMLHttpRequest();
        var url = '/api/v1/contracts';

        // Thiết lập phương thức và URL cho yêu cầu
        xhr.open('POST', url, true);

        // Định nghĩa hàm xử lý kết quả trả về từ máy chủ
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    // Xử lý kết quả ở đây nếu cần
                    sessionStorage.setItem('result', 'addContractSuccess');
                    localStorage.setItem("showModal", "true");
                    location.reload();
                } else {
                    // Xử lý lỗi nếu có
                    var errorMessage = "Error:\n";
                    errorMessage += "The file transfer is just under 100MB.\n";
                    errorMessage += "Avatar: jpg, jpeg, png, svg.\n";
                    errorMessage += "Resume, Contract: pdf, csv, xlsx, doc, xls, pptx.";
                    alert(errorMessage);

                    console.log('Add Contract is False' + xhr.status);
                }
            }
        };

        // Gửi yêu cầu với dữ liệu formData
        xhr.send(contract);
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
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "/api/v1/contracts/" + contractIdEdit, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4) {
                            if (xhr.status === 200) {
                                // Xử lý khi API gọi thành công
                                var responseData = JSON.parse(xhr.responseText);// Dữ liệu JSON trả về từ API

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

                            } else {
                                // Xử lý khi API gọi không thành công
                                console.log("Get Detail Contract is False: " + xhr.status);
                            }
                        }
                    };
                    xhr.send();
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

        confirmButton.addEventListener('click', function () {
            // Lấy dữ liệu từ các trường trong form
            var basicSalary = document.getElementById('editBasicSalary').value;
            var allowance = document.getElementById('editAllowance').value;
            var insuranceType = document.getElementById('editInsuranceType').value;
            var insuranceMoney = document.getElementById('editInsuranceMoney').value;
            var fileContract = document.getElementById('contractUser');

            var contract = new FormData();
            contract.append('id', contractIdValue);
            contract.append('basicSalary', basicSalary);
            contract.append('allowance', allowance);
            contract.append('insuranceType', insuranceType);
            contract.append('insuranceMoney', insuranceMoney);

            // Kiểm tra xem có tệp được chọn không
            if (fileContract.files.length > 0) {
                var contractFileName = fileContract.files[0];
                contract.append('contract', contractFileName);
            }

            // Khởi tạo đối tượng XMLHttpRequest
            var xhr = new XMLHttpRequest();
            var url = '/api/v1/contracts/updation';

            // Thiết lập phương thức và URL cho yêu cầu
            xhr.open('POST', url, true);

            // Định nghĩa hàm xử lý kết quả trả về từ máy chủ
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        // Xử lý kết quả ở đây nếu cần
                        sessionStorage.setItem('result', 'editContractSuccess');
                        localStorage.setItem("showModal", "true");
                        location.reload();
                    } else {
                        // Xử lý lỗi nếu có
                        // Xử lý lỗi nếu có
                        var errorMessage = "Error:\n";
                        errorMessage += "The file transfer is just under 100MB.\n";
                        errorMessage += "Avatar: jpg, jpeg, png, svg.\n";
                        errorMessage += "Resume, Contract: pdf, csv, xlsx, doc, xls, pptx.";
                        alert(errorMessage);
                        console.log('Edit Contract is False: ' + xhr.status);
                    }
                }
            };

            // Gửi yêu cầu với dữ liệu formData
            xhr.send(contract);
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
                var xhr = new XMLHttpRequest();
                xhr.open("DELETE", "/api/v1/contracts/" + contractIdToDelete, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            // Tải lại trang
                            sessionStorage.setItem('result', 'deleteContractSuccess');
                            localStorage.setItem("showModal", "true");
                            location.reload();
                        } else {
                            // Xử lý khi API gọi không thành công
                            console.log("Delete False: " + xhr.status);
                        }
                    }
                };
                xhr.send();
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
        var roleUser = "${roleUser}";

        var fieldsToHide = document.getElementsByClassName("hide");

        // Danh sách các trường và nút cần ẩn
        var buttonsToHide = ["delUser"];

        for (var i = 0; i < fieldsToHide.length; i++) {
            var div = fieldsToHide[i];
            if (div) {
                if (roleUser === "Developer") {
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
                if (roleUser === "Developer") {
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

