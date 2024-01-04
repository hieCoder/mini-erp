<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schedule List</title>
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">MANAGEMENT TIME LIST</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <li class="breadcrumb-item active">Management Time</li>
                </ol>
            </div>

        </div>
    </div>
</div>

<div class="container">
    <div class="card shadow">
        <div class="card-header">
            <h4 class="card-title mb-0">Management Time User List</h4>
        </div>

        <div class="card-body">
            <p class="text-muted">Use data attributes and other custom attributes as keys</p>
            <div id="users">
                <div class="row mb-2">
                    <div class="col">
                        <div>
                            <input class="search form-control" placeholder="Search">
                        </div>
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-light sort" data-sort="name">
                            Sort by name
                        </button>
                    </div>
                </div>

                <div data-simplebar="init" style="min-height: 80vh;" class="mx-n3">
                    <div class="simplebar-wrapper" style="margin: 0px;">
                        <div class="simplebar-height-auto-observer-wrapper">
                            <div class="simplebar-height-auto-observer"></div>
                        </div>
                        <div class="simplebar-mask">
                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                <div class="simplebar-content-wrapper" tabindex="0" role="region"
                                     aria-label="scrollable content">
                                    <div class="simplebar-content" style="padding: 0px;">
                                        <ul class="list list-group list-group-flush mb-0">
                                            <c:forEach varStatus="loop" var="user" items="${list}">
                                                <li class="list-group-item" data-id="${user.id}">
                                                    <div class="d-flex">
                                                        <div class="flex-grow-1">
                                                            <h5 class="fs-13 mb-1">
                                                                <script>
                                                                   var currentUrl = window.location.href;
                                                                   var urlSearchParams = new URLSearchParams(currentUrl);
                                                                   var newHref = '/management-time/' + ${user.id};
                                                                   urlSearchParams.forEach(function(value, key) {
                                                                       if (key.includes('year')) newHref = '/management-time/years?year=' + value + '&id=' + ${user.id};
                                                                       else if (key.includes('currentDay')) newHref = '/management-time/weekly-detail/' + ${user.id} + '?currentDay=' + value;
                                                                   });

                                                                   document.write('<a href="' + newHref + '" class="link name text-dark">' + '${user.fullname}' + '</a>');
                                                                </script>
                                                            </h5>
                                                            <p class="born timestamp text-muted mb-0"
                                                               data-timestamp="12345">${user.position}</p>
                                                        </div>
                                                        <div class="flex-shrink-0">
                                                            <div>
                                                                <img class="image avatar-xs rounded-circle" alt=""
                                                                     src="${user.avatar}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <!-- end ul list -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="simplebar-placeholder" style="width: auto; height: 311px;"></div>
                    </div>
                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                    </div>
                    <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                        <div class="simplebar-scrollbar"
                             style="height: 188px; transform: translate3d(0px, 54px, 0px); display: block;"></div>
                    </div>
                </div>
            </div>
        </div><!-- end card body -->
        <!-- end card -->
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.querySelector('.search');
        const nameElements = document.querySelectorAll('.name');

        searchInput.addEventListener('input', function() {
            const searchValue = this.value.toLowerCase();

            nameElements.forEach(function(nameElement) {
                const fullName = nameElement.innerText.toLowerCase();
                const listItem = nameElement.closest('.list-group-item');

                if (fullName.includes(searchValue)) {
                    listItem.style.display = 'block';
                } else {
                    listItem.style.display = 'none';
                }
            });
        });
    });
</script>
</body>
</html>
