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
        <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px">
            订单详情
        </div>
            <div style="margin: 10px 25px 10px 15px;float: left">
                <i class="layui-icon layui-icon-location" style="font-size: 36px;color: lightgrey"></i>
            </div>
            <div style="float: left;margin: 10px 0px">
                <c:if test="${orderMaster.orderStatus==0}">
                    未付款
                </c:if>
                <c:if test="${orderMaster.orderStatus==1}">
                    待收货
                </c:if>
                <c:if test="${orderMaster.orderStatus==2}">
                    待收货
                </c:if>
                <c:if test="${orderMaster.orderStatus==3}">
                    待评价
                </c:if>
                <c:if test="${orderMaster.orderStatus==4}">
                    已结束
                </c:if>
                <c:if test="${orderMaster.orderStatus==5}">
                    已取消
                </c:if>
                &nbsp;&nbsp;&nbsp;
                接收人：${orderMaster.orderReceiver}
                &nbsp;&nbsp;&nbsp;
                接收电话：${orderMaster.orderPhone}
                <div style="margin: 5px 0px">
                    收货地址：${orderMaster.orderAddress}
                    &nbsp;&nbsp;&nbsp;
                    订单号：${orderMaster.orderCode}
                    &nbsp;&nbsp;&nbsp;
                    创建时间：<fmt:formatDate value="${orderMaster.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                </div>
            </div>
            <hr class="layui-bg-gray">
            <div style="margin: 10px 10px;font-size: 16px">
                ${orderMaster.shop.shopName}
            </div>
            <hr class="layui-bg-gray">
        <c:forEach items="${orderMaster.orderDetails}" var="orderdetail">
            <div style="width: 100%;height: 100px;margin: 5px 10px">
                <div style="float: left">
                <img src="../img/${orderdetail.product.productImg}" width="60px" height="60px">
                </div>
                <div style="float: left;margin: 0px 15px">
                    ${orderdetail.product.productName}
                    <div style="margin: 25px 0px">
                        X${orderdetail.orderCount}
                    </div>
                </div>
                <div style="float: right;margin-right: 100px;font-size: 16px">
                ￥${orderdetail.orderAmount}
            </div>
            </div>
        </c:forEach>
        <hr class="layui-bg-gray">
        <div style="width: 100%;height: 100px;margin: 5px 10px">
            <div style="float: left;margin: 0px 15px">
                配送费
            </div>
            <div style="float: right;margin-right: 100px;font-size: 16px">
                ￥5
            </div>
        </div>
            <hr class="layui-bg-gray">
                <div class="order">
                    <div style="margin-left: 800px">
                    <span style="font-weight: bold;font-size: 20px;color: #000000">合计</span>
                        &nbsp;&nbsp;
                        <span style="font-weight: bold;font-size: 30px;color: #000000">￥${orderMaster.orderTotal}</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
                </div>
            <div style="margin-left: 900px">
                <a href="../order/delivery?orderMasterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定发货？')">发货</a>
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
</script>