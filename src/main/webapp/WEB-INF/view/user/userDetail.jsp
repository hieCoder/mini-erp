<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/10/2023
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
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
                    <h5 class="mt-2" id="fullname">${user.getFullname()}</h5>
                </div>
            </div>

            <!-- Phần 2: Form thông tin người dùng -->
            <div class="col-md-8">
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" class="form-control" id="address" value="${user.getAddress()}">
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth</label>
                    <input type="date" class="form-control" id="dob" value="${dateOfBirth}">
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" value="${user.getPhone()}">
                </div>
                <div class="form-group">
                    <label for="emergencyPhone">Emergency Phone</label>
                    <input type="tel" class="form-control" id="emergencyPhone" value="${user.getEmergencyPhone()}">
                </div>
                <div class="form-group">
                    <label for="resume">Resume File: </label>
                    <a href="${user.getResume()}" download target="_blank" id="resumeLink">Download Resume</a>
                    <input type="file" class="form-control mt-2" id="resume">
                    <small class="text-muted ml-2">Choose New Resume</small>
                </div>
                <div class="form-group">
                    <label for="timeSheetsCode">TimeSheets code</label>
                    <input type="text" class="form-control" id="timeSheetsCode" value="${user.getTimesheetsCode()}">
                </div>
                <div class="form-group">
                    <label for="type">Type</label>
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
                <div class="form-group">
                    <label for="department">Department</label>
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
                <div class="form-group">
                    <label for="userId">User ID</label>
                    <input type="email" class="form-control" id="userId" value="${user.getEmail()}">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password">
                </div>
                <div class="form-group">
                    <label for="atm">ATM</label>
                    <input type="text" class="form-control" id="atm" value="${user.getAtm()}">
                </div>
                <div class="form-group">
                    <label for="role">Role</label>
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
                <div class="form-group">
                    <label for="position">Position</label>
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
                            Senior Manager
                        </option>
                        <option value="OWNER" <c:if test="${user.position.code.equals('OWNER')}">selected</c:if>>
                            Owner
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="contract">Contract: </label>
                    <button id="contract" type="button" class="btn btn-warning font-weight-bold" data-toggle="modal"
                            data-target="#contractModal">
                        VIEW
                    </button>
                </div>
                <div class="form-group">
                    <label for="working-day">Working Day</label>
                    <div class="input-group" id="working-day">
                        <select class="form-control" id="working-year">
                            <option value="">-- Select Year --</option>
                            <c:forEach items="${workingDay}" var="data">
                                <option value="${data.year}">${data.year}</option>
                            </c:forEach>
                        </select>
                        <select class="form-control" id="working-month" style="display: none;">
                            <option value="">-- Select Month --</option>
                            <c:choose>
                                <c:when test="${not empty workingDay and not empty workingDay[0].month}">
                                    <c:forEach items="${workingDay}" var="data">
                                        <option value="${data.month}">${data.month}</option>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                            <option value="1">January</option>
                            <option value="2">February</option>
                            <!-- Thêm các option cho các tháng khác nếu cần -->
                        </select>
                        <input type="text" class="form-control" id="totailWorkingDay" readonly placeholder="Result">
                        <div class="input-group-prepend">
                            <button class="btn btn-primary" type="button" id="checkTotalWorkingDay">Check Total
                                WorkingDay
                            </button>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <button value="${user.getId()}" type="button" class="btn btn-primary" id="updateUserButton">Save</button>
                    <button type="button" class="btn btn-danger ml-2" data-toggle="modal" data-target="#deleteUserModal">
                        Delete
                    </button>
                    <a class="btn btn-secondary ml-2" href="/users">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- Modal Contract History -->
<div class="modal fade" id="contractModal" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Contract History</h4>
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
                            <td><a href="${contract.getContract()}" download target="_blank">Contract Files</a></td>
                            <td>
                                <button value="${contract.getId()}" type="button" class="btn btn-primary mb-3 edit-contract-button">Edit</button>
                                <button value="${contract.getId()}" type="button" class="btn btn-danger delete-contract-button">Delete</button>
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

<!-- Modal Contract Edit -->
<div class="modal fade" id="editContractModal" tabindex="-1" role="dialog" aria-labelledby="editContractModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
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
                        <select class="form-control" id="editInsuranceType"  name="editInsuranceType">
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
                <button type="button" class="btn btn-primary" id="editContractButton">Edit</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal ADD Contract  -->
<div class="modal fade" id="addContractModal" tabindex="-1" role="dialog" aria-labelledby="addContractModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-center">Add Contract</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/api/v1/contracts" method="post" id="addContractForm" >
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
                        <select class="form-control" id="addInsuranceType"  name="insuranceType">
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
                <button value="${user.getId()}" type="button" class="btn btn-primary" id="addContractButton">Confirm</button>
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this user?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>


<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>



<script>
    // Lắng nghe sự kiện khi người dùng thay đổi năm
    document.getElementById("working-year").addEventListener("change", function () {
        var yearValue = this.value;
        var monthInput = document.getElementById("working-month");

        if (yearValue !== "") {
            // Gọi API để lấy dữ liệu month
            fetch(`/api/v1/timesheets/workingday/{userID}?year=${yearValue}`)
                .then(response => response.json())
                .then(data => {
                    // Xóa tất cả các option hiện tại trong select month
                    while (monthInput.options.length > 0) {
                        monthInput.remove(0);
                    }

                    // Thêm các option mới dựa trên dữ liệu từ API
                    data.forEach(item => {
                        var option = document.createElement("option");
                        option.value = item.month;
                        option.text = item.month;
                        monthInput.add(option);
                    });

                    // Hiển thị select month
                    monthInput.style.display = "block";
                })
                .catch(error => console.error(error));
        } else {
            // Nếu không chọn năm, ẩn select month
            monthInput.style.display = "none";
        }
    });

</script>

<%--Handle User--%>
<script>
    // Lắng nghe sự kiện khi người dùng nhấn nút "Save"
    document.getElementById('updateUserButton').addEventListener('click', function () {

        // Lấy dữ liệu từ các trường trong form
        var id = this.value;
        var fullname = document.getElementById('fullname').textContent;
        var adderss = document.getElementById('address').value;
        var dobString  = document.getElementById('dob').value;
        var jsDate = new Date(dobString);
        var dob = new Date(jsDate.getTime()); // Chuyển đổi thành đối tượng Java Date
        var phone = document.getElementById('phone').value;
        var emergencyPhone = document.getElementById('emergencyPhone').value;
        var fileAvatar = document.getElementById('avatar');
        var avatarFileName = fileAvatar.files[0];
        var fileResume = document.getElementById('resume');
        var resumeFileName = fileResume.files[0];
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
        user.append('avatar', avatarFileName);
        user.append('resume', resumeFileName);
        user.append('timesheetsCode', timeSheetsCode);
        user.append('atm', atm);
        user.append('type', type);
        user.append('department', department);
        user.append('email', email);
        user.append('password', password);
        user.append('role', role);
        user.append('position', position);

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
                    window.location.href = "/users";
                } else {
                    // Xử lý lỗi nếu có
                    console.log('Yêu cầu POST thất bại');
                }
            }
        };
        // Gửi yêu cầu với dữ liệu formData
        xhr.send(user);
    });

</script>

<%--Handle Contract--%>
<script>

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
                                console.log(editInsuranceType)
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

                                // location.reload(); // Làm tải lại trang
                            } else {
                                // Xử lý khi API gọi không thành công
                                console.log("Lỗi khi xóa hợp đồng: " + xhr.status);
                            }
                        }
                    };
                    xhr.send();
                }
            });
        });
    });

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

    // Lắng nghe sự kiện click trên nút "Confirm"
    document.getElementById('addContractButton').addEventListener('click', function () {

        // Lấy dữ liệu từ các trường trong form
        var userId = this.value;
        var basicSalary = document.getElementById('addBasicSalary').value;
        var allowance = document.getElementById('addAllowance').value;
        var insuranceType = document.getElementById('addInsuranceType').value;
        var insuranceMoney = document.getElementById('addInsuranceMoney').value;
        var fileInputContract = document.getElementById('newContract');
        var file = fileInputContract.files[0];

        var contract = new FormData();
        contract.append('basicSalary', basicSalary);
        contract.append('allowance', allowance);
        contract.append('insuranceType', insuranceType);
        contract.append('insuranceMoney', insuranceMoney);
        contract.append('contract', file);
        contract.append('userId', userId);

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
                    localStorage.setItem("showModal", "true");
                    location.reload();
                } else {
                    // Xử lý lỗi nếu có
                    console.log('Yêu cầu POST thất bại');
                }
            }
        };

        // Gửi yêu cầu với dữ liệu formData
        xhr.send(contract);
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
                            location.reload();
                        } else {
                            // Xử lý khi API gọi không thành công
                            console.log("Lỗi khi xóa hợp đồng: " + xhr.status);
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
</body>
</html>

