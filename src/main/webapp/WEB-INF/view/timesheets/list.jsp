<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Timesheets</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>Timesheets</h1>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table id="datatable" class="table">
                            <thead>
                            <tr>
                                <th>Work date</th>
                                <th>Username</th>
                                <th>Checkin</th>
                                <th>Checkout</th>
                                <th>Total office hours</th>
                                <th>Register OT</th>
                                <th>OT hours</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function (){
        table = $('#datatable').DataTable({
            ajax: {
                url: '/api/v1/timesheets',
                contentType: 'application/json',
                method: 'GET',
                dataSrc: ''
            },
            columns: [
                {data: 'workDate'},
                {data: 'fullnameUser'},
                {data: 'checkin'},
                {data: 'checkout'},
                {data: 'totalOfficeHours'},
                {
                    data: 'ot',
                    render: function(data, type, row) {
                        var checkbox = '<input type="checkbox" ' + (data == true ? 'checked' : '') + '/>';
                        console.log(checkbox);
                        return checkbox;
                    }
                },
                {data: 'otHours'}
            ],
            ordering: false,
            info: false
        });
    });
</script>
</body>
</html>
