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
                    <form id="setting-file-form">
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
                        </div>
                    </div>
                    </form>
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
                        return '<div class="form-group"><input id="imageType" name="imageType" type="text" value="' + data + '"/><small class="form-message"></small></div>';
                    }
                },
                {
                    data: 'fileType',
                    render: function(data, type, row) {
                        return '<input name="fileType" type="text" value="' + data + '"/><small class="form-message"></small>';
                    }
                },
                {
                    data: 'fileSize',
                    render: function(data, type, row) {
                        return '<input name="fileSize" type="number" value="' + data + '"/><small class="form-message"></small>';
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        Validator({
            form:'#setting-file-form',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#imageType')
            ],
            onSubmit: function (formData) {

            }
        });
    });
</script>
</body>
</html>
