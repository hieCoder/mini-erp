<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book detail</title>
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Book detail</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Time management</a></li>
                    <li class="breadcrumb-item active">Book detail</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<%--<!-- end page title -->--%>


<div class="row">
    <div class="col-lg-12">
        <div class="alert alert-success d-none"></div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="card" style="padding: 50px 50px 50px 0">
            <div class="row">
                <div class="col-md-3">
                    <div class="text-center">
                        <img src="${bookDetail.book.image}" class="img-fluid" alt="User Avatar" width="200">
                        <h4 class="mt-2 font-weight-bold">${bookDetail.book.title}</h4>
                        <p class="text-muted">Author: ${bookDetail.book.author}</p>
                        <a href="${bookDetail.book.link}" class="text-decoration-none">Link To Book</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <h3 class="mt-2 font-weight-bold">Your Feelings</h3>
                        <div class="col-md-12">
                            <div class="p-3">
                                <form>
                                    <div class="form-group mb-2">
                                        <label for="quotes1">Feel 1:</label>
                                        <input type="text" class="form-control" id="quotes1">
                                    </div>
                                    <div class="form-group mb-2">
                                        <label for="quotes2">Feel 2:</label>
                                        <input type="text" class="form-control" id="quotes2">
                                    </div>
                                    <div class="form-group mb-2">
                                        <label for="quotes3">Feel 3:</label>
                                        <input type="text" class="form-control" id="quotes3">
                                    </div>
                                    <div class="form-group mb-2">
                                        <button type="submit" class="btn btn-primary btn-load submit-btn">
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Submit</span>
                                        </span>
                                        </button>
                                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteFeelingModal">Delete</button>
                                        <a href="/books" type="button" class="btn btn-secondary">Back</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                        <div class="col-md-12">
                            <div class="p-3">
                                <div class="border">
                                    <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}">
                                            <div class="row pt-2">
                                                <div class="col-md-2 border-right text-center justify-content-center">
                                                    <img src="${feeling.avatarUser}" class="img-fluid rounded-circle"
                                                         alt="User Avatar" width="50px"> <br>
                                                    <p class="text-muted">${feeling.fullnameUser}</p>
                                                </div>
                                                <div class="col-md-10">
                                                    <c:forEach var="quote" items="${feeling.quotes}">
                                                        <p class="mb-1">- ${quote}</p>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end col-->
</div>
<!--end row-->




<%-- modal delete feeling book--%>
<div class="modal fade" id="deleteFeelingModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Confirm delete feeling</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure?
            </div>
            <div class="modal-footer">
                <button id="delete-btn" type="button" class="btn btn-danger">Confirm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function (){
        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + '${bookDetail.book.id}' + '/' + userCurrent.id, 'GET', null, function (rs) {
            console.log(rs);
            rs.quotes.forEach(function(quote, index) {
                $('#quotes'+(index+1)).val(quote);
            });

            $('.submit-btn').text('Update');
        });
    });
</script>


<%--<script>--%>

<%--    console.log(${bookDetail});--%>

<%--    var isCreate = true;--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>

<%--        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + '${bookDetail.book.id}' + '/' + userCurrent.id--%>
<%--            , 'GET', null, function (rs) {--%>
<%--                if (rs != null && rs.quotes.length != 0) {--%>
<%--                    isCreate = false;--%>
<%--                    document.getElementById("quotes1").value = rs.quotes[0]?rs.quotes[0]:'';--%>
<%--                    document.getElementById("quotes2").value = rs.quotes[1]?rs.quotes[1]:'';--%>
<%--                    document.getElementById("quotes3").value = rs.quotes[2]?rs.quotes[2]:'';--%>

<%--                    var submitButton = document.getElementById('submit');--%>
<%--                    submitButton.textContent = "Update";--%>
<%--                    submitButton.classList.remove("btn-primary");--%>
<%--                    submitButton.classList.add("btn-success");--%>

<%--                    document.getElementById('submit').addEventListener('click', function () {--%>
<%--                        var quotes1 = document.getElementById('quotes1').value;--%>
<%--                        var quotes2 = document.getElementById('quotes2').value;--%>
<%--                        var quotes3 = document.getElementById('quotes3').value;--%>
<%--                        var data = {--%>
<%--                            id: rs.id,--%>
<%--                            quote: quotes1 + '---' + quotes2 + '---' + quotes3--%>
<%--                        };--%>
<%--                        $('#back-button').after(createLoadingHtml());--%>
<%--                        callAjaxByJsonWithData('/api/v1/feeling-of-book', 'PUT', data, function () {--%>
<%--                            sessionStorage.setItem('result', 'updateSuccess');--%>
<%--                            location.reload();--%>
<%--                        }, 'formYourFeeling');--%>
<%--                    });--%>
<%--                };--%>
<%--            });--%>

<%--        $('#delete-btn').click(function() {--%>
<%--            var bookId= '${bookDetail.book.id}';--%>
<%--            var userId = userCurrent.id;--%>
<%--            $('#deleteFeelingModal .modal-footer').after(createLoadingHtml());--%>
<%--            callAjaxByJsonWithData("/api/v1/feeling-of-book?userId=" + userId + "&bookId=" + bookId, "DELETE", null, function (rs) {--%>
<%--                location.reload();--%>
<%--            }, 'formYourFeeling');--%>
<%--        });--%>
<%--    });--%>

<%--    // Handle when user click submit--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        document.getElementById('submit').addEventListener('click', function () {--%>
<%--            var bookId = '${bookDetail.book.id}';--%>
<%--            if (isCreate) {--%>
<%--                var quotes1 = document.getElementById('quotes1').value;--%>
<%--                var quotes2 = document.getElementById('quotes2').value;--%>
<%--                var quotes3 = document.getElementById('quotes3').value;--%>
<%--                if (isCreate) {--%>
<%--                    var data = {--%>
<%--                        userId: userCurrent.id,--%>
<%--                        quote: quotes1 + '---' + quotes2 + '---' + quotes3,--%>
<%--                        bookId: bookId--%>
<%--                    };--%>
<%--                    $('#submit').after(createLoadingHtml());--%>
<%--                    callAjaxByJsonWithData('/api/v1/feeling-of-book', 'POST', data, function () {--%>
<%--                        sessionStorage.setItem('result', 'addSuccess');--%>
<%--                        location.reload();--%>
<%--                    }, 'formYourFeeling')--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>


<%--    // Notification Success--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        const result = sessionStorage.getItem('result');--%>
<%--        if (result) {--%>
<%--            let message;--%>
<%--            switch (result) {--%>
<%--                case 'addSuccess':--%>
<%--                    message = 'Add Feeling Success';--%>
<%--                    break;--%>
<%--                case 'updateSuccess':--%>
<%--                    message = 'Update Feeling Success';--%>
<%--                    break;--%>
<%--                default:--%>
<%--                    message = 'Unknown Result';--%>
<%--            }--%>
<%--            ;--%>
<%--            $('#resultMessage').text(message);--%>
<%--            $('#resultModal').modal('show');--%>
<%--            sessionStorage.clear();--%>
<%--        };--%>
<%--    });--%>
<%--</script>--%>
</body>
</html>