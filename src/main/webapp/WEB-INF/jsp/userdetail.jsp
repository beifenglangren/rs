<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>订餐系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/style.css">
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
        <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px">
            用户详情
        </div>
        <div style="height: 300px;text-align: center">
        <table style="font-size: 18px;border-collapse:separate; border-spacing:50px 20px;margin: auto">
            <tr>
                <th>用户ID</th>
                <td>${userinfo.userId}</td>
            </tr>
            <tr>
                <th>用户名</th>
                <td>${userinfo.userUsername}</td>
            </tr>
            <tr>
                <th>用户密码</th>
                <td>${userinfo.userPassword}</td>
            </tr>
            <tr>
                <th>用户身份</th>
                <td><c:if test="${userinfo.userIdentity==0}">顾客</c:if>
                    <c:if test="${userinfo.userIdentity==1}">店家</c:if>
                </td>
            </tr>
            <tr>
                <th>地址</th>
                <td>${userinfo.userAddress}</td>
            </tr>
            <tr>
                <th>联系方式</th>
                <td>${userinfo.userPhone}</td>
            </tr>
            <tr>
                <th>年龄</th>
                <td>${userinfo.userAge}</td>
            </tr>
            <tr>
                <th>姓名</th>
                <td>${userinfo.userName}</td>
            </tr>
            <tr>
                <th>性别</th>
                <td>${userinfo.userSex}</td>
            </tr>
        </table>
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
    layui.use('element', function(){
        var element = layui.element;

    });
    layui.use('form', function(){
        var form = layui.form;
    });
    layui.use('carousel', function(){
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            ,width: '100%' //设置容器宽度
            ,arrow: 'always' //始终显示箭头
            ,height:'200px'
            //,anim: 'updown' //切换动画方式
        });
    });
</script>