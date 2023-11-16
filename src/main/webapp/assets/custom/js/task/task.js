const T_ALL = '';
const T_CLOSED = 'CLOSED';
const T_REGISTERED = 'REGISTERED';
const T_OPENED = 'OPENED';
const T_POSTPONED = 'POSTPONED';
const T_REOPENED = 'REOPENED';

function getTaskCountByCode(rs, code) {
    for (let i = 0; i < rs.length; i++) {
        if (rs[i].statusTask.code === code) {
            return rs[i].taskCount;
        }
    }
    return 0;
}

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

function loadCountStatus(){
    return new Promise(function (resolve, reject) {
        callAjaxByJsonWithData('/api/v1/tasks/status-task-count', 'GET', null, function (rs) {
            $(".counter-total-task").text(getTaskCountByCode(rs, T_ALL));
            $(".counter-closed-task").text(getTaskCountByCode(rs, T_CLOSED));
            $(".counter-postponed-task").text(getTaskCountByCode(rs, T_POSTPONED));
            $(".counter-opened-task").text(getTaskCountByCode(rs, T_OPENED));
            $(".counter-registered-task").text(getTaskCountByCode(rs, T_REGISTERED));
            $(".counter-reopend-task").text(getTaskCountByCode(rs, T_REOPENED));
            resolve(rs);
        }, function (error) {
            reject(error);
        });
    });
}