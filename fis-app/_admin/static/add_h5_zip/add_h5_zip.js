$(function(){

    var url = $("#url");
    var filecount = $("#filecount");
    var btnOK = $(".btn-ok");

    var uploader = WebUploader.create({
        // swf文件路径
        swf: "./Uploader.swf",
        // 文件接收服务端。
        server: './offlinePackageUpload',
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker',
        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false
    });

    // 当有文件被添加进队列的时候
    uploader.on( 'fileQueued', function( file ) {
        $("#thelist").append( '<div id="' + file.id + '" class="item">' +
            '<h4 class="info">' + file.name + '</h4>' +
            '<p class="state">等待上传...</p>' +
        '</div>' );
    });

    // 文件上传过程中创建进度条实时显示。
    uploader.on( 'uploadProgress', function( file, percentage ) {
        var $li = $("#thelist"),
            $percent = $li.find('.progress .progress-bar');

        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<div class="progress progress-striped active">' +
              '<div class="progress-bar" role="progressbar" style="width: 0%">' +
              '</div>' +
            '</div>').appendTo( $li ).find('.progress-bar');
        }

        $li.find('p.state').text('上传中');

        $percent.css( 'width', percentage * 100 + '%' );
    });

    uploader.on( 'uploadSuccess', function(file, response) {
        $("#thelist").find('p.state').text('已上传');
        if(response.code == 200){
            url.val(response.url);
            filecount.val(response.filecount);
        }else if(response.code == 404){
            alert(response.msg);
        }
    });

    uploader.on( 'uploadError', function() {
        $("#thelist").find('p.state').text('上传出错');
    });

    uploader.on( 'uploadComplete', function() {
        $("#thelist").find('.progress').fadeOut();
    });

    var state = 'pending';

    var btn = $("#ctlBtn");

    uploader.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state = 'done';
        }

        if ( state === 'uploading' ) {
            btn.text('暂停上传');
        } else {
            btn.text('开始上传');
        }
    });

    btn.on( 'click', function() {
        if ( state === 'uploading' ) {
            uploader.stop();
        } else {
            uploader.upload();
        }
    });


    var oTab = $("#J-tab");
    var oModule = $("#module");
    oTab.find("li").eq(GetQueryString("module")).addClass("active");
    oModule.val(GetQueryString("module"));
    oTab.find("li").on("click", function(){
        location.href = location.origin + location.pathname + "?module=" + $(this).index();
    });

    btnOK.on("click", function(){
        ajaxUpdate($(this).data("id"), $(this).data("version"), $(this).data("status"), oModule.val());
    });

    $(".btn-status").on("click", function(){
        if($(this).data("status") == "0" || $(this).data("status") == "1"){
            ajaxUpdate($(this).data("id"), $(this).data("version"), $(this).data("status"), oModule.val());
        }else{
            btnOK.data("id", $(this).data("id"));
            btnOK.data("version", $(this).data("version"));
            btnOK.data("status", $(this).data("status"));
            btnOK.data("module", oModule.val());
        }
    });

    // 获取URL参数
    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null) return unescape(r[2]); return null;
    }

    function ajaxUpdate(id, version, status, module){
        $.ajax({
            "url": "./updateOfflinePackageStatus",
            "type": "POST",
            "dataType": "json",
            "data": {
                "id": id,
                "version": version,
                "module": module,
                "status": status
            },
            "success": function(data){
                if(data.code == "200"){
                    if(status == "0" || status == "1"){
                        alert("操作成功！");
                    }
                    location.reload();
                }
            }
        });
    }
});
