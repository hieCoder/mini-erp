<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="form" action="/books" method="GET">
    <div class="container">
        <h1 class="mt-4">BOOKS</h1>
        <div class="row mt-4">
            <%--                        <div class="col-md-6">--%>
            <%--                            <div class="form-group">--%>
            <%--                                <label for="search">Search</label>--%>
            <%--                                <div class="input-group">--%>
            <%--                                    <input id="search" name="search" type="text" class="form-control" placeholder="Search">--%>
            <%--                                    <div class="input-group-append">--%>
            <%--                                        <button class="btn btn-primary" type="submit">Search</button>--%>
            <%--                                    </div>--%>
            <%--                                </div>--%>
            <%--                            </div>--%>
            <%--                        </div>--%>
            <div class="col-md-12 mb-2 text-right">
                <button type="button" class="btn btn-success px-4 add-book-button">Add Book</button>
            </div>
        </div>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">NO.</th>
                <th scope="col">ID</th>
                <th scope="col">Title</th>
                <th scope="col">Author</th>
                <th scope="col">Link</th>
                <th scope="col">FullName</th>
                <th scope="col">Created Date</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="book" items="${books}" varStatus="loop">
                <tr>
                    <th scope="row">${(users.pageNumber - 1) * users.pageSize + loop.index + 1}</th>
                    <td>${book.id}</td>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td><a href="" target="_blank" class="bookLink text-decoration-none">${book.link}</a></td>
                    <td>${book.createdBy}</td>
                    <td>${book.createdDate}</td>
                    <td>
                        <button value="" type="button"
                                class="btn btn-primary mb-2">Edit
                        </button>
                        <button value="${book.id}" type="button" class="btn btn-danger del-book-button" data-toggle="modal" data-target="#deleteBookModal">Delete</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- Pagination -->
        <%--        <div class="row justify-content-center">--%>
        <%--            <ul class="pagination">--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasPrevious}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="1"><<</button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasPrevious}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="${users.pageNumber - 1}"><</button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--                <c:forEach var="page" begin="1" end="${users.totalPages}">--%>
        <%--                    <c:choose>--%>
        <%--                        <c:when test="${page == users.pageNumber}">--%>
        <%--                            <li class="page-item active"><a class="page-link" href="#">${page}</a></li>--%>
        <%--                        </c:when>--%>
        <%--                        <c:otherwise>--%>
        <%--                            <li class="page-item">--%>
        <%--                                <button class="page-link" type="submit" name="page" value="${page}">${page}</button>--%>
        <%--                            </li>--%>
        <%--                        </c:otherwise>--%>
        <%--                    </c:choose>--%>
        <%--                </c:forEach>--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasNext}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="${users.pageNumber + 1}">></button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--                <li class="page-item">--%>
        <%--                    <c:if test="${users.hasNext}">--%>
        <%--                        <button class="page-link" type="submit" name="page" value="${users.totalPages}">>></button>--%>
        <%--                    </c:if>--%>
        <%--                </li>--%>
        <%--            </ul>--%>
        <%--        </div>--%>
    </div>
</form>

<!-- Modal Add Book -->
<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog"
     aria-labelledby="addBookModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-center">Add Book</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="" method="post">
                    <div class="form-group row">
                        <label for="title" class="col-sm-2 col-form-label">Title:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="title" placeholder="Title here" required>
                            <span class="errorMessage" style="color: red;"></span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="author" class="col-sm-2 col-form-label">Author:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="author" placeholder="Author here" required>
                            <span class="errorMessage" style="color: red;"></span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="link" class="col-sm-2 col-form-label">Link:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="link" placeholder="Link here" required>
                            <span class="errorMessage" style="color: red;"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="addBookButton">Submit
                </button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Delete Book -->
<div class="modal fade" id="deleteBookModal" tabindex="-1" role="dialog" aria-labelledby="deleteBookModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this book ?
            </div>
            <div class="modal-footer container-button-delete-user">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger confirm-del-button">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Notification  -->
<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"
     aria-hidden="true">
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

<script>

    // Handle when user click button 'Add Book'
    document.addEventListener('DOMContentLoaded', function () {
        var addButton = document.querySelectorAll('.add-book-button');

        addButton.forEach(function (button) {
            button.addEventListener('click', function () {
                $('#addBookModal').modal('show');
            });
        });

        var submitButton = document.getElementById('addBookButton');
        submitButton.addEventListener('click', function () {
            var titleE = document.getElementById('title');
            var authorE = document.getElementById('author');
            var linkE = document.getElementById('link');

            var valueTitle = titleE.value;
            var valueAuthor = authorE.value;
            var valueLink = linkE.value;

            var isValidate = true;

            var errorMessageSpan = titleE.nextElementSibling;
            if (valueTitle === "") {
                errorMessageSpan.textContent = "This filed is not filled";
                isValidate = false;
            } else {
                errorMessageSpan.textContent = '';
            }

            errorMessageSpan = authorE.nextElementSibling;
            if (valueAuthor === "") {
                errorMessageSpan.textContent = "This filed is not filled";
                isValidate = false;
            } else {
                errorMessageSpan.textContent = '';
            }

            errorMessageSpan = linkE.nextElementSibling;
            if (valueLink === "") {
                errorMessageSpan.textContent = "This filed is not filled";
                isValidate = false;
            } else {
                errorMessageSpan.textContent = '';
            }

            if (isValidate) {
                var xhr = new XMLHttpRequest();
                var method = 'POST';
                var url = '/api/v1/books';
                xhr.open(method, url, true);
                xhr.setRequestHeader("Content-Type", "application/json");

                var data = {
                    title: valueTitle,
                    author: valueAuthor,
                    link: valueLink,
                    fullnameUser: userCurrent.fullname
                };

                var jsonData = JSON.stringify(data);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        sessionStorage.setItem('result', 'addBookSuccess');
                        location.reload();
                    } else {
                        console.log(xhr.status);
                    }
                }
                xhr.send(jsonData);
            };
        });
    });

    // Handle when user click button 'Delete Book' in modal Delete Book
    document.addEventListener('DOMContentLoaded', function () {
        var delButtons = document.querySelectorAll(".del-book-button");
        var confirmDelButton = document.querySelector(".confirm-del-button");
        var bookId;

        // Xử lý khi nút Delete được nhấn
        delButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                bookId = button.value;
                confirmDelButton.addEventListener('click', function () {
                    if (bookId) {
                        var xhr = new XMLHttpRequest();
                        var method = 'DELETE';
                        var url = '/api/v1/books/' + bookId;
                        xhr.open(method, url, true);

                        xhr.onreadystatechange = function () {
                            if (xhr.readyState === 4 && xhr.status === 200) {
                                sessionStorage.setItem('result', 'delBookSuccess');
                                location.reload();
                            } else {
                                console.log(xhr.status);
                            }
                        }
                        xhr.send();
                    }
                })
            });
        });
    });

    // Notification
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            let message;
            switch (result) {
                case 'addBookSuccess':
                    message = 'Add Book Success';
                    break;
                case 'delBookSuccess':
                    message = 'Delete Book Success';
                    break;
                default:
                    message = 'Unknown Result';
            }
            $('#resultMessage').text(message);
            $('#resultModal').modal('show');
            sessionStorage.clear();
        }
    });

    // // Get value Search save to Local Storage
    // document.getElementById("search").addEventListener("input", function () {
    //     localStorage.setItem("selectedSearch", this.value);
    // });
    //
    // // Restore "Search" value from Local Storage
    // window.addEventListener("load", function () {
    //     var selectedSearch = localStorage.getItem("selectedSearch");
    //     if (selectedSearch) {
    //         document.getElementById("search").value = selectedSearch;
    //     }
    // });

</script>

</body>
</html>
