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
    <link rel="stylesheet" href="../css/bootstrap.min.css">
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
        <div style="padding: 15px;text-align: center">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                商家详情
            </div>
            <div class="layui-card">
                <div class="layui-card-header">
                    <div style="font-size: 24px;font-weight: bold">
                    ${shop.shopName}</div></div>
                <div class="layui-card-body">
                    <div>
                        <img src="../img/${shop.shopImg}" width="200px" height="156px">
                    </div>
                    <div style="font-size: 16px">
                    地址：${shop.shopAddress}
                    </div>
                    <div style="margin: 5px 5px;font-size: 16px">
                        销量：${shop.saleCount}&nbsp;评分：<c:forEach begin="1" end="${shop.shopScore}">
                        <span style="font-size: 18px;color: #fffc0b">&#9733;</span>
                    </c:forEach>
                    </div>
                    <div style="margin: 5px 5px;font-size: 16px">
                        人均${shop.shopPrice}元&nbsp;&nbsp;${shop.categoryMaster.categoryName}
                    </div>
                    <div style="margin: 5px 5px;font-size: 16px">
                        ${shop.shopDesc}&nbsp;&nbsp;状态：<c:if test="${shop.shopStatus==0}">
                        待审批
                    </c:if>
                        <c:if test="${shop.shopStatus==1}">
                            在市
                        </c:if>
                            <c:if test="${shop.shopStatus==2}">
                                已否决
                            </c:if>
                    </div>
                    <div style="margin: 5px 5px;font-size: 16px">
                        联系方式：${shop.shopPhone}
                    </div>
                    <div style="margin: 5px 5px;font-size: 16px">
                        创建时间：<fmt:formatDate value="${shop.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </div>
                    <div style="margin: 5px 5px;font-size: 16px">
                        更新时间：<fmt:formatDate value="${shop.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </div>
                </div>
            </div>
            <a href="../shop/toedit?shopId=${shop.shopId}" class="layui-btn layui-btn-warm">编辑商家信息</a>
            &nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="../category/listinnercategory?shopId=${shop.shopId}&msg=''" class="layui-btn layui-btn-warm">管理店内分类</a>
            &nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="../product/productmgt?shopId=${shop.shopId}" class="layui-btn layui-btn-warm">管理店内餐品</a>
            &nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="../shop/toreport?shopId=${shop.shopId}" class="layui-btn layui-btn-warm">查看商家报表</a>
            <c:if test="${shop.shopStatus==0 && (user.userIdentity==1||user.userIdentity==2)}">
                &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="../shop/toshopcheckdetail?shopId=${shop.shopId}" class="layui-btn layui-btn-warm">查看审批流程</a>
            </c:if>
            <c:if test="${shop.shopStatus==1 && user.userIdentity==2}">
                &nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="../shop/cancelshop?shopId=${shop.shopId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定将此商家下市？')">下市</a>
            </c:if>
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

