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
    <link rel="stylesheet" href="../css/style.css">
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
        <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px">
            订单管理
        </div>
            <div style="margin: 10px 0px">
                <form class="layui-form" action="../order/searchallorder" method="post">
                    <div class="layui-form-item">
                        <label class="layui-form-label">搜索</label>
                        <div class="layui-input-block">
                            <input type="text" name="keyword" id="keyword" placeholder="订单内容" autocomplete="off" class="layui-input">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">搜索</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        <div style="margin-left: 15px">
        <button style="margin-top: 10px" class="layui-btn layui-btn-warm" onclick="databasebackup();">订单数据备份</button>
        </div>
            <hr class="layui-bg-gray">
                    <c:forEach items="${allorderMaster}" var="orderMaster">
                        <a href="../order/detail?masterId=${orderMaster.orderId}">
                    <div style="margin: 10px 10px;font-size: 16px">
                        <div style="float: left;margin-right: 20px;width: 60px">
                        <img src="../img/${orderMaster.shop.shopImg}" width="40px" height="40px">
                        </div>
                        <div style="float: left;margin-right: 20px;width: 200px">
                        ${orderMaster.orderCode}
                        </div>
                        <div style="float: left;margin-right: 20px;width: 120px">
                        ${orderMaster.shop.shopName}
                        </div>
                        <div style="float: left;margin-right: 20px;width: 60px">
                            ${orderMaster.orderReceiver}
                        </div>
                        <div style="float: left;margin-right: 20px;width: 60px">
                            <c:if test="${orderMaster.orderStatus==0}">待付款
                        </c:if>
                            <c:if test="${orderMaster.orderStatus==1}">待收货
                            </c:if>
                            <c:if test="${orderMaster.orderStatus==2}">待收货</c:if>
                            <c:if test="${orderMaster.orderStatus==3}">待评价</c:if>
                            <c:if test="${orderMaster.orderStatus==4}">已结束</c:if>
                            <c:if test="${orderMaster.orderStatus==5}">已取消</c:if>
                        </div>
                        <div style="float: left;margin-right: 20px;width: 50px">
                            ${orderMaster.orderAddress}
                        </div>
                        <div style="float: left;margin-right: 20px;width: 200px">
                        <fmt:formatDate value="${orderMaster.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                        </div>
                        <div style="float: left;margin-right: 20px;width: 50px">
                            <a href="../order/admincancel?masterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定将此订单取消？')">取消</a>
                        </div>
                    </div>
                        <hr class="layui-bg-gray">
                    </c:forEach>
        <hr class="layui-bg-gray">
        <div class="page">
            <%@include file="adminPage.jsp" %>
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
    function databasebackup() { $.ajax({
        url: "${pageContext.request.contextPath}/order/databasebackup",
        type: "post",
        datatype: "json",
        success: function(result)
        { if(result=="success")
        { alert('Success','数据库备份成功！'); }
        else{alert('Error','数据库备份失败！'); } } }) }
</script>