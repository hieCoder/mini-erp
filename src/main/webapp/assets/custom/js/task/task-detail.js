const S_TASK_COMMENT = 'TASK_COMMENT';

function getPriorityColor(code){
    var colorClass = '';
    switch (code) {
        case 'LOW':
            colorClass = 'bg-success';
            break;
        case 'MEDIUM':
            colorClass = 'bg-warning';
            break;
        case 'HIGH':
            colorClass = 'bg-danger';
            break;
        default:
            colorClass = '';
            break;
    }
    return colorClass;
}

function getStatusColor(code){
    var colorClass = '';
    switch (code) {
        case 'REGISTERED':
            colorClass = 'badge-soft-secondary';
            break;
        case 'OPENED':
            colorClass = 'badge-soft-warning';
            break;
        case 'POSTPONED':
            colorClass = 'badge-soft-danger';
            break;
        case 'REOPENED':
            colorClass = 'badge-soft-info';
            break;
        case 'CLOSED':
            colorClass = 'badge-soft-success';
            break;
        default:
            colorClass = '';
            break;
    }
    return colorClass;
}

function getProgressE(progress){
    return `<div class="progress">
                            <div class="progress-bar bg-success" role="progressbar" style="width:` + progress
        +`%" aria-valuenow="` + progress +`" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>`
}

async function createCommentForm(comment) {

    var id = comment.id;
    var parentId = comment.parentId;
    var idUser = comment.idUser;
    var filesComment = comment.files;
    var childComments = comment.childComments;
    var avatarUser = comment.avatarUser;
    var fullnameUser = comment.fullnameUser;
    var createdDate = comment.createdDate;
    var title = comment.title;
    var content = comment.content;

    return new Promise(async (resolve, reject) => {

        // btn reply, group edit & delete btn
        var btnReply = ``, groupEditAndDeleteBtn = ``;
        if (parentId == null && !isDeleveloper()) {
            btnReply = `<a href="javascript: void(0);" class="badge text-muted bg-light btn-reply" data-id="`+id+`" style="margin-right: 3px; font-size: 10px;"><i class="mdi mdi-reply"></i> Reply</a>`;
        }
        if (isAdminOrUserLogin(idUser)) {
            groupEditAndDeleteBtn = `<a style="font-size: 10px;" href="javascript: void(0);" data-id="`+ id + `" class="badge text-muted bg-light btn-edit"><i class="mdi mdi-edit"></i> Edit</a>
                    <a style="font-size: 10px;" href="#deleteCommentModal" data-bs-toggle="modal" data-id="`+ id +`" class="badge text-muted bg-light remove-comment-btn"><i class="mdi mdi-delete"></i> Delete</a>`;
        }

        // files
        var files = ``;
        if (filesComment && filesComment.length > 0) {
            try {
                await handleFilesAsync(filesComment, function (fileName, fileSize, url) {
                    files += createFile({ fileName: fileName, fileSize: fileSize, url: url });
                });
            } catch (error) {
                console.error(error);
            }
        }

        // childComments
        var listChildComment = $('<div>');
        if (childComments && childComments.length > 0) {
            const childCommentsHTML = [];
            for (const childComment of childComments) {
                const cc = await createCommentForm(childComment);
                listChildComment.append(cc);
                childCommentsHTML.push(cc);
            }
        }

        const commentHTML = `<div class="d-flex mt-4 comment-container" data-id="`+ id +`">
                                        <div class="flex-shrink-0">
                                            <img src="` + avatarUser + `" alt="" class="avatar-xs rounded-circle" />
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h5 class="fs-13"><a href="pages-profile.html">` + fullnameUser + `</a> <small class="text-muted">` + createdDate + `</small></h5>
                                            <p class="mb-2">` + title + `</p>
                                            <div class="text-muted mb-1">` + getContentViewOfEditorSnow(content) + `</div>`
            + `<div class="row mb-1">` + files + `</div>`
            + btnReply + groupEditAndDeleteBtn +
            `<div class="form-reply mt-3" data-id="`+id+`"></div>` +
            `<div class="form-edit mt-3" data-id="`+id+`"></div>`+ listChildComment.html() + `
                                        </div>
                                    </div>`;
        resolve(commentHTML);
    });
}

function resetFormPostComment(){
    $('.post-comment-form .title-post-comment').val('');
    $('.ql-toolbar.ql-snow').remove();
    $('.post-comment-form .content-post-comment').replaceWith('<div class="content-post-comment snow-editor h-auto"></div>');
    activeEditor('.post-comment-form');

    $('.post-comment-form .attach-file-container').replaceWith(`<div class="card-body attach-file-container">
                                            <div class="dropzone">
                                                <div class="fallback">
                                                    <input name="fileList" type="file" multiple="multiple">
                                                </div>
                                                <div class="dz-message needsclick">
                                                    <div class="mb-3">
                                                        <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                                    </div>
                                                    <h4>Drop files here or click to upload.</h4>
                                                </div>
                                            </div>
                                            <ul class="list-unstyled mb-0" id="dropzone-preview">
                                                <li class="mt-2" id="dropzone-preview-list">
                                                    <div class="border rounded">
                                                        <div class="d-flex p-2">
                                                            <div class="flex-shrink-0 me-3">
                                                                <div class="avatar-sm bg-light rounded">
                                                                    <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                        <i class="ri-file-upload-line"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <div class="pt-1">
                                                                    <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                                    <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                                    <strong class="error text-danger" data-dz-errormessage></strong>
                                                                </div>
                                                            </div>
                                                            <div class="flex-shrink-0 ms-3">
                                                                <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                            <div class="message-error-file"></div>
                                        </div>`);
}

function createFile(file, isShowDeleteIcon) {

    var iconDelete = '';
    if(isShowDeleteIcon){
        iconDelete = `<a class="delete-file" data-name="`+file.fileName+`" href="#deleteFileCommentModal" data-bs-toggle="modal"><i class="ri-delete-bin-fill align-bottom text-muted"></i></a>`;
    }

    return `<div class="col-lg-3 mb-1 file-container-item" data-name="`+file.fileName+`">
                    <div class="border rounded border-dashed p-2">
                        <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar-sm">
                                                        <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                            <i class="ri-folder-zip-line"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <h5 class="fs-13 mb-1"><a href="javascript:void(0);" class="text-body text-truncate d-block file-name-item" title="`+file.fileName+`">`+file.fileName+`</a></h5>
                                                    <div>`+bToKbShow(file.fileSize)+`Kb</div>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="d-flex gap-1 align-items-center">
                                                        <a href="`+ file.url +`" class="btn btn-icon text-muted btn-sm fs-18"><i class="ri-download-2-line"></i></a>`
        + iconDelete +
        `</div>
                                                </div>
                                            </div>
                    </div>
                </div>`;
}

function showReplyCommentForm(id){
    return `<form class="form-control reply-comment-form" data-id="`+id+`">
                <div class="row g-3">
                        <div class="col-lg-12">
                            <div>
                                <label class="form-label">Title</label>
                                <input type="text" name="title" class="title-reply form-control" placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <label class="form-label">Content</label>
                            <div class="content-reply snow-editor h-auto"></div>
                            <small class="form-message"></small>
                        </div>
                        <div class="col-lg-12">
                            <label class="form-label">Attach file</label>
                            <div class="card-body">
                                    <div class="dropzone">
                                        <div class="fallback">
                                            <input name="fileList" type="file" multiple="multiple">
                                        </div>
                                        <div class="dz-message needsclick">
                                            <div class="mb-3">
                                                <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                            </div>
                                            <h4>Drop files here or click to upload.</h4>
                                        </div>
                                    </div>
                                    <ul class="list-unstyled mb-0" id="dropzone-preview">
                                        <li class="mt-2" id="dropzone-preview-list">
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="flex-shrink-0 me-3">
                                                         <div class="avatar-sm bg-light rounded">
                                                            <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                <i class="ri-file-upload-line"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="pt-1">
                                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <div class="message-error-file"></div>
                            </div>
                        </div>
                        <div class="hstack gap-2 justify-content-start">
                            <button type="submit" class="btn btn-success btn-load">
                                <span class="d-flex align-items-center">
                                    <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                    <span class="flex-grow-1">Reply</span>
                                </span>
                            </button>
                            <button type="button" class="btn btn-ligh close-reply-form">Close</button>
                        </div>
                    </div>
            </form>`;
}

async function showEditCommentForm(comment){

    return new Promise(async (resolve, reject) => {

        var id = comment.id;
        var title = comment.title;
        var filesComment = comment.files;

        // files
        var files = ``;
        if (filesComment && filesComment.length > 0) {
            try {
                await handleFilesAsync(filesComment, function (fileName, fileSize, url) {
                    files += createFile({ fileName: fileName, fileSize: fileSize, url: url }, true);
                });
            } catch (error) {
                console.error(error);
            }
        }

        const commentHTML = `<form class="form-control edit-comment-form" data-id="`+id+`">
                <div class="row g-3">
                        <div class="col-lg-12">
                            <div>
                                <label class="form-label">Title</label>
                                <input value="`+title+`" type="text" name="title" class="title-edit form-control" placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <label class="form-label">Content</label>
                            <div class="content-edit snow-editor h-auto"></div>
                            <small class="form-message"></small>
                        </div>
                        <div class="col-lg-12">
                            <label class="form-label">Old files</label>
                            <div class="row mb-1">`
            + files +
            `</div>
                        <div class="col-lg-12">
                            <label class="form-label">Attach file</label>
                            <div class="card-body">
                                    <div class="dropzone">
                                        <div class="fallback">
                                            <input name="fileList" type="file" multiple="multiple">
                                        </div>
                                        <div class="dz-message needsclick">
                                            <div class="mb-3">
                                                <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                            </div>
                                            <h4>Drop files here or click to upload.</h4>
                                        </div>
                                    </div>
                                    <ul class="list-unstyled mb-0" id="dropzone-preview">
                                        <li class="mt-2" id="dropzone-preview-list">
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="flex-shrink-0 me-3">
                                                         <div class="avatar-sm bg-light rounded">
                                                            <div class="avatar-title bg-light text-secondary rounded fs-24">
                                                                <i class="ri-file-upload-line"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="pt-1">
                                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <div class="message-error-file"></div>
                            </div>
                        </div>
                        <div class="hstack gap-2 justify-content-start">
                            <button type="submit" class="btn btn-success btn-load">
                                <span class="d-flex align-items-center">
                                    <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                    <span class="flex-grow-1">Edit</span>
                                </span>
                            </button>
                            <button type="button" class="btn btn-ligh close-edit-form">Close</button>
                        </div>
                    </div>
            </form>`;
        resolve(commentHTML);
    });
}