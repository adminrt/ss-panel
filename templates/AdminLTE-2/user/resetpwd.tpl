<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><{$site_name}></title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="<{$resources_dir}>/asset/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="<{$resources_dir}>/asset/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="<{$resources_dir}>/asset/css/blue.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="../"><b><{$site_name}></b></a>
    </div><!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">重置密码</p>

            <input type="hidden" id="code" name="code" class="form-control" value="<{$code|default:""}>" required >
            <input type="hidden" id="uid" name="uid" class="form-control" value="<{$uid|default:""}>" required >
            
            <div class="form-group has-feedback">
                <input id="email" name="email" type="text" class="form-control" autofocus="autofocus" placeholder="邮箱"/>
                <span  class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>

            <div class="form-group has-feedback">
                <button type="submit" id="reset" class="btn btn-primary btn-block btn-flat">重置</button>
            </div>
    
            <div id="msg-success" class="alert alert-info alert-dismissable" style="border: 1px solid rgb(50, 163, 213); text-align: center; z-index: 999; width: 300px; left: 50%; margin-left: -150px !important; margin-top: -60px !important; position: fixed !important; display: none;">
                <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> 成功!</h4>
                <p id="msg-success-p"></p>
            </div>
    
            <div id="msg-error" class="alert alert-danger" title="点击关闭" style="border: 1px solid rgb(255, 0, 0); text-align: center; z-index: 999; width: 300px; left: 50%; margin-left: -150px !important; margin-top: -60px !important; position: fixed !important; display: none;">
                <button type="button" class="close" id="error-close" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-warning"></i> 出错了!</h4>
                <p id="msg-error-p"></p>
            </div>

        <a href="login.php" class="text-center">返回登录</a>

    </div><!-- /.login-box-body -->
</div><!-- /.login-box -->

<!-- jQuery 2.1.3 -->
<script src="<{$resources_dir}>/asset/js/jQuery.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="<{$resources_dir}>/asset/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="<{$resources_dir}>/asset/js/icheck.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
    // $("#msg-error").hide();
    // $("#msg-success").hide();
</script>

<script>
    $(document).ready(function(){
          function reset(){
               $.ajax({
                type:"GET",
                url:"_resetpwd.php?username="+$("#username").val()+"&email="+$("#email").val(),
                dataType:"json",
                success:function(data){
                    if(data.ok){
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='index.php'", 2000);
                    }else{
                        $("#msg-error").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            });
            
            inpemail=$("#email").val();
        }
        function resetcheck(){
                    var msg_id=0;
                    if($("#email").val().length==0){
                        id_name="#email";
                        msg_out("请输入邮箱","error");
                        msg_id=1;
                        return false;
                    }
                    var email_reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
                    if(!email_reg.test($("#email").val())) {
                        id_name="#email";
                        msg_out("请输入有效的邮箱！","error");
                        msg_id=1;
                        return false;
                    }
                    if($("#msg-success-p").eq(0)[0].innerHTML=="已经发送到邮箱"){
                            msg_out("已经发送到邮箱","success");
                            msg_id=1;
                            $("#msg-error-p").html(null);
                     }
                    if($("#msg-error-p").eq(0)[0].innerHTML=="邮箱不存在" 
                    || $("#msg-error-p").eq(0)[0].innerHTML=="邮箱不存在，请重新输入！"){
                         if($("#email").val()==inpemail){
                            id_name="#email";
                            msg_out("邮箱不存在，请重新输入！","error");
                            msg_id=1;
                            return false;
                            }
                    }
                    if(msg_id==0){ 
                            reset();
                    }
        }
        function msg_out(msgout,msgcss){
                    $("#msg-"+msgcss).hide(10);
                    $("#msg-"+msgcss).show(100);
                    $("#msg-"+msgcss+"-p").html(msgout);
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                resetcheck();
            }
            if(event.keyCode==27){
                error_close();
            }
        });
        $("#reset").click(function(){
            resetcheck();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#msg-error").click(function(){
            error_close();
        });
        function error_close(){
            if($("#msg-error").css('display')=="block"){
                $("#msg-error").hide(100);
                $(id_name).focus();
                if(id_name=="#email"){
                    $(id_name).select();
                }
            }
        }
    })
</script>

</body>
</html>