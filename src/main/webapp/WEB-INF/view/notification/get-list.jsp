<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page import="com.shsoftvina.erpshsoftvina.enums.user.RoleEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    session.setAttribute("pathMain", "/notifications/");
%>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}" />git
<html>
<head>
    <title>Notifications List</title>
    <link rel="stylesheet" href="/assets/css/notification/style.css">
</head>
<body>
<div class="container">
    <h1>Notification List</h1>
<div class="row">
    <div class="col-md-4">
        <input type="text" value ="${search}" id="searchInput" class="form-control" placeholder="Title or Author">
    </div>
    <div class="col-md-2">
        <button class="btn btn-primary" id="searchButton">Search</button>
    </div>
    <div class="col-md-2">
    <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
            <a target="_blank" href="${pathMain}create"><button class="btn btn-success createBtn">Create</button></a>
    </c:if>

    </div>
    <div class="col-md-2">
        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
        <button class="btn btn-primary showListInactive">Show list inactive</button>
        </c:if>
    </div>

    <div class="col-md-2">
        <select id="pageSizeSelect" class="form-control">
            <option <c:if test='${pageSize  == 10}'>selected</c:if>>10</option>
            <option <c:if test='${pageSize  == 15}'>selected</c:if>>15</option>
            <option <c:if test='${pageSize  == 20}'>selected</c:if>>20</option>
        </select>
    </div>
</div>
<table id="notificationTable" class="table mt-3">
    <thead>
    <tr>
        <th scope="col">No.</th>
        <th scope="col">Title</th>
        <th scope="col">Author</th>
        <th scope="col">Created Date</th>
    </tr>
    </thead>
    <tbody id="notificationList">
        <c:forEach items="${listNotification}" varStatus="loop" var="notification">
            <tr>
                <td>${loop.index + 1}</td>
                <td>
                    <a href="<c:url value='/notifications/${notification.id}'/>">${notification.title}</a>
                </td>
                <td>${notification.user.fullname}</td>
                <td>${notification.createdDate}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

        <nav aria-label="Page navigation" <c:if test="${totalPages <= 1}">class="invisible"</c:if> >
            <ul class="pagination justify-content-center" id="paginationList">
                <li class="page-item linkStart">
                <span class="btn page-link"
                      data-page="1"><<</span>
                </li>
                <li class="page-item linkStart">
                <span class="btn page-link"
                      data-page="-1"><</span>
                </li>
                <c:forEach var="page" begin="1" end="${totalPages}">
                    <li class="page-item <c:if test="${currentPage == page}"> active</c:if>">
                    <span class="btn page-link"
                          data-page="${page}">${page}</span>
                    </li>
                </c:forEach>
                <li class="page-item linkEnd">
                <span class="btn page-link"
                      data-page="+1">></span>
                </li>
                <li class="page-item linkEnd">
                <span class="btn page-link"
                      data-page="${totalPages}">>></span>
                </li>
            </ul>
        </nav>

</div>
<div class="modal fade" id="listInactive" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">List Inactive Notification</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="inactiveNotificationTable" class="table mt-3">
                    <thead>
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Title</th>
                        <th scope="col">Author</th>
                        <th scope="col">Created Date</th>
                    </tr>
                    </thead>
                    <tbody id="inactiveNotificationList">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    const dot = createLoadingHtml();
    function displayPagination(){
        var currentUrl = window.location.search;
        var params = new URLSearchParams(currentUrl);
        var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
        if(currentPage == 1){
            $("li.linkStart").addClass("d-none")
        } else{
            $("li.linkStart").removeClass("d-none")
        }
        var lastPageElement = $("#paginationList > li").eq(-3)
        let lastPage = $(lastPageElement).children().attr("data-page")
        if(currentPage == lastPage){
            $("li.linkEnd").addClass("d-none")
        } else{
            $("li.linkEnd").removeClass("d-none")
        }
    }
    document.addEventListener("DOMContentLoaded", function() {
        displayPagination()
        const baseUrl = "/api/v1/notifications";
        var paginationList = document.getElementById("paginationList");
        paginationList.addEventListener("click", function (event) {
            var currentUrl = window.location.search;
            var params = new URLSearchParams(currentUrl);
            var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
            var target = event.target;

            if (target.tagName === "SPAN") {
                var page = target.getAttribute("data-page");
                if (page === "-1") {
                    page = currentPage - 1
                    if (page < 1) {
                        return;
                    }
                } else if (page === "+1") {
                    page = currentPage + 1;
                }
                if(currentPage == page || page > ${totalPages}){
                    return;
                }
                if (currentUrl.includes("page=")) {
                    currentUrl = currentUrl.replace(/(page=)[^\&]+/, "page=" + page);
                } else {
                    if (currentUrl.includes("?")) {
                        currentUrl += "&page=" + page;
                    } else {
                        currentUrl += "?page=" + page;
                    }
                }
            }
            document.querySelector(".page-item.active").classList.remove("active");
            var listActive = document.querySelectorAll('[data-page="' + page + '"]')
                if(page == 1){
                    listActive[1].parentElement.classList.add("active");
                } else{
                    listActive[0].parentElement.classList.add("active");
                }
                var apiUrl = baseUrl + currentUrl
                var tbodyElement = document.getElementById("notificationList");
                var tableElement = document.getElementById("notificationTable");
                tbodyElement.classList.add("hidden")
                tableElement.insertAdjacentHTML('afterend', `
                            <div class="text-center">
                              <div class="custom-spinner">
                                <div class="dot"></div>
                              </div>
                            </div>
                        `);
                const xhr = new XMLHttpRequest();
                xhr.open("GET", apiUrl, true);
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        var data = JSON.parse(xhr.responseText);
                        history.pushState(null, null, currentUrl);
                        var customSpinner = document.querySelector('.custom-spinner');
                        var parentDiv = customSpinner.parentElement;
                        parentDiv.remove()
                        let xhtml =""
                        data.forEach(function(notification, index) {
                            let pageInt = (parseInt(page) - 1)*10
                            xhtml += '<tr>' +
                                '<td>' + (index + pageInt + 1) + '</td>' +
                                '<td><a href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '</tr>';
                        })
                        tbodyElement.innerHTML = xhtml
                        tbodyElement.classList.remove("hidden")
                        displayPagination()
                    } else {
                        console.error("Request failed with status:", xhr.status);
                    }
                };

                xhr.onerror = function() {
                    console.error("Request error");
                };
                xhr.send();

        });

        const pageSizeSelect = document.getElementById("pageSizeSelect");

        pageSizeSelect.addEventListener("change", () => {
            const selectedValue = pageSizeSelect.value;
            updateUrl(selectedValue);
        });

        const updateUrl = (selectedValue) => {
            let currentUrl = window.location.href;
            if (currentUrl.includes("pageSize=")) {
                currentUrl = currentUrl.replace(/(pageSize=)[^\&]+/, "pageSize=" + selectedValue);
            } else {
                if (currentUrl.includes("?")) {
                    currentUrl += "&pageSize=" + selectedValue
                } else {
                    currentUrl += "?pageSize=" + selectedValue
                }
            }
            window.location.href = currentUrl
        };

        function searchNotification() {
            var keyword = searchInput.value;
            var currentUrl = window.location.href;

            if (currentUrl.includes("?")) {
                if (currentUrl.includes("search=")) {
                    var regex = /(\?|&)search=([^&]*)/;
                    var newUrl = currentUrl.replace(regex, "$1search=" + encodeURIComponent(keyword));
                    window.location.href = newUrl;
                } else {
                    var newUrl = currentUrl + "&search=" + encodeURIComponent(keyword);
                    window.location.href = newUrl;
                }
            } else {
                var newUrl = currentUrl + "?search=" + encodeURIComponent(keyword);
                window.location.href = newUrl;
            }
        }


        var searchInput = document.getElementById("searchInput");
        var searchButton = document.getElementById("searchButton");
        searchInput.addEventListener("keydown", handleSearchEvent);
        searchButton.addEventListener("click", handleSearchEvent);

        function handleSearchEvent(event) {
            if (event.key === "Enter" || event.type === "click") {
                searchNotification();
            }
        }

        $("button.showListInactive").click(function() {
            $(this).after(dot);
            $(this).prop("disabled", true)
            callAjaxByJsonWithData(baseUrl + "/inactive","GET",null,function (rs){
                if(rs){
                    let xhtml =""
                    if(rs.length > 0) {
                        rs.forEach(function(notification, index) {
                            xhtml += '<tr>' +
                                '<td>' + (index + 1) + '</td>' +
                                '<td><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '</tr>';
                        })
                        $("#inactiveNotificationList").html(xhtml)
                    } else{
                        xhtml= '<tr>'+
                            '<td class="text-center" colspan="4">'+
                            '<span class="badge badge-warning">The list is empty</span>'+
                            '</td>'+
                            '</tr>'
                        $("#inactiveNotificationList").html(xhtml)
                    }
                    $("#listInactive").modal("show")
                    $("button.showListInactive").prop("disabled", false)
                }else{
                    console.log("Error")
                    $("button.showListInactive").prop("disabled", false)
                }
            })
        });
    })
</script>
</body>
</html>
