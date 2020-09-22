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
            提交订单
        </div>
            <div style="margin: 10px 25px 10px 15px;float: left">
                <i class="layui-icon layui-icon-location" style="font-size: 36px;color: lightgrey"></i>
            </div>
            <div style="float: left;margin: 10px 0px">
                ${user.userName}&nbsp;&nbsp;&nbsp;
                    <c:if test="${user.userSex=='男'}">
                        先生
                    </c:if>
                    <c:if test="${user.userSex=='女'}">
                        女士
                    </c:if>
                &nbsp;&nbsp;&nbsp;
                ${user.userPhone}
                <div style="margin: 5px 0px">
                    ${city}
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
            <form class="layui-form" action="../order/topay">
                <div class="layui-form-item layui-form-text">
                    <input type="hidden" value="${orderMaster.orderId}" id="masterId" name="masterId">
                    <label class="layui-form-label">备注：</label>
                    <div class="layui-input-block">
                        <textarea name="desc" id="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="order">
                    <div style="margin-left: 800px">
                    <span style="font-weight: bold;font-size: 20px;color: #000000">合计</span>
                        &nbsp;&nbsp;
                        <span style="font-weight: bold;font-size: 30px;color: #000000">￥${orderMaster.orderTotal}</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="submit" value="提交订单" style="background: #ffe51a;color: #000000;border-style: none;font-weight: bold;font-size: 20px">
                </div>
                </div>
            </form>
            <div>

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
    function checkpassword() {
        var password=document.getElementById("userPassword").value.trim();
        var pwd=document.getElementById("confirmPassword").value.trim();
        if(password.length<4||password.length>13){
            alert("密码不符合要求！请重新输入！");
            document.getElementById("userPassword").focus();
            return false;
        }
        else if(pwd!=password){
            alert("确认密码输入不一致！请重新输入！");
            document.getElementById("userPassword").focus();
            return false;
        }
        else {
            return true;
        }
    }
</script>