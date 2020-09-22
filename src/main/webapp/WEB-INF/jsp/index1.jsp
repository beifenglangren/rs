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
    <style>
        #allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=eGWz1Lp8zgpt8QIg7AZRef2apOQxiAZl"></script>
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
        <div style="padding: 15px;">
            <div style="width: 600px;height: 70px;float: left;margin-bottom: 10px;margin-right: 15px">
                <div id="allmap"></div>
            </div>
            <div style="margin-top:20px">
            <i class="layui-icon layui-icon-location" style="font-size: 30px;color: lightgrey"></i>
            <span id="address"style="font-weight: bold;font-size: 30px">${city}</span>
            </div>
            <form class="layui-form" action="../shop/search" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">搜索</label>
                    <div class="layui-input-block">
                        <input type="text" name="keyword" id="keyword" placeholder="餐品名及商家名" autocomplete="off" class="layui-input">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">搜索</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
            <div class="layui-carousel" id="test1">
                <div carousel-item>
                    <c:forEach items="${hotshop}" var="shop">
                    <div><a href="../product/list?shopId=${shop.shopId}">
                        <img src="../img/${shop.shopImg}" width=100% height=100%>
                    </a>
                    </div>
                    </c:forEach>
                </div>
            </div>
            <c:forEach items="${categorymaster}" var="category">
                <a href="../shop/categorylist?categoryId=${category.categoryId}">
                <div class="categorylist">
                    <div>
                        <img src="../img/${category.categoryImg}" width="70px" height="70px">
                    </div>
                    <div style="margin: 5px 5px;font-weight: bold">
                            ${category.categoryName}
                    </div>
                </div>
                </a>
            </c:forEach>
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
            ,width: '95%' //设置容器宽度
            ,arrow: 'always' //始终显示箭头
            ,height:'300px'
            //,anim: 'updown' //切换动画方式
        });
    });
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(116.331398,39.897445);
    map.centerAndZoom(point,12);
    function myFun(result){
        var cityName = result.name;
        map.setCenter(cityName);
    }
    var myCity = new BMap.LocalCity();
    myCity.get(myFun);
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
</script>