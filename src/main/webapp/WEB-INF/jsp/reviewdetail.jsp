<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            评价详情
        </div>
        <div style="margin-top: 30px;margin-left: 15px">
            <div>
                <fmt:formatDate value="${review.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
            </div>
            <div>评分：<c:forEach begin="1" end="${review.reviewScore}">
                <span style="font-size: 18px;color: #fffc0b">&#9733;</span>
            </c:forEach></div>
            <div>${review.shop.shopName}</div>
            <c:forEach items="${review.orderDetails}" var="orderdetail">
                <div style="float: left;margin-left: 20px">
                <div style="float: left">
                    <img src="../img/${orderdetail.product.productImg}" width="60px" height="60px">
                </div>
                <div style="float: left;margin-left: 15px">
                        ${orderdetail.product.productName}
                    <div>
                        X${orderdetail.orderCount}
                    </div>
                            <div>
                                ￥${orderdetail.orderAmount}
                            </div>
                </div>
                </div>
            </c:forEach>
            <hr class="layui-bg-gray">
            <div style="margin-top: 3px">评价内容：${review.reviewContent}</div>
            <c:forEach items="${review.messageInfos}" var="message">
                <c:if test="${message.status==0}">
                    <div style="background: lightgrey;margin-top: 5px">
                    <div style="height: 35px"><fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                        <c:if test="${user.userIdentity==1||user.userIdentity==2}">
                            <a href="../review/deletemessage?id=${message.id}&reviewId=${review.reviewId}" class="layui-btn layui-btn-sm layui-btn-warm" onclick="return confirm('确定将此回复删除？')">删除</a>
                        </c:if>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商家回复：${message.content}

                    </div>
                    </div>
                </c:if>
                <c:if test="${message.status==1}">
            <div style="background: lightgrey;margin-top: 5px">
                <div style="height: 35px"><fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    <c:if test="${user.userIdentity==0||user.userIdentity==2}">
                        <a href="../review/deletemessage?id=${message.id}&reviewId=${review.reviewId}" class="layui-btn layui-btn-sm layui-btn-warm" onclick="return confirm('确定将此回复删除？')">删除</a>
                    </c:if>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户回复：${message.content}
                </div>
            </div>
                </c:if>
            </c:forEach>
            <c:if test="${user.userIdentity==0||user.userIdentity==1}">
            <button style="margin-top: 10px" class="layui-btn layui-btn-warm" id="addhuifu">回复</button>
            </c:if>
            <div style="display: none" id="div1">
                <form class="layui-form" action="../review/reply" method="post">
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">文本域</label>
                    <div class="layui-input-block">
                        <textarea name="content" id="content" placeholder="请输入回复内容" class="layui-textarea"></textarea>
                    </div>
                </div>
                    <input type="hidden" value="${review.reviewId}" id="reviewId" name="reviewId">
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
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
    $("#addhuifu").click(function () {
        var div=document.getElementById("div1");
        if(div.style.display=='none'){
            div.setAttribute("style","display");
        }
        else {
            div.setAttribute("style","display:none");
        }
    })
</script>