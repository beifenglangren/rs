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
            评价订单
        </div>
            <div style="margin: 10px 10px;font-size: 16px">
                <img src="../img/${orderMaster.shop.shopImg}" width="40px" height="40px">
                &nbsp;&nbsp;&nbsp;&nbsp;
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
                            X${orderdetail.orderCount}&nbsp;&nbsp;&nbsp;<button class="zan">
                            <i class="layui-icon layui-icon-praise" style="font-size: 20px"></i>
                        </button>
                            <input type="hidden" class="zb" value="0">
                            <input type="hidden" class="pid" value="${orderdetail.product.productId}">
                            <input type="hidden" class="oid" value="${orderMaster.orderId}">
                            &nbsp;&nbsp;&nbsp;
                            <button class="cai">
                                <i class="layui-icon layui-icon-tread" style="font-size: 20px"></i>
                            </button>
                            <input type="hidden" class="cb" value="0">
                        </div>
                    </div>
                    <div style="float: right;margin-right: 100px;font-size: 16px">
                        ￥${orderdetail.orderAmount}
                    </div>
                </div>
                </c:forEach>
            <hr class="layui-bg-gray">
        <div style="margin-left: 100px">
            评分：
            <span onclick='clickStart(1)' id='start1' class='start_zyz' style="font-size: 30px;color: #fffc0b">&#9734;</span>
            <span onclick='clickStart(2)' id='start2' class='start_zyz' style="font-size: 30px;color: #fffc0b">&#9734;</span>
            <span onclick='clickStart(3)' id='start3' class='start_zyz' style="font-size: 30px;color: #fffc0b">&#9734;</span>
            <span onclick='clickStart(4)' id='start4' class='start_zyz' style="font-size: 30px;color: #fffc0b">&#9734;</span>
            <span onclick='clickStart(5)' id='start5' class='start_zyz' style="font-size: 30px;color: #fffc0b">&#9734;</span>
        </div>
        <form class="layui-form" action="../review/addreview" method="post">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">评价：</label>
                <div class="layui-input-block">
                    <textarea name="content" id="content" placeholder="亲，请评价本次订单！" class="layui-textarea"></textarea>
                </div>
            </div>
            <input type="hidden" id="score" name="score">
            <input type="hidden" id="sid" name="sid" value="${orderMaster.shop.shopId}">
            <input type="hidden" id="oid" name="oid" value="${orderMaster.orderId}">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
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
    function clickStart(index){
        clearStart();
        for(var i=1;i<=index;i++){
            var span = document.getElementById('start'+i);
            span.innerHTML='&#9733;';
        }
        $("#score").val(index);
    }
    function clearStart(){
        for(var i=1;i<=5;i++){
            var span = document.getElementById('start'+i);
            span.innerHTML='&#9734;';
        }
    }

    $(function () {
        $(".zan").click(function () {
            var z=$(this).parent().children(".zb").val();
            var c=$(this).parent().children(".cb").val();
            if(z==0&&c==0){
                $(this).html("<i class=\"layui-icon layui-icon-praise\" style=\"font-size: 20px;color: yellow\"></i>");
                $(this).parent().children(".zb").val(1);
                var pid=$(this).parent().children(".pid").val();
                var oid=$(this).parent().children(".oid").val();
                $.get(
                    "http://localhost:8080/rs/product/zan",
                    {"pid":pid,"oid":oid},
                    function (result) {
                        if("success"==result){
                        }
                        else {
                            alert("在当前订单中，用户对当前商品只能赞1次!请勿多赞！");
                        }
                    }
                );
            }
            if(z==0&&c==1){
                $(this).html("<i class=\"layui-icon layui-icon-praise\" style=\"font-size: 20px;color: yellow\"></i>");
                $(this).parent().children(".zb").val(1);
                $(this).parent().children(".cai").html("<i class=\"layui-icon layui-icon-tread\" style=\"font-size: 20px\"></i>");
                $(this).parent().children(".cb").val(0);
                var pid=$(this).parent().children(".pid").val();
                var oid=$(this).parent().children(".oid").val();
                $.get(
                    "http://localhost:8080/rs/product/zan",
                    {"pid":pid,"oid":oid},
                    function (result) {
                        if("success"==result){
                        }
                        else {
                            alert("在当前订单中，用户对当前商品只能赞1次!请勿多赞！");
                            $(this).html("<i class=\"layui-icon layui-icon-praise\" style=\"font-size: 20px\"></i>");
                            $(this).parent().children(".zb").val(0);
                        }
                    }
                );
            }
            if(z==1&&c==0){
                $(this).html("<i class=\"layui-icon layui-icon-praise\" style=\"font-size: 20px\"></i>");
                $(this).parent().children(".zb").val(0);
                var pid=$(this).parent().children(".pid").val();
                var oid=$(this).parent().children(".oid").val();
                $.get(
                    "http://localhost:8080/rs/product/cancelzan",
                    {"pid":pid,"oid":oid},
                    function (result) {
                        if("success"==result){
                        }
                        else {
                        }
                    }
                );
            }
        });
        $(".cai").click(function () {
            var c=$(this).parent().children(".cb").val();
            var z=$(this).parent().children(".zb").val();
            if(c==0&&z==0){
                $(this).html("<i class=\"layui-icon layui-icon-tread\" style=\"font-size: 20px;color: grey\"></i>");
                $(this).parent().children(".cb").val(1);
            }
            if(c==0&&z==1){
                $(this).html("<i class=\"layui-icon layui-icon-tread\" style=\"font-size: 20px;color: grey\"></i>");
                $(this).parent().children(".cb").val(1);
                $(this).parent().children(".zan").html("<i class=\"layui-icon layui-icon-praise\" style=\"font-size: 20px\"></i>");
                $(this).parent().children(".zb").val(0);
                var pid=$(this).parent().children(".pid").val();
                var oid=$(this).parent().children(".oid").val();
                $.get(
                    "http://localhost:8080/rs/product/cancelzan",
                    {"pid":pid,"oid":oid},
                    function (result) {
                        if("success"==result){
                        }
                        else {
                        }
                    }
                );

            }
            if(c==1&&z==0){
                $(this).html("<i class=\"layui-icon layui-icon-tread\" style=\"font-size: 20px\"></i>");
                $(this).parent().children(".cb").val(0);
            }
        });
    })
</script>