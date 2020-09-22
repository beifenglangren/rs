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
        <div style="padding: 20px">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                待处理订单
            </div>
            <c:forEach items="${orderMasterlist}" var="orderMaster">
                <a href="../order/waitorderdetail?masterId=${orderMaster.orderId}">
                <div style="margin: 10px 10px;font-size: 16px">
                    <img src="../img/${orderMaster.shop.shopImg}" width="40px" height="40px">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                        ${orderMaster.shop.shopName}&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        ${orderMaster.user.userName}&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        ${orderMaster.orderAddress}&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <fmt:formatDate value="${orderMaster.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                </div>
                <hr class="layui-bg-gray">
                <c:forEach items="${orderMaster.orderDetails}" var="orderdetail" varStatus="vs">
                    <c:if test="${vs.count<=1}">
                        <div style="width: 100%;margin-left: 70px">
                                ${orderdetail.product.productName}等${orderMaster.count}件商品&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            ￥${orderMaster.orderTotal}
                        </div>
                    </c:if>
                    </a>
                </c:forEach>
                <div style="margin-left: 450px;margin-top: 30px">
                        <a href="../order/delivery?orderMasterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定发货？')">发货</a>
                    <a href="../order/cancelshoporder?masterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定取消？')">取消</a>
                </div>
                <hr class="layui-bg-gray">
            </c:forEach>
            <hr class="layui-bg-gray">
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

