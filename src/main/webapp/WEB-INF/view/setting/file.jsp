<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Settings</title>
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
                                <b class="message-noti mr-2"></b>
                                <button id="update-button" type="button" class="btn btn-primary">Update</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var object = [];

    var table;
    $(document).ready(function (){

        table = $('#datatable-setting-file').DataTable({
            ajax: {
                url: '/api/v1/settings',
                method: 'GET',
                dataSrc: ''
            },
            columns: [
                {
                    data: 'code',
                    render: function(data, type, row) {
                        return '<p data-code="' + row.code.code + '">' + data.name +'</p>';
                    }
                },
                {
                    data: 'imageType',
                    render: function(data, type, row) {
                        return '<input name="imageType" type="text" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileType',
                    render: function(data, type, row) {
                        return '<input name="fileType" type="text" value="' + data + '"/>';
                    }
                },
                {
                    data: 'fileSize',
                    render: function(data, type, row) {
                        return '<input name="fileSize" type="number" value="' + data + '"/>';
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });

        $('#update-button').on('click', function () {
            object = [];

            var isValidate = true;

            $('#datatable-setting-file tbody tr').each(function () {

                if (!isValidate) {
                    return false;
                }

                var code = $(this).find('p').data('code');
                var imageType = $(this).find('input[name="imageType"]').val();
                var fileType = $(this).find('input[name="fileType"]').val();
                var fileSize = $(this).find('input[name="fileSize"]').val();

                if(isBlank(imageType) || isBlank(fileType) || isBlank(fileSize)){
                    isValidate = false;
                    $('.message-noti').text('All field is not empty');
                    $('.message-noti').css('color', 'red');
                    object = null;
                } else{
                    var obj = {
                        code: code,
                        imageType: imageType,
                        fileType: fileType,
                        fileSize: fileSize
                    };
                    object.push(obj);
                }
            });

            if(isValidate){

                $('#update-button').after(createLoadingHtml());

                callAjaxByJsonWithData('/api/v1/settings', 'PUT', object, function (rs) {
                    Swal.fire({
                        icon: 'success',
                        text: 'Update success'
                    }, 'setting-file-form');
                });
            }
        });
    });
</script>
</body>
</html>