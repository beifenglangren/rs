<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <li class="layui-nav-item"><a href="../user/index">首页</a></li>
                <li class="layui-nav-item"><a href="../shop/selfcollect">我的收藏</a></li>
                <li class="layui-nav-item"><a href="../product/oftenbuy">常买餐品</a></li>
                <li class="layui-nav-item"><a href="../shop/oftenbuy">常去店家</a></li>
                <li class="layui-nav-item"><a href="../order/list">我的订单</a></li>
                <li class="layui-nav-item"><a href="../review/selfreview">我的评价</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px">
            我的订单
        </div>
            <div style="float: left;margin: 10px 0px">
                <form class="layui-form" action="../order/search" method="post">
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
            <hr class="layui-bg-gray">
        <div class="layui-tab">
            <ul class="layui-tab-title">
                <li class="layui-this">全部订单</li>
                <li>待评价</li>
                <li>已取消</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <c:forEach items="${allorderMaster}" var="orderMaster">
                        <a href="../order/detail?masterId=${orderMaster.orderId}">
                    <div style="margin: 10px 10px;font-size: 16px">
                        <img src="../img/${orderMaster.shop.shopImg}" width="40px" height="40px">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        ${orderMaster.shop.shopName}&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <c:if test="${orderMaster.orderStatus==0}">待付款
                        </c:if>
                            <c:if test="${orderMaster.orderStatus==1}">待收货
                            </c:if>
                            <c:if test="${orderMaster.orderStatus==2}">待收货</c:if>
                            <c:if test="${orderMaster.orderStatus==3}">待评价</c:if>
                            <c:if test="${orderMaster.orderStatus==4}">已结束</c:if>
                            <c:if test="${orderMaster.orderStatus==5}">已取消</c:if>
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
                        <div style="margin-left: 200px;margin-top: 30px">
                        <c:if test="${orderMaster.orderStatus==0}">
                            <a href="../order/topay?masterId=${orderMaster.orderId}&desc=${orderMaster.orderInfo}" class="layui-btn layui-btn-warm">去付款</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="../order/cancel?masterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定将此订单取消？')">取消</a>
                        </c:if>
                        <c:if test="${orderMaster.orderStatus==1||orderMaster.orderStatus==2}">
                            <a href="../order/confirm?masterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm">确认收货</a>
                        </c:if>
                        <c:if test="${orderMaster.orderStatus==3}">
                            <a href="../order/toreview?masterId=${orderMaster.orderId}" class="layui-btn layui-btn-warm">去评价</a>
                        </c:if>
                        </div>
                        <hr class="layui-bg-gray">
                    </c:forEach>

                </div>
                <div class="layui-tab-item">
                    <c:forEach items="${revieworderMaster}" var="orderMaster">
                        <a href="../order/detail?masterId=${orderMaster.orderId}">
                        <div style="margin: 10px 10px;font-size: 16px">
                            <img src="../img/${orderMaster.shop.shopImg}" width="40px" height="40px">
                            &nbsp;&nbsp;&nbsp;&nbsp;
                                ${orderMaster.shop.shopName}&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            待评价
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
                        <div style="margin-left: 200px;margin-top: 30px">
                            <c:if test="${orderMaster.orderStatus==3}">
                                <a href="" class="layui-btn layui-btn-warm">去评价</a>
                            </c:if>
                        </div>
                        <hr class="layui-bg-gray">
                    </c:forEach>
                </div>
                <div class="layui-tab-item">
                    <c:forEach items="${cancelorderMaster}" var="orderMaster">
                        <a href="../order/detail?masterId=${orderMaster.orderId}">
                        <div style="margin: 10px 10px;font-size: 16px">
                            <img src="../img/${orderMaster.shop.shopImg}" width="40px" height="40px">
                            &nbsp;&nbsp;&nbsp;&nbsp;
                                ${orderMaster.shop.shopName}&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            已取消
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
                        <div style="margin-left: 200px;margin-top: 30px">
                        </div>
                        <hr class="layui-bg-gray">
                    </c:forEach>
                </div>
            </div>
        </div>
            <hr class="layui-bg-gray">
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