<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book detail</title>
    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
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

                            <%--                            <div class="text-center loading-feeling">--%>
                            <%--                                <div class="spinner-border text-primary" role="status">--%>
                            <%--                                    <span class="sr-only">Loading...</span>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                            <form class="feeling" id="feelingBook">
                                <div class="accordion custom-accordionwithicon custom-accordion-border accordion-border-box accordion-secondary"
                                     id="accordionWithicon">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
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
                                            <textarea class="form-control data" name="feeling"
                                                      id="feelingArea"></textarea>
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
                                            <textarea class="form-control data" name="lesson"
                                                      id="lessonArea"></textarea>
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
                                            <textarea class="form-control data" name="quote" id="quoteArea"></textarea>
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
                                            <textarea class="form-control data" name="action"
                                                      id="actionArea"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <button type="submit" class="btn btn-primary" id="submit" disabled>
                                        Submit
                                    </button>
                                    <button type="submit" class="btn btn-primary d-none"
                                            id="update">
                                        Update
                                    </button>
                                    <button type="button" class="btn btn-danger d-none" data-toggle="modal"
                                            data-target="#deleteFeelingModal" id="delete">Delete
                                    </button>
                                    <button type="button" class="btn btn-secondary"><a href="/books" class="text-white">Back</a>
                                    </button>
                                </div>
                            </form>

                        </div>
                        <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                        <div class="col-md-12">
                            <div data-simplebar style="max-height: 350px">
                                <%--                                <div class="text-center loading-feeling">--%>
                                <%--                                    <div class="spinner-border text-primary" role="status">--%>
                                <%--                                        <span class="sr-only">Loading...</span>--%>
                                <%--                                    </div>--%>
                                <%--                                </div>--%>
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
                                <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}" varStatus="loopStatus">
                                    <div class="list-group mt-2">
                                        <div class="list-group-item">
                                            <div class="card">
                                                <div class="card-header align-items-center d-flex p-0">
                                                    <div class="flex-grow-1 oveflow-hidden">
                                                        <div class="d-flex mb-2 align-items-center">
                                                            <div class="flex-shrink-0">
                                                                <img src="${feeling.avatarUser}" alt=""
                                                                     class="avatar-sm rounded-circle"/>
                                                            </div>
                                                            <div class="flex-grow-1 ms-3">
                                                                <h5 class="list-title fs-15 mb-1">${feeling.fullnameUser}</h5>
                                                                <p class="list-text mb-0 fs-12">${feeling.createdDate}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <ul class="nav justify-content-end nav-tabs-custom rounded card-header-tabs border-bottom-0"
                                                            role="tablist">
                                                            <li class="nav-item">
                                                                <a class="nav-link active d-flex align-items-center"
                                                                   data-bs-toggle="tab"
                                                                   href="#feeling-${loopStatus.index}" role="tab">
                                                                    Feeling<i
                                                                        class="ri-message-2-line me-2 fs-5 ms-2"></i>
                                                                </a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link d-flex align-items-center"
                                                                   data-bs-toggle="tab"
                                                                   href="#lesson-${loopStatus.index}" role="tab">
                                                                    Lesson<i
                                                                        class="ri-pencil-ruler-line me-2 fs-5 ms-2"></i>
                                                                </a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link d-flex align-items-center"
                                                                   data-bs-toggle="tab"
                                                                   href="#quote-${loopStatus.index}" role="tab">
                                                                    Quotes<i
                                                                        class="ri-double-quotes-l me-2 fs-5 ms-2"></i>
                                                                </a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link d-flex align-items-center"
                                                                   data-bs-toggle="tab"
                                                                   href="#action-${loopStatus.index}" role="tab">
                                                                    Action<i
                                                                        class="ri-user-location-line me-2 fs-5 ms-2"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="tab-content">
                                                        <div class="tab-pane active" id="feeling-${loopStatus.index}"
                                                             role="tabpanel">
                                                            <p class="ms-3 mb-0">
                                                                    ${feeling.feeling}
                                                            </p>
                                                        </div>
                                                        <div class="tab-pane" id="lesson-${loopStatus.index}"
                                                             role="tabpanel">
                                                            <p class="ms-3 mb-0">
                                                                    ${feeling.lesson}
                                                            </p>
                                                        </div>
                                                        <div class="tab-pane" id="quote-${loopStatus.index}"
                                                             role="tabpanel">
                                                            <p class="ms-3 mb-0">
                                                                    ${feeling.quote}
                                                            </p>
                                                        </div>
                                                        <div class="tab-pane" id="action-${loopStatus.index}"
                                                             role="tabpanel">
                                                            <p class="ms-3 mb-0">
                                                                    ${feeling.action}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
    <!--end col-->
</div>
<!--end row-->

<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
    // Loading Primary
    function addLoadingPrimary(element) {
        element.classList.add("btn-load");
        var content = element.textContent;
        element.innerHTML = `
            <span class="d-flex align-items-center">
                <span class="spinner-border flex-shrink-0" role="status">
                    <span class="visually-hidden">Loading...</span>
                </span>
                <span class="flex-grow-1 ms-2 loading-primary">

                </span>
            </span>
        `;

        document.querySelector('.loading-primary').textContent = content;
    }

    $(document).ready(function () {
        var feeling = document.getElementById('feelingArea');
        var lesson = document.getElementById('lessonArea');
        var quote = document.getElementById('quoteArea');
        var action = document.getElementById('actionArea');
        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + '${bookDetail.book.id}' + '/' + userCurrent.id, 'GET', null, function (rs) {
            feeling.value = rs.feeling;
            lesson.value = rs.lesson;
            quote.value = rs.quote;
            action.value = rs.action;

            $('#submit').addClass('d-none');
            $('#update').removeClass('d-none');
            $('#delete').removeClass('d-none');

            // Update Feeling
            Validator({
                form: '#feelingBook',
                errorSelector: '.form-message',
                rules: [],
                onSubmit: function (formData) {
                    addLoadingPrimary(document.getElementById('update'));
                    $('.btn').attr('disabled', true);

                    formData.append('id', rs.id);
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'PUT', formData, function (rs) {
                        sessionStorage.setItem('result', 'updateSuccess');
                        location.reload();
                    });
                }
            });

            // Delete Feeling
            $('#delete').click(function () {
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
        }, function (rs) {
            $('#submit').removeClass('d-none');
            $('#update').addClass('d-none');

            var textarea = document.querySelectorAll('.data');
            textarea.forEach(function (input) {
                input.addEventListener('input', function () {
                    if (input.value.trim() !== '') {
                        document.getElementById('submit').removeAttribute('disabled');
                    } else document.getElementById('submit').setAttribute('disabled', 'disabled');
                })
            })

            Validator({
                form: '#feelingBook',
                errorSelector: '.form-message',
                rules: [],
                onSubmit: function (formData) {
                    addLoadingPrimary(document.getElementById('submit'));
                    $('.btn').attr('disabled', true);

                    formData.append('userId', userCurrent.id);
                    formData.append('bookId', '${bookDetail.book.id}');
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'POST', formData, function (rs) {
                        sessionStorage.setItem('result', 'addSuccess');
                        location.reload();
                    });
                }
            });
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