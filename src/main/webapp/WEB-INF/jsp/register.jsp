<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>注册用户</title>
    <link rel="stylesheet" href="../static/layui/css/layui.css">
    <style>
        .layui-form{
            position: absolute;/*绝对定位*/
            width: 400px;
            height: 300px;
            text-align: center;/*(让div中的内容居中)*/
            top: 50%;
            left: 50%;
            margin-top: -200px;
            margin-left: -150px;
        }
        body {
            background: url(../static/background/2.jpg);
        }
    </style>
</head>
<script type="text/javascript">
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
</script>
<body>
<!-- 你的HTML代码 -->
<form class="layui-form" action="../user/register" id="form1" method="post" onsubmit="return check();">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" id="userUsername" name="userUsername" required  lay-verify="required" placeholder="4-13位字符" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码框</label>
        <div class="layui-input-inline">
            <input type="password" id="userPassword" name="userPassword" required lay-verify="required" placeholder="4-13位字符" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-inline">
            <input type="password" id="confirmPassword" name="confirmPassword" required lay-verify="required" placeholder="重复密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份</label>
        <div class="layui-input-block">
            <select name="userIdentity">
                <option value="0" selected="selected">顾客</option>
                <option value="1">店家</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">年龄</label>
        <div class="layui-input-block">
            <input type="text" name="userAge" id="userAge" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="userName" id="userName" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机</label>
        <div class="layui-input-block">
            <input type="text" name="userPhone" id="userPhone" required  lay-verify="required"  autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block">
            <input type="text" name="userAddress" id="userAddress" required  lay-verify="required"  autocomplete="off" class="layui-input" placeholder="模板：泉州市">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="userSex"  value="男" title="男">
            <input type="radio" name="userSex"  value="女" title="女" checked>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">验证码</label>
        <div class="layui-input-block">
            <input type="text" name="j_captcha" id="j_captcha" required  lay-verify="required"  autocomplete="off" class="layui-input" placeholder="请输入验证码">
            <img id="captcha_img" alt="点击更换" title="点击更换"
                 onclick="changeVerifyCode(this)" src="../getKaptchaImage" />
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">注册</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            <a href="../user/tologin" class="layui-btn layui-btn-warm">返回登录</a>
        </div>
    </div>
</form>
<script src="../static/layui/layui.js"></script>
<script>
    //一般直接写在一个js文件中
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
    });
    function checkusername() {
        var username=document.getElementById("userUsername").value.trim();
        if(username.length<4||username.length>13){
            alert("用户名不符合要求！请重新输入！");
            document.getElementById("userUsername").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkpassword() {
        var password=document.getElementById("userPassword").value.trim();
        var pwd=document.getElementById("confirmPassword").value.trim();
        if(password.length<4||password.length>13){
            alert("密码不符合要求！请重新输入！");
            document.getElementById("userPassword").focus();
            return false;
        }
        else if(pwd!=password){
            alert("确认密码输入不一致！请重新输入！");
            document.getElementById("userPassword").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkPhone() {
        var phone=document.getElementById("userPhone").value.trim();
        if(!(/^1[34578]\d{9}$/.test(phone))){
            alert("手机号码有误，请重填");
            document.getElementById("userPhone").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkAge() {
        var result=document.getElementById("userAge").value.trim();
        var age=parseInt(result);
        if(age<1||age>120){
            alert("请输入正常的年龄！");
            document.getElementById("userAge").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function check() {
        if(checkusername()&&checkpassword()&&checkPhone()&&checkAge()){
            return true;
        }
        else {
            return false;
        }
    }
    function changeVerifyCode(img) {
        img.src = "../getKaptchaImage?"+Math.floor(Math.random() * 100);
    }
    

</script>
</body>
</html>


