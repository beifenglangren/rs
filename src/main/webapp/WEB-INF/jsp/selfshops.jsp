<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <li class="layui-nav-item"><a href="../user/shopindex">首页</a></li>
                <li class="layui-nav-item"><a href="../shop/toapply">申请创建商家</a></li>
                <li class="layui-nav-item"><a href="../shop/selfshops">我的商家</a></li>
                <li class="layui-nav-item"><a href="../order/towaitorder">待处理订单</a></li>
                <li class="layui-nav-item"><a href="../order/shopordershow">历史订单</a></li>
                <li class="layui-nav-item"><a href="../review/toreplyreview">待回复评价</a></li>
                <li class="layui-nav-item"><a href="../review/toshopreview">历史评价</a></li>
            </ul>
        </div>
    </div>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                我的商家
            </div>
            <c:forEach items="${shoplist}" var="shop">
            <a href="../shop/detail?shopId=${shop.shopId}">
                <div class="shoplist">
                    <div>
                        <img src="../img/${shop.shopImg}" width="200px" height="156px">
                    </div>
                    <div style="margin: 5px 5px;font-weight: bold">
                            ${shop.shopName}
                    </div>
                    <div style="margin: 5px 5px">
                            <c:if test="${shop.shopStatus==0}">
                                待审核
                            </c:if>
                        <c:if test="${shop.shopStatus==1}">
                            在市
                        </c:if>
                        <c:if test="${shop.shopStatus==2}">
                            已否决
                        </c:if>
                        &nbsp;&nbsp;&nbsp;&nbsp;${shop.shopAddress}
                    </div>
                    <div style="margin: 5px 5px">
                        价格：${shop.shopPrice}元&nbsp;&nbsp;${shop.categoryMaster.categoryName}
                    </div>
                </div>
            </a>
            </c:forEach>
            <hr class="layui-bg-gray">
            <div class="page">
                <%@include file="adminPage.jsp" %>
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

</script>

