function createStaffE(staff){
    return `<div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex">
                                        <div class="flex-grow-1"><i
                                                class="mdi mdi-checkbox-blank-circle me-2 text-info"></i>
                                                <a data-id="`+staff.id+`" href="#" class="fw-medium staff-name">`+staff.fullname+`</a></div>
                                    </div>
                                    <p class="text-muted text-truncate-two-lines mb-0"></p></div>
                            </div>`;
}

function getApiUrl(userRole, userId, page, pageSize) {
    return '/api/v1/weekly-reports?userRole='+ userRole+'&userId='+userId+'&page='+page+'&pageSize='+page;
}