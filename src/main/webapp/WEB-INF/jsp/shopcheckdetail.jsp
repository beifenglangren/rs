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
        <div style="padding: 20px">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                审批流程
            </div>
            <table class="layui-table">
                <colgroup>
                    <col width="200">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>处理时间</th>
                    <th>处理结果</th>
                    <th>处理人</th>
                    <th>备注</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${dealRecords}" var="deal">
                <tr>
                    <td><fmt:formatDate value="${deal.dealTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                    <td><c:if test="${deal.dealResult==0}">通过</c:if>
                        <c:if test="${deal.dealResult==1}">打回</c:if>
                        <c:if test="${deal.dealResult==2}">否决</c:if></td>
                    <td>${deal.user.userName}</td>
                    <td>${deal.dealInfo}</td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="page">
                <%@include file="adminPage.jsp" %>
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
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
    function databasebackup() { $.ajax({
        url: "${pageContext.request.contextPath}/product/databasebackupzan",
        type: "post",
        datatype: "json",
        success: function(result)
        { if(result=="success")
        { alert('Success','数据库备份成功！'); }
        else{alert('Error','数据库备份失败！'); } } }) }
</script>

