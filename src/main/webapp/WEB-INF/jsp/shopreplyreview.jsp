<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>订餐系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
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
                    贤心
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
            待回复评价
        </div>
        <c:forEach items="${reviewInfos}" var="review">
            <a href="../review/reviewdetail?reviewId=${review.reviewId}">
        <div style="margin-top: 30px;margin-left: 15px">
            <div>
                <fmt:formatDate value="${review.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
            </div>
            <div>评分：<c:forEach begin="1" end="${review.reviewScore}">
                <span style="font-size: 18px;color: #fffc0b">&#9733;</span>
            </c:forEach></div>
            <div>${review.shop.shopName}
                &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
            </a>
        <hr class="layui-bg-gray">
        </c:forEach>
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