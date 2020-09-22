<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>订餐系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/jquery.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">订餐系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${user.userName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="../user/info">查看个人信息</a></dd>
                    <dd><a href="../user/toeditinfo">修改个人信息</a></dd>
                    <dd><a href="../user/tochangepassword">修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="../user/logout">退出</a></li>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item"><a href="../user/adminindex">首页</a></li>
                <li class="layui-nav-item"><a href="../shop/tocheck">审批店家</a></li>
                <li class="layui-nav-item"><a href="../shop/adminshops">管理商家信息</a></li>
                <li class="layui-nav-item"><a href="../user/usermgt">管理用户信息</a></li>
                <li class="layui-nav-item"><a href="../category/categorymastermgt">管理店家分类</a></li>
                <li class="layui-nav-item"><a href="../order/ordermgt">订单管理</a></li>
                <li class="layui-nav-item"><a href="../review/reviewmgt">评价管理</a></li>
                <li class="layui-nav-item"><a href="../shop/shopcollectmgt">收藏管理</a></li>
                <li class="layui-nav-item"><a href="../product/zanmgt">点赞管理</a></li>
            </ul>
        </div>
    </div>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 20px">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                管理用户
            </div>
            <form class="layui-form" action="../user/search" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">搜索</label>
                    <div class="layui-input-block">
                        <input type="text" name="keyword" id="keyword" placeholder="用户信息" autocomplete="off" class="layui-input">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">搜索</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
            <button style="margin-top: 10px" class="layui-btn layui-btn-warm" id="add">新增</button>
            <button style="margin-top: 10px" class="layui-btn layui-btn-warm" onclick="databasebackup();">用户数据备份</button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span class="layui-breadcrumb" lay-separator="|">
                 <a href="../user/usermgt">全部</a>
                <a href="../user/userbyiden?identity=0">顾客</a>
                <a href="../user/userbyiden?identity=1">店家</a>
</span>
            <table class="layui-table">
                <colgroup>
                    <col width="200">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>用户名</th>
                    <th>身份</th>
                    <th>地址</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userlist}" var="users">
                <tr>
                    <td>${users.userUsername}</td>
                    <td><c:if test="${users.userIdentity==0}">顾客</c:if>
                        <c:if test="${users.userIdentity==1}">店家</c:if>
                    </td>
                    <td>${users.userAddress}</td>
                    <td>${users.userAge}</td>
                    <td>${users.userSex}</td>
                    <td>
                        <a href="../user/detail?userId=${users.userId}" class="layui-btn layui-btn-warm">详情</a>
                        <a href="../user/toedituser?userId=${users.userId}" class="layui-btn layui-btn-warm">编辑</a>
                        <a href="../user/deleteuser?userId=${users.userId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定将此用户删除？')">删除</a>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="page">
                <%@include file="adminPage.jsp" %>
            </div>
            <div style="display: none" id="div1">
                <form class="layui-form" action="../user/add" method="post" onsubmit="return check();">
                    <div class="layui-form-item">
                        <label class="layui-form-label">用户名</label>
                        <div class="layui-input-block">
                            <input type="text" id="userUsername" name="userUsername" required  lay-verify="required" placeholder="4-13位字符" autocomplete="off" class="layui-input">
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
                            <input type="text" name="userAddress" id="userAddress" required  lay-verify="required"  autocomplete="off" class="layui-input">
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
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        网上订餐系统
    </div>
</div>
</body>
</html>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

    });
    layui.use('form', function () {
        var form = layui.form;
    });
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
    $("#add").click(function () {
        var div=document.getElementById("div1");
        if(div.style.display=='none'){
            div.setAttribute("style","display");
        }
        else {
            div.setAttribute("style","display:none");
        }
    })
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
    function checkisexist(){
        var username=$("#userUsername").val();
        var a;
        $.ajaxSetup({async:false});
        $.get(
            "http://localhost:8080/rs/user/checkusername",
            {"username":username},
            function (result) {
                if("success"==result){
                    a=0;
                }
                else {
                    a=1;
                    alert("用户名已被注册！请重新填写！");
                }
            }
        );
        if(a==0){
            return true;
        }
        else {
            return false;
        }
    }
    function check() {
        if(checkusername()&&checkPhone()&&checkAge()&&checkisexist()){
            return true;
        }
        else {
            return false;
        }
    }
    function databasebackup() { $.ajax({
        url: "${pageContext.request.contextPath}/user/databasebackup",
        type: "post",
        datatype: "json",
        success: function(result)
        { if(result=="success")
        { alert('Success','数据库备份成功！'); }
        else{alert('Error','数据库备份失败！'); } } }) }
</script>

