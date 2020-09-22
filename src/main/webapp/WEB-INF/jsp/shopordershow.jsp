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

    <c:if test="${user.userIdentity==0}">
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
    </c:if>
    <c:if test="${user.userIdentity==1}">
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
    </c:if>
    <c:if test="${user.userIdentity==2}">
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
    </c:if>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px">
            我的订单
        </div>
            <div style="float: left;margin: 10px 0px">
                <form class="layui-form" action="../order/searchshoporder" method="post">
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
                    <c:forEach items="${allorderMaster}" var="orderMaster">
                        <a href="../order/detail?masterId=${orderMaster.orderId}">
                    <div style="margin: 10px 10px;font-size: 16px;color: #000000">
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
                            ${orderMaster.orderReceiver}&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            ${orderMaster.orderAddress}&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <fmt:formatDate value="${orderMaster.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </div>
                    <hr class="layui-bg-gray">
                    <c:forEach items="${orderMaster.orderDetails}" var="orderdetail" varStatus="vs">
                        <c:if test="${vs.count<=1}">
                        <div style="width: 100%;margin-left: 70px;color: #000000">
                            ${orderdetail.product.productName}等${orderMaster.count}件商品&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            ￥${orderMaster.orderTotal}
                        </div>
                        </c:if>
                        </a>
                    </c:forEach>
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
</script>