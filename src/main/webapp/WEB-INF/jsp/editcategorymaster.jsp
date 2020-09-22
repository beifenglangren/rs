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
                编辑分类
            </div>
            <form class="layui-form" action="../category/editcategorymaster" method="post" id="form1" onsubmit="return checkname();" enctype="multipart/form-data">
                <input type="hidden" value="${category.categoryId}" name="categoryId" id="categoryId">
                <div class="layui-form-item">
                    <label class="layui-form-label">名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="categoryName" name="categoryName" autocomplete="off" class="layui-input" required  lay-verify="required" value="${category.categoryName}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">分类照片</label>
                    <div style="margin-bottom: 5px">
                        <img src="../img/${category.categoryImg}" width="50px" height="50px">
                    </div>
                    <div class="layui-input-block">
                        <input name="categoryImg" id="categoryImg" class="file-loading"
                               type="file" multiple accept=".jpg,.jpeg,.png" data-min-file-count="1"
                               data-show-preview="true">
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
    layui.use('carousel', function () {
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            , width: '100%' //设置容器宽度
            , arrow: 'always' //始终显示箭头
            , height: '200px'
            //,anim: 'updown' //切换动画方式
        });
    });
    $("#add").click(function () {
        var div=document.getElementById("div1");
        if(div.style.display=='none'){
            div.setAttribute("style","display");
        }
        else {
            div.setAttribute("style","display:none");
        }
    })
    function check(){
        var name=$("#categoryName").val();
        var categoryId=$("#categoryId").val();
        var a;
        $.ajaxSetup({async:false});
        $.get(
            "http://localhost:8080/rs/category/checkmastereditname",
            {"name":name,"categoryId":categoryId},
            function (result) {
                if("success"==result){
                    a=0;
                }
                else {
                    a=1;
                    alert("您编辑的分类名已经存在！请重新编辑！");
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
    function checkname() {
        if(check()){
            return true;
        }
        else {
            return false;
        }
    }
</script>

