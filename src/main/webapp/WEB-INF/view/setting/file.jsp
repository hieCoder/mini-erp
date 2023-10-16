<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>Setting file</h1>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table id="datatable-setting-file" class="table">
                            <thead>
                                <tr>
                                    <th>Component</th>
                                    <th>Image type</th>
                                    <th>File type</th>
                                    <th>File size</th>
                                </tr>
                            </thead>
                        </table>
                        <div class="mt-2 text-right">
                            <button type="button" class="btn btn-primary">Update</button>
                            <button type="button" class="btn btn-secondary">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function (){

        table = $('#datatable-setting-file').DataTable({
            ajax: {
                url: '/api/v1/settings',
                method: 'GET',
                dataSrc: ''
            },
            columns: [
                { data: 'code.name' },
                {
                    data: 'imageType',
                    render: function(data, type, row) {
                        return '<input type="text" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileType',
                    render: function(data, type, row) {
                        return '<input type="text" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileSize',
                    render: function(data, type, row) {
                        return '<input type="number" value="' + data + '"/>';
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });
    });
</script>
</body>
</html>
