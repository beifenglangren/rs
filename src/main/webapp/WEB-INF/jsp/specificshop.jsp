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
    <script src="../js/jquery.min.js"></script>
    <script src="../js/jquery.fly.min.js"></script>
    <script src="../js/requestAnimationFrame.js"></script>
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
        <ul class="layui-nav layui-nav-tree" lay-filter="test">
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
<div class="layui-card">
    <div class="layui-card-header">
        ${shop.shopName}&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="shoucang">
            <i class="layui-icon layui-icon-star" style="font-size: 28px"></i>
            </button>
        <input type="hidden" value="${shop.shopId}" id="sid">
    </div>
    <div class="layui-card-body">
        ${shop.shopDesc}
    </div>
</div>
<!-- 内容主体区域 -->
<div class="layui-tab">
<ul class="layui-tab-title">
    <li class="layui-this">点菜</li>
    <li>评价</li>
    <li>商家</li>
</ul>
<div class="layui-tab-content">
<div class="layui-tab-item layui-show">店内分类
<div class="layui-tab">
<ul class="layui-tab-title">
    <c:forEach items="${categoryinnerlist}" var="categoryinner" varStatus="vs">
        <c:if test="${vs.index==0}">
    <li class="layui-this">${categoryinner.categoryName}</li>
        </c:if>
        <c:if test="${vs.index!=0}">
            <li>${categoryinner.categoryName}</li>
        </c:if>
    </c:forEach>
    </ul>
    <div class="layui-tab-content">
<c:forEach items="${categoryinnerlist}" var="categoryinner" varStatus="vs">
    <c:if test="${vs.index==0}">
        <div class="layui-tab-item layui-show">
    </c:if>
        <c:if test="${vs.index!=0}">
        <div class="layui-tab-item">
            </c:if>
                <form action="../product/settle" method="post" onsubmit="return checksettle();">
    <c:forEach items="${categoryinner.productInfos}" var="product">
                <div class="shoplist" id="div2">
                    <div>
                        <input type="hidden" value="${product.productId}" id="productId" name="productId">
                        <input type="hidden" value="${product.shopId}" id="shopId" name="shopId">
                        <img src="../img/${product.productImg}" width="200px" height="156px" id="productImg">
                    </div>
                    <div style="margin: 5px 5px;font-weight: bold">
                            ${product.productName}${product.productDesc}
                    </div>
                    <div style="margin: 5px 5px">
                        销量：${product.saleCount}&nbsp;&nbsp;赞：${product.productZan}
                    </div>
                    <div style="margin: 5px 5px">
                        价格：<input type="text" value="${product.productPrice}" id="price" class="price" readonly="readonly" style="width: 45px;text-align: center;border: none;background: #f3f3f3">元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
                            type="button" value="-" id="num-jian" class="num-jian">
                        <input type="text" id="input-num" name="input-num" value="0" class="input-num" readonly="readonly"
                               style="width: 28px;text-align: center"/>
                        <input type="button" value="+" id="num-jia" class="num-jia">
                        <input type="hidden" value="${product.productStock}" class="stock">
                    </div>
                </div>
    </c:forEach>
            </div>
</c:forEach>
    </div>
    </div>
    <hr class="layui-bg-gray">
    <div id="divTarget" class="target">
        <img src="../img/gouwuche.jpg" width="60px" height="60px">
    <span class="totalNum" id="total">0</span>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span style="font-weight: bold;font-size: 20px;color: #ffffff">共</span>
    <span class="totalPrice">0</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="结算（配送费5元）" style="background: #000000;color: #ffffff;border-style: none;font-weight: bold" id="settle">
    </div>
    </form>
    </div>
    <div class="layui-tab-item">
    <div class="layui-form-item">商家评分：<c:forEach begin="1" end="${shop.shopScore}">
        <span style="font-size: 18px;color: #fffc0b">&#9733;</span>
    </c:forEach>
        <hr class="layui-bg-gray">
        <c:forEach items="${reviewinfos}" var="review">
        <div>
            <div>用户名：${review.user.userUsername}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <fmt:formatDate value="${review.createTime}" pattern="yyyy-MM-dd"></fmt:formatDate>
            </div>
            <div>评分：<c:forEach begin="1" end="${review.reviewScore}">
                <span style="font-size: 18px;color: #fffc0b">&#9733;</span>
            </c:forEach></div>
            <div style="margin-top: 3px">${review.reviewContent}</div>
            <c:forEach items="${review.messageInfos}" var="message">
                <c:if test="${message.status==0}">
            <div style="background: lightgrey;margin-top: 5px"><fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商家回复：${message.content}
            </div>
                </c:if>
                <c:if test="${message.status==1}">
                    <div style="background: lightgrey;margin-top: 5px"><fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户回复：${message.content}
                    </div>
                </c:if>
            </c:forEach>
        </div>
            <hr class="layui-bg-gray">
        </c:forEach>
    </div>
    </div>
    <div class="layui-tab-item">商家地址：${shop.shopAddress}<br>
    商家电话：${shop.shopPhone}<br><br><br>
        <img src="../img/${shop.shopImg}" width="300px" height="300px">
        <img src="../img/yingyezhizhao.jpg" width="300px" height="300px">
        <img src="../img/farenzhizhao.jpg" width="300px" height="300px">
        <img src="../img/gerenzhizhao.jpg" width="300px" height="300px">
    </div>
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
    layui.use('element', function(){
    var element = layui.element;

    //…
    });
    function checksettle() {
        var sss=$(".totalPrice").text();
        if(sss=="0"){
            alert("您还未添加餐品！请勿结算！");
            return false;
        }
        else {
            return true;
        }
    }
    $(function(){
    $(".num-jia").click(function(){
    var stock= $(this).parent().children(".stock").val();
    var num = $(this).parent().children(".input-num").val();
    if(parseInt(num)<parseInt(stock)){
        num=parseInt(num)+1;
        $(this).parent().children(".input-num").val(num);
        var totalNum = parseInt($(".totalNum").text());
        totalNum++
        $(".totalNum").text(totalNum);
        var goods_price = parseInt($(this).parent().children(".price").val());
        $(".totalPrice").text(parseInt($(".totalPrice").text())+goods_price+"元");
        var _sourceImg=$(this).parent().parent().children().children('img');
        var _back=function(){};
        var _target=$("#divTarget");
        objectFlyIn(_sourceImg,_target,_back);
    }
    else if(parseInt(num)>=parseInt(stock)) {
        alert("该商品库存不足！");
        $(this).parent().children(".input-num").val(num);
    }
    });
    $("#div2 input[value='-']").bind("click",function(){
    var num = $(this).parent().children(".input-num").val();
    if(parseInt(num)){
    num=parseInt(num)-1;
    $(this).parent().children(".input-num").val(num);
    var totalNum = parseInt($(".totalNum").text());
    totalNum--
    $(".totalNum").text(totalNum);
    var goods_price = parseInt($(this).parent().children(".price").val());
    $(".totalPrice").text(parseInt($(".totalPrice").text())-goods_price+"元");
    } else{
    $(this).parent().children(".input-num").val(0);
    }
    });
    /**
    * 对象飞入
    *
    */
    function objectFlyIn(_sourceImg,_target, _back) {
    var addOffset =_target.offset();
    var img = _sourceImg;
    var flyer = $('<img style="display: block;width: 50px;height: 50px;border-radius: 50px;position: fixed;z-index: 100000;" src="' + img.attr('src') + '">');
    var X,Y;
    if(img.offset()){
    X = img.offset().left - $(window).scrollLeft();
    Y = img.offset().top - $(window).scrollTop();
    }
    flyer.fly({
    start: {
    left: X + img.width() / 2 - 25, //开始位置（必填）
    top: Y + img.height() / 2 - 25 //开始位置（必填）
    },
    end: {
    left: addOffset.left + 10, //结束位置（必填）
    top: addOffset.top + 10, //结束位置（必填）
    width: 10, //结束时宽度
    height: 10 //结束时高度
    },
    onEnd: function () { //结束回调
    this.destroy(); //移除dom
    _back();
    }
    });
    }
    var sid=$("#sid").val();
    var b;
        $.get(
            "http://localhost:8080/rs/shop/collectconfirm",
            {"sid":sid},
            function (result) {
                if("success"==result){
                    $(".shoucang").html("<i class=\"layui-icon layui-icon-star-fill\" style=\"font-size: 28px\"></i>");
                    b=1;
                }
                else {
                    b=0;
                }
            }
        );
        $(".shoucang").click(function () {
            if(b==1){
                $.get(
                    "http://localhost:8080/rs/shop/collectcancel",
                    {"sid":sid},
                    function (result) {
                        if("success"==result){
                            $(".shoucang").html("<i class=\"layui-icon layui-icon-star\" style=\"font-size: 28px\"></i>");
                            b=0;
                        }
                        else {
                        }
                    }
                );
            }
            if(b==0){
                $.get(
                    "http://localhost:8080/rs/shop/collect",
                    {"sid":sid},
                    function (result) {
                        if("success"==result){
                            $(".shoucang").html("<i class=\"layui-icon layui-icon-star-fill\" style=\"font-size: 28px\"></i>");
                            b=1;
                        }
                        else {
                        }
                    }
                );
            }
        });
    })
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
    </script>