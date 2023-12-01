function resetFormFeeling(idForm){
    $('#' + idForm + ' textarea').val('');
}

function createComment(comment) {
    return `<div class="d-flex mt-3 comment-container" data-id="`+comment.id+`">
                                            <div class="flex-shrink-0">
                                                <img src="`+comment.user.avatar+`" alt="" class="avatar-xs rounded-circle">
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h5 class="fs-13"><a>`+comment.user.fullname+`</a> <small class="text-muted">`+comment.createdDate+`</small></h5>
                                                <p class="mb-2 content-comment" data-id="`+comment.id+`">`+comment.content+`</p>
<!--                                                <a href="javascript: void(0);" class="badge text-muted bg-light btn-reply" data-id="" style="margin-right: 3px; font-size: 10px;"><i class="mdi mdi-reply"></i> Reply</a>-->
                                                <a style="font-size: 11px;" href="javascript: void(0);" data-id="`+comment.id+`" class="badge text-muted bg-light btn-edit"><i class="mdi mdi-edit"></i> Edit</a>
                                                <a style="font-size: 11px;" href="#deleteCommentModal" data-bs-toggle="modal" data-id="`+comment.id+`" class="badge text-muted bg-light remove-comment-btn"><i class="mdi mdi-delete"></i> Delete</a>
<!--                                                <div class="form-reply mt-3" data-id=""></div>-->
                                                <div class="form-edit mt-3" data-id="`+comment.id+`"></div>
                                            </div>
                                        </div>`;
}

function createFeeling(feeling) {
    var comments = '';
    feeling.comments.forEach((comment) => {
        comments += createComment(comment);
    });
    return `<div class="card border">
                                    <div class="card-header align-items-center d-flex p-0">
                                        <div class="flex-grow-1 oveflow-hidden m-2">
                                            <div class="d-flex mb-2 align-items-center">
                                                <div class="flex-shrink-0">
                                                    <img src="`+ feeling.user.avatar + `" alt=""
                                                         class="avatar-sm rounded-circle"/>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h5 class="list-title fs-15 mb-1">`+ feeling.user.fullname + `</h5>
                                                    <p class="list-text mb-0 fs-12">`+ feeling.createdDate + `</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group mt-3">
                                                    <div class="row align-items-center">
                                                        <div class="col-auto pe-0"><i class="ri-message-2-line fs-4"></i></div>
                                                        <div class="col ps-2 fs-5">Feel about the book:</div>
                                                    </div>
                                                    <div class="p-2">`+feeling.feeling+`</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group mt-3">
                                                    <div class="row align-items-center">
                                                        <div class="col-auto pe-0"><i class="ri-pencil-ruler-line fs-4"> </i></div>
                                                        <div class="col ps-2 fs-5">Lessons Learned:</div>
                                                    </div>
                                                    <div class="p-2">`+feeling.lesson+`</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group mt-3">
                                                    <div class="row align-items-center">
                                                        <div class="col-auto pe-0"><i class="ri-double-quotes-l fs-4"></i></div>
                                                        <div class="col ps-2 fs-5">Quotes:</div>
                                                    </div>
                                                    <div class="p-2">`+feeling.quote+`</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group mt-3">
                                                    <div class="row align-items-center">
                                                        <div class="col-auto pe-0"><i class="ri-user-location-line fs-4"></i></div>
                                                        <div class="col ps-2 fs-5">Action:</div>
                                                    </div>
                                                    <div class="p-2">`+feeling.action+`</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <div class="create-comment">
                                            <form data-id="`+feeling.id +`">
                                                <div class="form-group d-flex">
                                                    <input type="text" name="content" class="content-comment form-control" placeholder="Your comment" required>
                                                    <button data-id="`+feeling.id +`" type="button" class="btn-create-comment btn btn-success btn-load ms-1">
                                                        <span class="d-flex align-items-center">
                                                            <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                                            <span class="flex-grow-1">Comment</span>
                                                        </span>
                                                    </button>
                                                </div>
                                                <div class="ms-1 pt-1 message-validate-cmt"></div>
                                            </form>
                                        </div>
                                        <div class="comment-list" data-id="`+feeling.id+`">`+ comments +`</div>
                                    </div>
                                </div>`;
}

function resetFormComment(formElememt) {
    $(formElememt).find('.content-comment').val('');
    $(formElememt).find('.message-validate-cmt').text('');
}

function showFormEditComment(comment) {
    return `<form class="edit-comment-form" data-id="` + comment.id +`">
                                                        <div class="form-group d-flex">
                                                            <input type="text" name="content" value="`+comment.content+`" class="content-comment form-control" placeholder="Your comment" required>
                                                            <button data-id="` + comment.id +`" type="button" class="btn-edit-comment btn btn-success btn-load ms-1">
                                                                <span class="d-flex align-items-center">
                                                                    <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                                                    <span class="flex-grow-1">Edit</span>
                                                                </span>
                                                            </button>
                                                            <button data-id="` + comment.id +`" class="ms-1 btn btn-light btn-cancel">Cancel</button>
                                                        </div>
                                                        <div class="ms-1 pt-1 message-validate-cmt"></div>
                                                    </form>`;
}