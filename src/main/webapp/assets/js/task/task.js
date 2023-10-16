function getPriorityColor(code){
    var colorClass = '';
    switch (code) {
        case 'LOW':
            colorClass = 'bg-warning';
            break;
        case 'MEDIUM':
            colorClass = 'bg-primary';
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
            colorClass = 'bg-secondary';
            break;
        case 'OPENED':
            colorClass = 'bg-warning';
            break;
        case 'POSTPONSED':
            colorClass = 'bg-danger';
            break;
        case 'REOPENED':
            colorClass = 'bg-info';
            break;
        case 'CLOSED':
            colorClass = 'bg-success';
            break;
        default:
            colorClass = '';
            break;
    }
    return colorClass;
}