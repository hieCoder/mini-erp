<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book detail</title>
    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
    <style>
        a {
            cursor: default;
        }
        textarea {
            height: 110px;
        }
    </style>
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
        <div class="card" style="padding: 50px 50px 50px 0">
            <div class="row">
                <div class="col-md-3">
                    <div class="text-center">
                        <img src="${bookDetail.book.image}" class="img-fluid" alt="User Avatar" width="200">
                        <h4 class="mt-2 font-weight-bold">${bookDetail.book.title}</h4>
                        <p class="text-muted">Author: ${bookDetail.book.author}</p>
                        <a href="${bookDetail.book.link}" class="cursor-pointer">Link To Book</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="text-center loading-feeling">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </div>
                            <form class="d-none feeling">
                                <div class="accordion custom-accordionwithicon "
                                     id="accordionWithicon">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="feelingBook">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#feeling" aria-expanded="false"
                                                    aria-controls="feeling">
                                                <i class="ri-message-2-line me-2 fs-4"></i> Feel about the book?
                                            </button>
                                        </h2>
                                        <div id="feeling" class="accordion-collapse collapse"
                                             aria-labelledby="feelingBook"
                                             data-bs-parent="#accordionWithicon">
                                            <textarea class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="lessonBook">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#lesson" aria-expanded="false"
                                                    aria-controls="lesson">
                                                <i class="ri-pencil-ruler-line me-2 fs-4"></i> Lesson learned after
                                                reading the book?
                                            </button>
                                        </h2>
                                        <div id="lesson" class="accordion-collapse collapse"
                                             aria-labelledby="lessonBook"
                                             data-bs-parent="#accordionWithicon">
                                            <textarea class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="quoteBook">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#quotes" aria-expanded="false"
                                                    aria-controls="quotes">
                                                <i class="ri-double-quotes-l me-2 fs-4"></i> Great quotes?
                                            </button>
                                        </h2>
                                        <div id="quotes" class="accordion-collapse collapse"
                                             aria-labelledby="quoteBook"
                                             data-bs-parent="#accordionWithicon">
                                            <textarea class="form-control" ></textarea>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="actionBook">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#action" aria-expanded="false"
                                                    aria-controls="action">
                                                <i class="ri-user-location-line me-2 fs-4"></i> Action?
                                            </button>
                                        </h2>
                                        <div id="action" class="accordion-collapse collapse"
                                             aria-labelledby="actionBook"
                                             data-bs-parent="#accordionWithicon">
                                            <textarea class="form-control"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <button type="button" class="btn btn-primary btn-load submit-btn" id="submit">
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none"
                                                  style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Submit</span>
                                        </span>
                                    </button>
                                    <button type="button" class="btn btn-primary btn-load submit-btn d-none"
                                            id="update" data-id="">
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none"
                                                  style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Update</span>
                                        </span>
                                    </button>
                                    <button type="button" class="btn btn-danger" data-toggle="modal"
                                            data-target="#deleteFeelingModal" id="delete-btn">Delete
                                    </button>
                                    <a href="/books" type="button" class="btn btn-secondary">Back</a>
                                </div>
                            </form>

                        </div>
                        <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                        <div class="col-md-12">
                            <div data-simplebar style="max-height: 350px">
                                <div class="text-center loading-feeling">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                </div>
<%--                                <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}">--%>
<%--                                    <div class="row border mb-2 d-none feeling">--%>
<%--                                        <div class="col-md-2 d-flex flex-column justify-content-center align-items-center border-end">--%>
<%--                                            <img src="${feeling.avatarUser}" class="img-fluid rounded-circle"--%>
<%--                                                 alt="User Avatar" width="70px">--%>
<%--                                            <p class="m-0">${feeling.fullnameUser}</p>--%>
<%--                                        </div>--%>
<%--                                        <div class="col-md-10 d-flex flex-column justify-content-center"--%>
<%--                                             style="min-height: 120px">--%>
<%--                                            <c:forEach var="quote" items="${feeling.quotes}">--%>
<%--                                                <c:if test='${!quote.equals("")}'>--%>
<%--                                                    <p class="mt-1 mb-1">- ${quote}</p>--%>
<%--                                                </c:if>--%>
<%--                                            </c:forEach>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </c:forEach>--%>
                                <div class="list-group">
                                    <a href="javascript:void(0);" class="list-group-item">
                                        <div class="d-flex mb-2 align-items-center">
                                            <div class="flex-shrink-0">
                                                <img src="/assets/images/users/avatar-2.jpg" alt="" class="avatar-sm rounded-circle" />
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h5 class="list-title fs-15 mb-1">Dominic Charlton</h5>
                                                <p class="list-text mb-0 fs-12">12 min Ago</p>
                                            </div>
                                        </div>
                                        <p class="list-text mb-0">Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin.</p>
                                    </a>
                                    <a href="javascript:void(0);" class="list-group-item">
                                        <div class="d-flex mb-2 align-items-center">
                                            <div class="flex-shrink-0">
                                                <img src="/assets/images/users/avatar-2.jpg" alt="" class="avatar-sm rounded-circle" />
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h5 class="list-title fs-15 mb-1">Dominic Charlton</h5>
                                                <p class="list-text mb-0 fs-12">12 min Ago</p>
                                            </div>
                                        </div>
                                        <p class="list-text mb-0">Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin.</p>
                                    </a>
                                    <a href="javascript:void(0);" class="list-group-item">
                                        <div class="d-flex mb-2 align-items-center">
                                            <div class="flex-shrink-0">
                                                <img src="/assets/images/users/avatar-3.jpg" alt="" class="avatar-sm rounded-circle" />
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h5 class="list-title fs-15 mb-1">Declan Long</h5>
                                                <p class="list-text mb-0 fs-12">12 min Ago</p>
                                            </div>
                                        </div>
                                        <p class="list-text mb-0">Big July earthquakes confound zany experimental vow. My girl wove six dozen plaid jackets before she quit. Six big devils from Japan quickly forgot how to waltz. try again until it looks right, and each assumenda labore aes Homo nostrud organic, assumenda labore aesthetic magna elements, buttons, everything.</p>
                                    </a>
                                    <a href="javascript:void(0);" class="list-group-item">
                                        <div class="d-flex mb-2 align-items-center">
                                            <div class="flex-shrink-0">
                                                <img src="/assets/images/users/avatar-4.jpg" alt="" class="avatar-sm rounded-circle" />
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h5 class="list-title fs-15 mb-1">Angela Bernier</h5>
                                                <p class="list-text mb-0 fs-12">5 days Ago</p>
                                            </div>
                                        </div>
                                        <p class="list-text mb-0">Just like in the image where we talked about using multiple fonts, you can see that the background in this graphic design is blurred. Whenever you put text on top of an image, it’s important that your viewers can understand the text, and sometimes that means applying a gaussian readable.</p>
                                    </a>
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

<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
    $(document).ready(function () {
        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + '${bookDetail.book.id}' + '/' + userCurrent.id, 'GET', null, function (rs) {
            rs.quotes.forEach(function (quote, index) {
                $('#quotes' + (index + 1)).val(quote);
            });

            $('.feeling').removeClass('d-none');
            $('.loading-feeling').addClass('d-none');
            $('#update').removeClass('d-none');
            $('#update').attr('data-id', rs.id);
            $('#submit').addClass('d-none');
        }, function (rs) {
            $('.feeling').removeClass('d-none');
            $('.loading-feeling').addClass('d-none');
        });
    });

    $('#update').click(function () {
        var id = $(this).data('id');
        var quoteElements = document.querySelectorAll('form .quote');
        var valueArray = Array.from(quoteElements).map(e => e.value);
        var isCheckUpdate = valueArray.every(item => item == '');

        if (isCheckUpdate) {
            Swal.fire(
                {
                    title: "Don't let all your feel go empty",
                    confirmButtonClass: 'btn btn-primary w-xs mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
        } else {
            var data = {
                id: id,
                quote: valueArray.join('---')

            };

            showAlertLoading();
            callAjaxByJsonWithData('/api/v1/feeling-of-book', 'PUT', data, function () {
                sessionStorage.setItem('result', 'updateSuccess');
                location.reload();
            });
        }
    });

    $('#submit').click(function () {
        var bookId = '${bookDetail.book.id}';
        var quoteElements = document.querySelectorAll('form .quote');
        var valueArray = Array.from(quoteElements).map(e => e.value);
        var isCheckUpdate = valueArray.every(item => item == '');

        if (isCheckUpdate) {
            Swal.fire(
                {
                    title: 'You must write a Feel!',
                    confirmButtonClass: 'btn btn-primary w-xs mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
        } else {
            var data = {
                userId: userCurrent.id,
                quote: valueArray.join('---'),
                bookId: bookId
            };

            showAlertLoading();
            callAjaxByJsonWithData('/api/v1/feeling-of-book', 'POST', data, function () {
                sessionStorage.setItem('result', 'addSuccess');
                location.reload();
            });
        }
    })

    $('#delete-btn').click(function () {
        Swal.fire({
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
            cancelButtonClass: 'btn btn-danger w-xs mt-2',
            confirmButtonText: "Yes, delete it!",
            buttonsStyling: false,
            showCloseButton: true
        }).then(function (result) {
            if (result.value) {
                showAlertLoading();
                var bookId = '${bookDetail.book.id}';
                var userId = userCurrent.id;
                callAjaxByJsonWithData("/api/v1/feeling-of-book?userId=" + userId + "&bookId=" + bookId, "DELETE", null, function (rs) {
                    sessionStorage.setItem('result', 'delSuccess');
                    location.reload();
                });
            }
        });
    });
</script>

<%--Notification--%>
<script>
    $(document).ready(function () {
        var result = sessionStorage.getItem('result');
        var title;
        switch (result) {
            case 'addSuccess':
                title = 'Add Success!'
                break;
            case 'updateSuccess':
                title = 'Update Success!'
                break;
            case 'delSuccess':
                title = 'Delete Success!'
                break;
        }
        if (result) {
            Swal.fire(
                {
                    title: title,
                    icon: 'success',
                    showCancelButton: true,
                    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                    cancelButtonClass: 'btn btn-danger w-xs mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
            sessionStorage.clear();
        }
    });
</script>
</body>
</html>